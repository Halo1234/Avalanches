# -*- coding: cp932 -*-


#---
class CmdParser

	#---
	def CmdParser.parse(params)

		elm = {}

		params.each { |arg|
			key = '@'

			if arg =~ /(^-[^-].*)/
				elm[key = $1] = true
			elsif arg =~ /(^--[^=]*)=(.*)/
				elm[key = $1] = $2
			else
				elm[key] = arg
			end

			#puts "'#{key} = #{elm[key]}'\n"
		}

		return elm

	end

end

#---
class CmdParam

	#---
	def initialize(params)
		@elm = CmdParser.parse(@params = params)
	end

	#---
	def each(&block)
		@elm.each { |key, value| block.call([key, value]) }
	end

	#---
	def [](key)
		@elm[key]
	end

	#---
	def []=(key, value)
		@elm[key] = value
	end

end


