# -*- coding: cp932 -*-


#---
# TODO:
# ���͂̌��𕡐����Ă�悤�ɂ������B
class SimpleAutomaton

public
	attr_reader :input_denied, :input_data

	def initialize()
		@root = {:state => :start, :map => {}}
		@current = @root
		@input_denied = false
		@input_data = []
	end

	#---
	# ��Ԃ����Z�b�g���ăX�^�[�g��Ԃɖ߂��܂��B
	def reset()
		@current = @root
		@input_denied = false
		@input_data.clear()
	end

	#---
	# ���ۏ�Ԃ��L�����Z�����܂��B
	# �Ō�ɓ��͂��ꂽ���ۏ�Ԃ̂��������ɂȂ������͂�Ԃ��܂��B
	#
	# ���ۏ�Ԃł͂Ȃ������ꍇ�� nil ��Ԃ��܂��B
	def cancel_deny_input()
		if(@input_denied)
			@input_denied = false
			return @input_data.pop()
		end
		return nil
	end

	def add_state_transition(transition, id)
		if(!transition.instance_of?(Array))
			raise TypeError.new('�������ɂ͏�ԑJ�ڂ�\���z����w�肵�Ă��������B')
		end
		if(!id.instance_of?(Symbol))
			raise TypeError.new('�������ɂ̓V���{�����w�肵�Ă��������B')
		end

		if(transition.length == 0)
			puts ' ��̑J�ڂ̒ǉ��͖�������܂��B'
			return false
		end

		node = @root
		last = nil
		transition.each { |input|

			case
			when input =~ /[�@\f\t ]/
				input = :white_space
			when input =~ /(\r\n|\n)/
				input = :crlf
			else
				input = :"#{input}"
			end
			node[:map][input] = {:map => {}} if node[:map][input] == nil
			#print "#{input}->"
			last = node = node[:map][input]
			node[:"#{input}_loop_point"] = true if input == :wild || input == :"#{input}_loop_point"

		}

		if(last[:state] == :start)
			raise RuntimeError.new('�J�n��Ԃ��I����ԂɂȂ�܂����B')
		end
		last[:state] = id

		#puts "'#{id}'"
	end

	def input(ch)
		if(@input_denied)
			return false
		end

		@input_data << ch

		if(ch =~ /�@\f\t /)
			ch = :white_space
		elsif(ch =~ /(\r\n|\n)/)
			ch = :crlf
		else
			ch = :"#{ch}"
		end

		if(@current[:map][ch] == nil)
			if(@current[:map][:wild] == nil && !@current[:wild_loop_point] && !@current[:"#{ch}_loop_point"])
				@input_denied = true
				return false
			end
			#print "#{ch}(*)->"
			# NOTE:
			# :***_loop_point �Ƀ}�b�`�����ꍇ�͏�Ԃ�J�ڂ����Ȃ�
			if(!@current[:wild_loop_point] && !@current[:"#{ch}_loop_point"])
				@current = @current[:map][:wild]
			end
			return true
		end
		@current = @current[:map][ch]
		#if(state?)
		#	puts state?
		#else
		#	print "#{ch}->"
		#end

		return true
	end

	def state?()
		if(@input_denied || @current[:state] == nil)
			return nil
		end
		return @current[:state]
	end

end


