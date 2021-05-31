# -*- coding: cp932 -*-

require 'mod_simple_xlsx.rb'
require 'mod_utils.rb'


#---
class XlsxHeaderItem < String

public
	attr_reader :header_name, :element_name

	def initialize(name, element_name = nil)
		@header_name = name
		@element_name = element_name
		if(element_name != nil)
			super("#{name}(#{element_name})")
		else
			super(name)
		end
	end

	def header_name=(string)
		@header_name = string
		if(@element_name != nil)
			replace("#{@header_name}(#{@element_name})")
		else
			replace(@header_name)
		end
	end

	def element_name=(string)
		@element_name = string
		if(@element_name != nil)
			replace("#{@header_name}(#{@element_name})")
		else
			replace(@header_name)
		end
	end

end

#---
# �Ȉ� *.xls/*.xlsx/*.ods �R���o�[�^
#
# �g���g���̎����z��̔z��ɕϊ����ďo�͂��邽�߂̂��̂ł��B
# load() �𒼐ڌĂяo���Ύ蓮�ŕϊ����鎖���ł��܂��B
class XlsxConverter

public
	attr_accessor :ignore_nil, :ignore_nil_row, :first_row_is_header, :collect_in_file, :file_extension
	attr_accessor :file_header, :output_encoding
	attr_reader :data_header

	def initialize(output_encoding)
		@ignore_nil = false
		@ignore_nil_row = false
		@first_row_is_header = false
		@collect_in_file = false
		@file_extension = ''
		@file_header = nil
		@output_encoding = output_encoding
		@data_header = []
	end

	def configure(string_or_hash, value = nil)
		if(string_or_hash.instance_of?(Hash))
			if(value != nil)
				raise ArgumentError.new('configure(Hash) �� configure(String key, Object value) �̂ǂ��炩�B���ł��B')
			end
			string_or_hash.each_pair { |k, v|
				self.send(:"#{k}=", v)
			}
		elsif(string_or_hash.instance_of?(String))
			self.send(:"#{string_or_hash}=", value)
		else
			raise TypeError.new('configure(Hash) �� configure(String key, Object value) �ǂ��炩�̌`���Ŏw�肵�Ă��������B')
		end
	end

	def convert_to(input, output_dir, filename_table = nil)
		sheets = load(input)

		sources = {}
		sheets.each { |sheet|

			sources[sheet.name] = []

			first_line = true
			sheet.each { |row|

				if(@ignore_nil_row && row.count(nil) == row.size)
					next
				end

				is_header_line = false

				if(first_line)
					first_line = false
					if(@first_row_is_header)
						is_header_line = true
						@data_header.clear()
						row.each { |cell|
							@data_header << XlsxHeaderItem.new(cell)
						}
					end
				end

				if(block_given?)
					yield(row, is_header_line)
				end

				if(is_header_line)
					next
				end

				elements = []
				row.each_index { |i|

					if(@ignore_nil && row[i] == nil)
						next
					end

					if(data_header[i].element_name == nil)
						elements << "'#{data_header[i].header_name}'=>string('#{row[i]}')"
					else
						elements << "'#{data_header[i].element_name}'=>string('#{row[i]}')"
					end

				}

				MakeUtils.puts(source = "%[#{elements.join(', ')}]")

				sources[sheet.name] << source
			}

		}

		if(@collect_in_file)
			File.open(output_dir, 'w+') { |file|
				# TODO: �ЂƂ̃t�@�C���ɂ܂Ƃ߂�
				#
				# %[ sheet1 : [...], sheet2 : [...] ]
			}
		else
			sources.each { |key, source|
				path = ""
				if(filename_table == nil || filename_table[":#{key}"] == nil)
					path = "#{output_dir}/#{key}#{@file_extension}"
				else
					path = "#{output_dir}/#{filename_table[":#{key}"]}#{@file_extension}"
				end
				File.open(path, "w+:#{@output_encoding.name}") { |file|
					file << @file_header if @file_header != nil
					file << "[\n\t"
					file << source.join(",\n\t")
					file << "\n]"
				}
			}
		end

	end

	def load(input)
		ModSimpleXlsx.load(input)
	end

end


