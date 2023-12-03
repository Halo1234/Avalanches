
--- what is this?
This is a program for converting scenario text into a script file.
Create a scenario in a predetermined format
You can then convert it into a script file using this tool.


--- How to use
  1. Create a working folder in this folder.
  2. Copy the scenario text to your working folder.
  3. Edit config.ini. The explanation is written in config.ini.
  4. Copy sample.bat.
  5. Open the copied .bat file in an editor.
  6. 1. Where sample is written in the contents of the .bat file. Change the folder name to the one you created.
  7. Specify the conversion execution command for Kirikiri Z or Kirikiri 2.

      @rem For Kirikiri Z, please use this.
      ruby convks.rb .\conv_sample.list --o=.\output_sample --input-encoding=cp932 --output-encoding=UTF-8 -v
      @rem For Kirikiri 2, please use this.
      @rem ruby convks.rb .\conv_sample.list --o=.\output_sample --input-encoding=cp932 -v

  8. Run the .bat file you copied.


--- others
  You can also set the output destination directly to the development environment.
  This will forcefully overwrite files that have already been typed.
  I think it would be terrible if that happened.
  You can still revert if you use SVN/GIT, but I don't recommend it.

  Please refer to the help for detailed usage information.

  $ruby convks.rb -h


--- Dependencies
  RubyGem inifile >= 2.0.2

  Installation method:
   $gem install inifile


