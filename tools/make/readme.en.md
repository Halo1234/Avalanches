## What is this?
It is a tool that creates master data and patches.

## How to Use

Edit 1.config.ini file.
Copy the 2.test.bat and rename the file to something descriptive (MyGame.bat for illustration).
３． Open the MyGame.bat in the editor.
４． Replace the MyGame.bat target (goki2) with MyGame.
５． Perform MyGame.bat.

The result of the execution is a folder called work_MyGame, which can be ignored.
Eventually, the final binary (master data, etc.) is output to /dist/MyGame/.

## Miscellaneous

If the source of your project is in /src/MyGame, the target will be "MyGame".

![Target](../../make_target_folder.png)

Also, the folder where you want to install binaries and other things should be located under /src/data/products/MyGame/.

![Target](../../make_resouce.png)

For more information about which binaries to install, see /src/data/products/readme.txt.

You can also create an update program for the final binary.
The contents of this update program are managed by a sequential number starting with 1.
For more information, see the description in the UPDATEINFO section of config.ini.
By the way, I use Subversion logs to collect diff files.
Therefore, Subversion is required to create patches.
See /readme.txt for more information.

For more detailed instructions, see Help.

`ruby make.rb -h`

## Dependencies

RubyGem inifile >= 2.0.2

How to install:
Press Windows key + R and type cmd to enter
In the Command Prompt, type the following and enter

`gem install inifile`
