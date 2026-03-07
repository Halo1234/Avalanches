## What is this?
This is a program for converting scenario text into script files.
If you create the scenario in a predetermined format beforehand,
you can then use this tool to convert it into a script file.

## How to use
1. Create a working folder in this folder and rename it to something easy to understand. (Here, we will use ***MyGame***)
2. Copy the scenario text into the ***MyGame*** folder.
3. Edit config.ini. Instructions are written in config.ini.
4. Copy sample.bat and give it an easy-to-understand name. (Here, we will use ***MyGame.bat***)
5. Open the ***MyGame.bat*** file in an editor.
6. In the contents of the ***MyGame.bat*** file, replace ***sample*** with ***MyGame***.
7. Specify the conversion execution command for Kirikiri Z or Kirikiri 2.

```bat:MyGame.bat
@rem For Kirikiri Z, please use this.
ruby convgs.rb .conv_MyGame.list --o=.output_MyGame --input-encoding=cp932 --output-encoding=UTF-8 -v
@rem For Kirikiri 2, please use this.
@rem ruby convgs.rb .conv_MyGame.list --o=.output_MyGame --input-encoding=cp932 -v
```

8. Save your edits and run MyGame.bat.

## Others
You can set the output destination directly to the development environment, but this will forcibly overwrite files, so if there are any files where input has already been completed, it could cause serious issues.
Even so, if you are using SVN/GIT, you can revert, but it is not highly recommended.

Please refer to the help for detailed usage.

$ruby convgs.rb -h

## Dependencies
RubyGem inifile >= 2.0.2

Installation method:
Press Windows Key + R, type cmd, and press Enter.
In the command prompt, type the following (do not include $) and press Enter:
$gem install inifile


