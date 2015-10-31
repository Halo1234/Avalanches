# -*- coding: cp932 -*-


#---
# TODO:
# 入力の候補を複数持てるようにしたい。
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
	# 状態をリセットしてスタート状態に戻します。
	def reset()
		@current = @root
		@input_denied = false
		@input_data.clear()
	end

	#---
	# 拒否状態をキャンセルします。
	# 最後に入力された拒否状態のきっかけになった入力を返します。
	#
	# 拒否状態ではなかった場合は nil を返します。
	def cancel_deny_input()
		if(@input_denied)
			@input_denied = false
			return @input_data.pop()
		end
		return nil
	end

	def add_state_transition(transition, id)
		if(!transition.instance_of?(Array))
			raise TypeError.new('第一引数には状態遷移を表す配列を指定してください。')
		end
		if(!id.instance_of?(Symbol))
			raise TypeError.new('第二引数にはシンボルを指定してください。')
		end

		if(transition.length == 0)
			puts ' 空の遷移の追加は無視されます。'
			return false
		end

		node = @root
		last = nil
		transition.each { |input|

			case
			when input =~ /[　\f\t ]/
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
			raise RuntimeError.new('開始状態が終了状態になりました。')
		end
		last[:state] = id

		#puts "'#{id}'"
	end

	def input(ch)
		if(@input_denied)
			return false
		end

		@input_data << ch

		if(ch =~ /　\f\t /)
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
			# :***_loop_point にマッチした場合は状態を遷移させない
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


