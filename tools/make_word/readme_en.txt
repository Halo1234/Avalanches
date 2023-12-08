--- what is this?
  This is a tool that generates word data for typing games from specified Excel files.

--- How to use

  1. Copy /src/data/sample_typing_words/words.xls and rename the file.
  Open the file created in 2.1 and enter the word data.
  3. Open run.bat or run_cp932.bat and change ..\..\src\data\sample_typing_words\words.xls to the file name created in step 1.
  4. Run run.bat or run_cp932.bat.

  If you are using Kirikiri 2, please specify cp932 for --output-encoding.
  For Kirikiri Z, please specify UTF-8 for --output-encoding.

  --cf=config_en.ini usually does not need to be changed.

  Copy the output file to the development environment and run it from the script.
  @load_typing_words storage=filename.dic
  Load it as .


--- information

  $ruby make.rb -h


