/**
**/



--- what is this?
  A tool to create master data and patches.


--- How to use

  1. Edit the config_en.ini file.
  2. Copy test.bat and change the file name to something meaningful.
  3. Change goki2 in the bat contents copied in 2 to your project name.
  4. Run the bat you copied in 2.

  A folder called work_*** will be output as the execution result, but you can ignore this.
  Finally, the final binary (master data, etc.) is output to /dist/***/.


--- others

  See /src/data/products/readme.txt for names that can be specified for targets.

  You can also create an update program for the final binary.
  The contents of this update program are managed by sequential numbers starting from 1.
  See the description of the UPDATEINFO section in config_en.ini for details.
  By the way, Subversion logs are used to collect the difference files.
  Therefore, Subversion is required to create patches.
  See /readme.txt for more information.

  For other detailed usage information, please refer to the help.

  $ruby make.rb -h


--- Dependencies

  RubyGem inifile >= 2.0.2

  Installation method:
   $gem install inifile


