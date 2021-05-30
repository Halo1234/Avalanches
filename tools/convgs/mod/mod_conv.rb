# -*- coding: cp932 -*-

require 'mod_convtext.rb'
require 'mod_simple_automaton.rb'


#---
class PartText < String

public
	attr_reader :source_string, :destination_string

	def initialize(string)
		if(string =~ /->/)
			tokens = string.split(/->/)
			if(tokens.length > 2)
				raise ArgumentError.new("-> �ϊ��悪��������܂����B\n '#{string}'")
			end
			@source_string = tokens[0]
			@destination_string = tokens[1]
			super(string)
		else
			@source_string = string
			@destination_string = string
			super("#{string}->#{string}")
		end
	end

	def source_string=(string)
		@source_string = string
		self.replace("#{@source_string}->#{@destination_string}")
	end

	def destination_string=(string)
		@destination_string = string
		self.replace("#{@source_string}->#{@destination_string}")
	end
end

class Token < String

public
	attr_reader :token_id

	def initialize(token, token_id)
		super(token)
		@token_id = token_id
		freeze()
	end

end

#---
# �ȈՃp�[�T
class SimpleConverter < TextConverterBase

public
	attr_accessor :character_name_separator, :strip_brackets
	attr_accessor :begin_brackets, :end_brackets
	attr_accessor :comment_line_sequence
	attr_accessor :anonymous_text, :anonymous_text_character
	attr_accessor :warning_only_name_appears
	attr_accessor :default_saying

	attr_reader :main_characters

	def initialize(input_encoding, output_encoding)
		super(input_encoding, output_encoding)
		@character_name_separator = ""
		@main_characters = []
		@strip_brackets = false
		@begin_brackets = []
		@end_brackets = []
		@comment_line_sequence = ""
		@anonymous_text = 0
		@anonymous_text_character = ""
		@warning_only_name_appears = true
		@default_saying = ""
	end

	def convert_to(input, output)

		puts "#{input} is convert to #{output}"

		begin_brackets = @begin_brackets.clone()
		end_brackets = @end_brackets.clone()
		begin_brackets.uniq!
		end_brackets.uniq!
		begin_brackets.each { |bb|
			if(bb != '')
				if(end_brackets.include?(bb))
					raise RuntimeError.new("���� '#{bb}' ���J�����ʂ������ʂ��B���ł��B")
				end
			end
		}

		# �v���p�e�B�`�F�b�N
		if(@anonymous_text == 1)
			raise RuntimeError.new("anonymous_text �� 1 ���ݒ肳��Ă��܂��B\n���̋@�\�͌��ݗ��p�ł��܂���B")
		end
		if(@anonymous_text == 2 && @anonymous_text_character == "")
			raise RuntimeError.new('anonymous_text �� 2 ���ݒ肳��Ă��܂��� anonymous_text_character ���w�肳��Ă��܂���B')
		end
		if(begin_brackets.length != end_brackets.length)
			raise RuntimeError.new("�J�����ʂƕ����ʂ̐��������܂���B\n�J�����ʁF'#{@begin_brackets}'\n�����ʁF'#{end_brackets}'")
		end

		lex = SimpleAutomaton.new()

		# �����͐ݒ�
		if(!@character_name_separator.empty?)
			# N_SEP �` N_SEP
			lex.add_state_transition(
				[@character_name_separator, :wild, @character_name_separator],
				:character_name_sep
			)
			# N_SEP �` (CR)LF
			lex.add_state_transition(
				[@character_name_separator, :wild, :crlf],
				:character_name_crlf
			)
			# N_SEP �` BB
			begin_brackets.each { |bb|
				lex.add_state_transition(
					[@character_name_separator, :wild, bb],
					:character_name_bb
				)
			}
		end
		begin_brackets.each_index { |i|
			# BB �` EB
			lex.add_state_transition(
				[begin_brackets[i], :wild, end_brackets[i]],
				:text_bb_eb
			)
		}
		# �e�L�X�g�݂̂̍s
		lex.add_state_transition([:wild, :crlf], :text_crlf)
		# �R�����g
		if(!@comment_line_sequence.empty?)
			# C �` (CR)LF
			arr = @comment_line_sequence.split(//)
			arr << :wild
			arr << :crlf
			lex.add_state_transition(arr, :comment_crlf)
		end
		lex.add_state_transition([:white_space], :white_space)
		lex.add_state_transition([:crlf], :crlf)

		tokens = []

		# �ǂݍ��݁����
		File.open(input, "r:#{input_encoding.name}") { |file|

			lex.reset()
            eof = false

			ch = file.getc()
			line_number = 0

			begin

				while ch != nil

					if(input_encoding != __ENCODING__)
						ch.encode!(__ENCODING__)
					end

					if(!lex.input(ch))
						raise RuntimeError.new("#{ch}(#{ch.ord}) �s���ȃg�[�N��������܂����B\n'#{lex.input_data.join(nil)}'")
					end

					case(lex.state?)
					when :character_name_sep
						text = lex.input_data.join(nil)
						tokens << Token.new(@text[1, text.length - 2], :token_character_name)
						lex.reset()
					when :character_name_crlf
						text = lex.input_data.join(nil)
						tokens << Token.new(text[1, text.length - 2], :token_character_name)
						tokens << Token.new("\n", :token_crlf)
						line_number += 1
						lex.reset()
					when :character_name_bb
						text = lex.input_data.join(nil)
						tokens << Token.new(text[1, text.length - 2], :token_character_name)
						lex.reset()
						next # Attention
					when :text_bb_eb
						text = lex.input_data.join(nil)
						tokens << Token.new(text[0], :token_bb)
						tokens << Token.new(text[1, text.length - 2], :token_text)
						tokens << Token.new(text[text.length - 1], :token_eb)
						lex.reset()
					when :text_bb_crlf
						text = lex.input_data.join(nil)
						tokens << Token.new(text[0], :token_bb)
						tokens << Token.new(text[1, text.length - 2], :token_text)
						tokens << Token.new("\n", :token_crlf)
						line_number += 1
						lex.reset()
					when :text_eb
						text = lex.input_data.join(nil)
						tokens << Token.new(text[0, text.length - 1], :token_text)
						tokens << Token.new(')', :token_eb)
						lex.reset()
					when :text_crlf
						text = lex.input_data.join(nil)
						tokens << Token.new(text[0, text.length - 1], :token_text)
						tokens << Token.new("\n", :token_crlf)
						line_number += 1
						lex.reset()
					when :comment_crlf
						text = lex.input_data.join(nil)
						tokens << Token.new(text[0, text.length - 1], :token_comment)
						tokens << Token.new("\n", :token_crlf)
						line_number += 1
						lex.reset()
					when :white_space
						tokens << Token.new(lex.input_data.join(nil), :token_white_space)
					when :crlf
						tokens << Token.new("\n", :token_crlf)
						line_number += 1
						lex.reset()
					end

					ch = file.getc()
                    if(!eof && ch == nil)
                        eof = true
                        ch = "\n"
                    end

				end

			rescue
				puts 'Warning:'
				puts "line #{line_number}:\n#{$!.message}"
				puts '--------------'
			end

			# NOTE:
			# �����ɗ������ɓ��͂��c���Ă���Ƃ������͉��������������B
			# ���A�x�����o���ăf�[�^���e�L�X�g�Ƃ��ď�������B
			if(lex.state? != :start)
				text = lex.input_data.join(nil)

				puts 'Warning:'
				puts ' �F���ł��Ȃ��e�L�X�g������܂����� TEXT �g�[�N���Ƃ��Ĉ����܂��B'
				puts " >> #{text}"
				puts '--------------'

				tokens << Token.new(text, :token_text)
			end
		}

		tokens.collect! { |token|

			if(token.token_id != :token_character_name)
				next token
			end

			# ���O�̑O��̋󔒂���������B
			str = token.gsub(/^[\s�@]*/, '')
			str.gsub!(/[\s�@]*$/, '')

			# ���O�͐������ɕϊ����Ă����B
			@main_characters.each { |mc|
				if(mc.source_string != str) then next end
				str = mc.destination_string
				break
			}

			# �g�[�N������蒼��
			Token.new(str, :token_character_name)

		}

		# NOTE:
		# ���u�L�����̃��X�g�����B
		mob_list = []
		tokens.each { |token|

			if(token.token_id != :token_character_name) then next end

			mob = true
			@main_characters.each { |mc|
				if(mc.destination_string == token)
					mob = false
					break
				end
			}
			if(mob && !mob_list.include?(token))
				mob_list << token
			end

		}

		# �o��
		File.open(output, "w+:#{output_encoding.name}") { |file|

			save_label = "*|\n"

			file << "*first_label|\n"
			file << ";>> An effective settings only in this file.\n"
			file << "; ���̃R�����g�͊O���v���O�����i��p�c�[���Ȃǁj��\n"
			file << "; �X�N���v�g��F�����邽�߂̖ڈ�ƂȂ��Ă��܂��B\n"
			file << "; ���̃R�����g���폜������ҏW�����肵�Ȃ��ł��������B\n"
			file << "\n"

			mob_list.each { |mob_name|
				file << "@mob name=#{mob_name}\n"
			}

			file << "\n"
			file << ";>> End of local settings.\n"

			token = nil
			line_number = 1
			last_name = ""
			last_name_line = 0
			bracket_opened = false
			text_flag = 0

			begin

				while !tokens.empty?

					token = tokens.shift()

					#if(token.token_id == :token_crlf)
					#	puts "'crlf'"
					#else
					#	puts "'#{token}'"
					#end

					case token.token_id
					when :token_white_space
						file << token
					when :token_crlf
						case text_flag
						when 1
							text_flag = 2
						when 2
							text_flag = 0
							last_name = ""
						end
						file << token
						line_number += 1
					when :token_comment
						file << ";#{token}"
					when :token_character_name
						if(bracket_opened)
							raise RuntimeError.new("���ʂ������Ă��Ȃ��䎌������܂��B")
						end
						if(!last_name.empty?)
							if(@warning_only_name_appears)
								puts 'Warning:'
								puts ' �L�����N�^�[�����䎌�����Ō���܂����B'
								puts " �s�F#{last_name_line}"
								puts " ���O�F#{last_name}"
								puts '--------------'
							end
							file << "#{@default_saying}\n"
						end
						file << save_label
						file << "[#{token}]"
						last_name = token.clone()
						last_name_line = line_number
					when :token_bb
						bracket_opened = true
						if(last_name.empty?)
							case @anonymous_text
							when 0
								file << ";#{token}"
							when 2
								file << save_label
								file << "[#{@anonymous_text_character}]"
								last_name = @anonymous_text_character.clone()
							end
						end
						file << token if !@strip_brackets
					when :token_eb
						if(!bracket_opened)
							raise RuntimeError.new("�����ʂ�����܂������J�����ʂ�����Ă��܂���B")
						end
						file << token if !@strip_brackets
						bracket_opened = false
					when :token_text
						if(last_name.empty?)
							case @anonymous_text
							when 0
								file << ";#{token}"
							when 2
								file << save_label
								file << "[#{@anonymous_text_character}]"
								last_name = @anonymous_text_character.clone()
							end
						end
						case text_flag
						when 0
							text_flag = 1
						when 2
							text_flag = 1
						end
						file << token
					else
						raise RuntimeError.new("'#{token}' ���m�̃g�[�N��������܂����B")
					end

				end

			rescue
				puts 'Warning:'
				puts "line #{line_number}:\n#{$!.message}"
				puts '--------------'
			end

		}
	end

	def main_characters=(array_or_string)
		if(array_or_string.instance_of?(Array))
			@main_characters.clear()
			array_or_string.each { |name|
				if(!name.instance_of?(String))
					raise TypeError.new("�z�񒆂ɕ�����ȊO������܂����Btype = '#{name.class}'")
				end
				name.gsub!(/^[\s�@]*/, '')
				name.gsub!(/[\s�@]*$/, '')
				@main_characters << PartText.new(name)
			}
		elsif(array_or_string.instance_of?(String))
		else
			raise TypeError.new(
				"������̔z��A�܂��͕�����Ń��C���L�����N�^�[�̖��O���w�肵�Ă��������B\narray_or_string = '#{array_or_string.class}'"
			)
		end
	end

end

#---
class ScenarioConverter

public
	attr_accessor :verbose

	attr_reader :advanced_mode, :input_encoding, :output_encoding

	def initialize(input_encoding, output_encoding)
		@verbose = false
		@input_encoding = input_encoding
		@output_encoding = output_encoding
		@converter = SimpleConverter.new(@input_encoding, @output_encoding)
	end

	def convert_to(input, output)
		@converter.convert_to(input, output)
	end

	def configure(key_or_hash, value = nil)
		@converter.configure(key_or_hash, value)
	end

	def engine
		@converter
	end

	def input_encoding=(input_encoding)
		if(@input_encoding != input_encoding)
			@input_encoding = input_encoding
			@converter.input_encoding = input_encoding
		end
	end

	def output_encoding=(output_encoding)
		if(@output_encoding != output_encoding)
			@output_encoding = output_encoding
			@converter.output_encoding = output_encoding
		end
	end

end


