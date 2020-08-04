# _ebPathMan

## DESCRIPTION
Toolset to simplify Windows and Unix-variants PATH management. Can get any path (for example one that has scripts or binaries you want to use) dynamically or permanently in the PATH which your terminal/cmd/what-have-you uses.

## DEPENDENCIES
For all platforms, git. For Windows, a Unix-like environment as provided by Cygwin or MSYS2 (the latter preferred), for the bash (`.sh`) scripts. For any of the scripts, any other dependencies they may list in their respective DEPENDENCIES comments

## INSTALLATION AND USAGE

Clone this repo:

    git clone https://github.com/earthbound19/_ebPathMan

Open a terminal to the path you have cloned it into, and examine the comments in and, if you think it's a good idea, depending, do this:

- Windows: clone and make use of `_setBinBaths.bat` from , which is designed to modify your SYSTEM PATH to include all relevant paths in this archive (or any archive that uses the setup expected by that batch).
- Mac and/or other 'Nixy environments (such as Cygwin or MSYS2 on Windows!) may make use of `getDevEnv.sh` and/or `getAllDevEnvs.sh` to dynamically get scripts in your PATH (in other words to alter a terminal run to become a development environment).
- See also `addThisPathToProfile.sh`.

Descriptions of some binaries in this repository, collected from other places:

`PathEditor.exe` is handy-dandy. It has a GUI. Double-click the program and you'll see. I didn't create this tool. As all files (that I'm aware of!) which end with .exe, it is a Windows executable.

`setenv.exe` is great for creating new system (or any context) environment varaibles with their values. I think I got it [from here](https://www.codeproject.com/Articles/12153/SetEnv).

`modpath.exe` is great for adding to the system PATH environment variable. I found it in the uninstall folder of ImageMagick for Windows, but I don't know where it is from originally (if not from ImageMagick).