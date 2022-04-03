SET C_PATH=%CD%
IF NOT EXIST %~dp0n00b-Engine MKLINK /J n00b-Engine %~dp0..\n00b-Engine
cd %C_PATH%\..\n00b-Engine
MKLINK /J bkg %C_PATH%\bkg
MKLINK /J font %C_PATH%\font
MKLINK /J gfx %C_PATH%\gfx
MKLINK /J music %C_PATH%\music
MKLINK /J sfx %C_PATH%\sfx
MKLINK /J sprite %C_PATH%\sprite
MKLINK /J stage %C_PATH%\stage
MKLINK /J tile %C_PATH%\tile
