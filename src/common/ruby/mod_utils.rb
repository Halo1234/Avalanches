# -*- coding: cp932 -*-

require "fileutils"
require "find"


class MakeUtils
	@@verbose = false

	#---
	def MakeUtils.puts(message)
		if @@verbose then print("#{message}\n") end
	end

	#---
	def MakeUtils.mkdir_p(dir)
		if !File.exist?(dir) || !File.directory?(dir)
			MakeUtils.puts("mkdir_p #{dir}")
			FileUtils.mkdir_p(dir)
			return true
		end
		return false
	end

	#---
	def MakeUtils.find_ignore_spdir(path)
		if block_given?
			reg = /^\./
			Find.find(path) { |item|
				Find.prune if File.basename(item) =~ reg
				yield item
			}
		end
	end

	#---
	def MakeUtils.find_ignore_subdir(path)
		if block_given?
			Find.find(path) { |item|
				next if path == item
				Find.prune if File.directory?(item)
				yield item
			}
		end
	end

	#---
	def MakeUtils.copy_to(src, dest)
		if FileUtils.uptodate?(src, [dest])
			MakeUtils.puts("Copy to '#{dest}' from '#{src}'")
			FileUtils.cp(src, dest)
			return true
		end
		return false
	end

	#---
	def MakeUtils.verbose=(value)
		@@verbose = value
	end

end


