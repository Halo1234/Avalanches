# -*- coding: cp932 -*-
#
# *.xls �t�@�C���Ȃǂ�P���ȍs��Ƃ��Ĉ������߂̃��W���[��
# ����ɂ� MicroSoft Excel �܂��� OpenOffice calc �̂ǂ��炩���K�{�ƂȂ�܂��B
#
# NOTE:
# ���̓��ɁA�J���[�ݒ肮�炢�͑Ή����邩������Ȃ�
#
# NOTE:
# OpenOffice �̓���� Apatch OpenOffice (AOO) �Ŋm�F���Ă��܂��B
# LebreOffice (LibO) �ł����삷�邩������܂��񂪁A����m�F�͂��Ă��܂���B
#
# FIXME:
# MS-Office �̓A�v���P�[�V�������ƂɃT�[�r�X�T�[�o��������Ă��邪
# OpenOffice �͕�����Ă��Ȃ��̂ōœK���ΏۂɂȂ��Ă���B
# ���݂� Excel �ȊO�ɗp���Ȃ��̂Ŗ���T�[�o������������B

require 'win32ole'


#---
module ModSimpleXlsx

public

	#---
	# �P�������ꂽ�Z��
	# ��{�I�ɂ͂��ׂẴZ���𕶎���Ƃ��Ĉ������ɂ���B
	# ��̃Z���Ɋւ��Ă� nil �Ƃ��邪 Cell �N���X�ɂ͊֌W���Ȃ��B
	#
	# NOTE:
	# �Z�����̂���₱�����̂ŁA���̃N���X�̎d�l�͕ύX�����\�������X����B
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
	# ���V�[�g
	#
	# NOTE:
	# �����̔z��ł��B
	# Cell �Ɠ������ύX�����\��������܂��B
	class Sheet < Array

	public
		attr_accessor :name

		def initialize(name)
			if(!name.instance_of?(String))
				raise TypeError.new('�������ɂ̓V�[�g�̖��O�𕶎���Ŏw�肵�Ă��������B')
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
			# �ʓ|�Ȃ̂� Excel �����݂��Ȃ��ƍl���邪
			# �{���͂܂��߂Ƀ`�F�b�N���ׂ��B
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
				# ������ƂȂ񂩂��������Ȃ�B
				# ��̂��Ȃ��Ă����H�H�H
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

				# �g�p�͈͂�I��
				cursor = sheet.createCursor()
				cursor.gotoStartOfUsedArea(false)
				cursor.gotoEndOfUsedArea(true)

				# �͈͂̃A�h���X�𓾂�
				address = cursor.getRangeAddress()
				nCols = address.EndColumn - address.StartColumn + 1
				nRows = address.EndRow - address.StartRow + 1

				# �ǂݍ���
				nRows.times { |i|

					record = []
					nCols.times { |j|
						cell = cursor.getCellByPosition(j, i)
						# FIXME:
						# �ʓ|�Ȃ̂Ń[���iCellContentType::EMPTY�j�Ŕ�r���邪�{���͂܂���
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
			# �������̂���Ɠ��삪���������Ȃ�B
			# ��̂��Ȃ��Ă����́H�H�H
			#desktop.dispose() if desktop != nil
			# FIXME:
			# ���������ǂ�����ĉ�̂����炢���́H
			#fileProvider.dispose() if fileProvider != nil
		end

		return result

	end

end


