# -*- coding: cp932 -*-
#
# *.xls ファイルなどを単純な行列として扱うためのモジュール
# 動作には MicroSoft Excel または OpenOffice calc のどちらかが必須となります。
#
# NOTE:
# その内に、カラー設定ぐらいは対応するかもしれない
#
# NOTE:
# OpenOffice の動作は Apatch OpenOffice (AOO) で確認しています。
# LebreOffice (LibO) でも動作するかもしれませんが、動作確認はしていません。
#
# FIXME:
# MS-Office はアプリケーションごとにサービスサーバが分かれているが
# OpenOffice は分かれていないので最適化対象になっている。
# 現在は Excel 以外に用がないので毎回サーバを初期化する。

require 'win32ole'


#---
module ModSimpleXlsx

public

	#---
	# 単純化されたセル
	# 基本的にはすべてのセルを文字列として扱う事にする。
	# 空のセルに関しては nil とするが Cell クラスには関係がない。
	#
	# NOTE:
	# セル自体がややこしいので、このクラスの仕様は変更される可能性が多々ある。
	class Cell < String

	public
		#attr_accessor :color, :background_color

		def initialize(value)
			super(value.to_s)
		end

		def color=(color)
			raise NotImplementedError.new
		end

		def color()
			raise NotImplementedError.new
		end

		def background_color=(color)
			raise NotImplementedError.new
		end

		def background_color()
			raise NotImplementedError.new
		end

	end

	#---
	# 同シート
	#
	# NOTE:
	# ただの配列です。
	# Cell と同じく変更される可能性があります。
	class Sheet < Array

	public
		attr_accessor :name

		def initialize(name)
			if(!name.instance_of?(String))
				raise TypeError.new('第一引数にはシートの名前を文字列で指定してください。')
			end
			@name = name
			super()
		end

	end

	def ModSimpleXlsx.load(file_path)
		obj = nil
		file_path = File.expand_path(file_path)

		begin

			obj = WIN32OLE.new('Excel.Application')
			load_from_excel(obj, file_path)

		rescue WIN32OLERuntimeError

			# FIXME:
			# 面倒なので Excel が存在しないと考えるが
			# 本来はまじめにチェックすべき。
			if(obj != nil)
			   raise
			end

			begin

				obj = WIN32OLE.new('com.sun.star.ServiceManager')
				load_from_calc(obj, file_path)

			rescue WIN32OLERuntimeError

				raise

			ensure
				# FIXME:
				# これやるとなんかおかしくなる。
				# 解体しなくていい？？？
				#obj.dispose() if obj != nil
				obj = nil
			end

		ensure
			obj.quit() if obj != nil
			obj = nil
		end

	end

	def ModSimpleXlsx.save(file_path)
	end

private

	def ModSimpleXlsx.load_from_excel(obj, file_path)
		result = []

		begin
			doc = obj.workbooks.open({:filename=>file_path, :readOnly=>true})

			doc.worksheets.each { |sheet|

                puts "converte #{sheet.name}"

				table = ModSimpleXlsx::Sheet.new(sheet.name)
				sheet.Range("A1").CurrentRegion.rows.each { |row|

					record = []
					row.columns.each { |cell|
						if(cell.value == nil)
							record << nil
						else
							record << cell.value.to_s
						end
					}

					table << record

				}

				result << table

			}

		ensure
		end

		return result

	end

	def ModSimpleXlsx.load_from_calc(obj, file_path)
		scheme = 'file'
		desktop = nil
		fileProvider = nil
		result = []

		begin
			desktop = obj.createInstance('com.sun.star.frame.Desktop')
			fileProvider = obj.createInstance('com.sun.star.ucb.FileContentProvider')
			url = fileProvider.getFileURLFromSystemPath(scheme, file_path)

			# ReadOnly & Hidden properties
			readOnlyProperty = obj.bridge_getStruct('com.sun.star.beans.PropertyValue')
			readOnlyProperty.Name  = "ReadOnly"
			readOnlyProperty.value = true
			hiddenProperty = obj.bridge_getStruct('com.sun.star.beans.PropertyValue')
			hiddenProperty.name  = "Hidden"
			hiddenProperty.Value = true

			doc = desktop.loadComponentFromUrl(url, '_blank', 0, [hiddenProperty, readOnlyProperty])

			sheets = doc.getSheets()
			sheet_enum = sheets.createEnumeration()
			while(sheet_enum.hasMoreElements())

				sheet = sheet_enum.nextElement
				table = ModSimpleXlsx::Sheet.new(sheet.getName())

				# 使用範囲を選択
				cursor = sheet.createCursor()
				cursor.gotoStartOfUsedArea(false)
				cursor.gotoEndOfUsedArea(true)

				# 範囲のアドレスを得る
				address = cursor.getRangeAddress()
				nCols = address.EndColumn - address.StartColumn + 1
				nRows = address.EndRow - address.StartRow + 1

				# 読み込み
				nRows.times { |i|

					record = []
					nCols.times { |j|
						cell = cursor.getCellByPosition(j, i)
						# FIXME:
						# 面倒なのでゼロ（CellContentType::EMPTY）で比較するが本当はまずい
						if(cell.getType() != 0)
							record << cell.String
						else
							record << nil
						end
					}

					table << record

				}

				result << table

			end

		ensure
			# FIXME:
			# これも解体すると動作がおかしくなる。
			# 解体しなくていいの？？？
			#desktop.dispose() if desktop != nil
			# FIXME:
			# そもそもどうやって解体したらいいの？
			#fileProvider.dispose() if fileProvider != nil
		end

		return result

	end

end


