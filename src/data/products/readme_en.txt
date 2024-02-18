/**
**/



--- table of contents

  ÅEtable of contents
  ÅEDescription of this folder
  ÅEAbout special file names in the install/master/update folder


--- Description of this folder

You can create a make tool target within this folder.
The contents of the target folder will be as follows.

  +--+ [target-name]
     +---+ [header-images]
     + +---+ page_header_l.bmp
     + +---+ page_header_r.bmp
     + +---+ side_banner.bmp
     + +---+ unpage_header_l.bmp
     + +---+ unpage_header_r.bmp
     + +---+ inside_banner.bmp
     +
     +---+ [icons]
     + +---+ installer.ico
     + +---+ uninstaller.ico
     +
     +---+ [install]
     + +---+ optional
     +
     +---+ [key]
     + +---+ priv
     + +---+ pub
     +
     +---+ [master]
     + +---+ optional
     +
     +---+ [update]
     + +---+ optional
     +
     +---+override.ini

target-name becomes the argument to /tools/make/make.rb.
See /tools/make/readme.txt for more information.

The header-images folder contains header images and files used by the installer/uninstaller.
  Place banner images, etc.

Place icons for installers/uninstallers, etc. in the icons folder.

Place the additional binary data you want to install in the install folder.
  All contents of this folder, including subfolders, will be installed as-is.

Place the signature key file in the key folder.
  Copy and paste your private key into priv.
  Copy and paste the public key into pub.

Place the binaries that you want to add to the master data in the master folder.
  All contents of this folder, including subfolders, will be included in the master data as is.

Place the binary data, etc. that you want to add to the update program in the update folder.
  All contents of this folder, including subfolders, will be included in the update program as is.

override.ini overrides each item in /tools/make/config.ini.
  For details, see the explanation of each item in /tools/make/config.ini.

--- About special file names in the install/master/update folder

Within these folders, some file names have special meanings.

  [readme.txt]
   The make tool performs simple text substitutions on this file.
   The syntax of the replaced text is as follows:

   #{SECTION-NAME.VALUE-NAME}

   SECTION-NAME is the section name defined in config.ini or override.ini.
   VALUE-NAME is the name of the value defined in config.ini or override.ini.
   The appropriate text in readme.txt will be replaced with the appropriate value.

   Additionally, the following values are replaced with built-in values that are not defined in config.ini or override.ini:

    #{UPDATEINFO.log}
     Among the log values defined in config.ini or override.ini from UPDATE1 to UPDATEn
     A collection of log values in the range specified at packaging time.

     For example, if UPDATE1 to UPDATE5 are defined in override.ini,
     And when UPDATE1 to UPDATE3 are packaged.
     #{UPDATEINFO.log} will be replaced with the text that combines the log values from UPDATE1 to UPDATE3.

  [krkr.*]
   The krkr portion of the file name is replaced with the target name.
   If krkr is part of the file name, nothing will be done.
   This means that the file krkrHoge.exe will remain krkrHoge.exe.


