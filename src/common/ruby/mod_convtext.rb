# -*- coding: cp932 -*-


#---
class TextConverterBase

public
	attr_accessor :verbose, :input_encoding, :output_encoding

	def initialize(input_encoding, output_encoding)
		@verbose = false
		@input_encoding = input_encoding
		@output_encoding = output_encoding
	end

	def convert_to(input, output)
		raise NotImplementedError.new
	end

	def configure(key_or_hash, value = nil)
		if(key_or_hash.instance_of?(Hash))
			if(value != nil)
				raise ArgumentError.new('configure(Hash) �� configure(String key, Object value) �̂ǂ��炩�B���ł��B')
			end
			key_or_hash.each_pair { |k, v|
				self.send(:"#{k}=", v)
			}
		elsif(key_or_hash.instance_of?(String))
			self.send(:"#{key_or_hash}=", value)
		else
			raise TypeError.new('configure(Hash) �� configure(String key, Object value) �ǂ��炩�̌`���Ŏw�肵�Ă��������B')
		end
	end

	#---
	# verbose �� true �̎��� message �� print ���܂�
	def puts_v(message)
		puts message if @verbose
	end

end

#---
class TextConverter < TextConverterBase

public
	def initialize(input_encoding, output_encoding)
		super(input_encoding, output_encoding)
	end

end


