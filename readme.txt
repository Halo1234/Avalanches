

--- Table of contents

・Table of contents
・Introduction
・Supported Opperating Systems
・Explanations of main folders
・Softwares recommended to install
・License
・Contact


--- Introduction

This file provides a minimum explanation about the contents included in the folder where this file is located, 
as well as external dependency programs necessary for executing/editing/managing the contents.

Avalanches (hereinafter referred to as the development environment) is constructed by multiple softwares.

It is not necessary to install recommended softwares, 
but it is advisable to install it unless there is a specific reason not to.



--- Supported Operating Systems

This development environment has been confirmed to operate in the following environments:

32bit Windows XP(SP3)/Vista/7/10
64bit Windows 7/10/11



--- Explanations of main folders

For convenience, we will denote the folder where this file is located as '/'. 
For example, if there is a notation like '/foo,' it refers to a file named 'foo' within the folder where this file is placed. 
Similarly, the notation '/foo/bar' refers to a file named 'bar' inside the 'foo' folder.

 /doc/
 Manuals and related documents are located here.

 /dist/
 Master data is generated here.

 /src/
 Source code is located here.

 /src/goki2/
 Source code for GOKI2.
 Running /src/goki2/run.bat launches the test script. 
 Executing /src/goki2/run_krkr2.bat launches Kirikiri 2 instead of KirikiriZ.
 If you want to add an automatic search path, please add a line denoting the path to krkr_autopath.ary.

 /tools/
 All tools are included here.

 /tools/game_editor/
 SLG Editor.
 Items and characters can be edited here.

 /tools/convgs/
 Converts scenario text into script.

 /tools/make/
 Master data creation tool.

 /tools/make_roman_table/
 Tool for creating a Romanization table for a typing game.

 /tools/make_word/
 Tool for creating word data for a typing game.



--- Softwares recommended to install


>>--------------------------------------
>> TortoiseGit
>>
>> Used to acquire this development environment.
>>
>> https://tortoisegit.org/


>>--------------------------------------
>> TortoiseSVN
>>
>> Convenient to have.
>> Since it reads Subversion logs for patch creation, 
>> it is recommended to install it if you want to create patches.
>>
>>
>> ・TortoiseSVN（English）
>>   https://tortoisesvn.net/
>>
>> ・TortoiseSVN（Japanese）
>>   https://ja.osdn.net/projects/tortoisesvn/


>>--------------------------------------
>> Subversion client
>>
>> Required for creating patches.
>> Not required if you are not planning to create patches.
>>
>> ・SLIKSVN
>>   https://sliksvn.com/download/


>>--------------------------------------
>> Office application
>>
>> Required for data input and data generation.
>> Not necessary to install if it is not required for you.
>>
>> ・[Paid] Microsoft Office Suite
>>   Fee required to use MSOffice.
>>   Excel is required specifically because some data input relies on .xls/.xlsx files.
>>
>>
>> ・Apache OpenOffice
>>   http://www.openoffice.org/ja/
>>
>>   Similarly, Calc is required for input/output with .xls/.xlsx files.
>>   However, as of October 28, 2012, it seems that output in *.xlsx format is not possible.
>>   If your purpose is limited to data generation and reading, this alone should be sufficient.
>>
>>   I have confirmed that it operates with version 4.1.2.
>>
>>
>> ・LibreOffice
>>   http://libreoffice.org/
>>
>>   Similarly, Calc is required for input/output with .xls/.xlsx files.
>>
>>   This should work, but it has not been tested yet.
>>   Therefore, it is not recommended.


>>--------------------------------------
>> Ruby
>>
>> Required for executing .rb files.
>> It is required for running tools,
>> however if you do not use them, then installing is not required.
>>
>> ・Ruby
>>   http://www.ruby-lang.org/
>>
>>   Developed with version 2.2.3.
>>
>>   Confirmed working on version 3.0.1.
>>   Confirmed working on version 3.2.2.


>>--------------------------------------
>> NSIS
>>
>> Required for creating an installer.
>> Not necessary to install if not required for you.
>>
>> ・NSIS
>>   https://nsis.sourceforge.io/Download
>>
>>   Confirmed working on version 3.06.1.
>>   Confirmed working on version 3.08.



--- License
License same as in Kirikiri2.



--- Contact
mailto:halosuke@gmail.com

http://halo.doorblog.jp/



