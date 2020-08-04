# _ebPathMan

## DESCRIPTION
Toolset to simplify either permanent or dynamic changes to Windows and Unix-variants PATH. Can get any viable path (for example one that has scripts or binaries you want to use) into the PATH of your terminal/cmd/what-have-you.

## DEPENDENCIES

- For Windows, a Unix-like environment as provided by Cygwin or MSYS2 (MSYS2 is preferred), to make use of the bash (`.sh`) scripts. Or, if you prefer (I probably don't), the `.bat` scripts.
- For any Unixy environment, nothing other than that environment, that I'm aware, other than some of these scripts expecting the existence of a `~/.bash_profile` file in your user root dir, which could be an erred assumption (I understand that a variety of profile definition files exist for Unixes).

## INSTALLATION AND USAGE

Clone this repo:

    git clone https://github.com/earthbound19/_ebPathMan

Open a terminal to the path you have cloned it into, and examine the comments in any of the following scripts to see how to use them.

### Dynamic PATH modification

#### Unixes etc.

- `getDevEnv.sh`
- `getAllDevEnvs.sh` (uses the former in a loop)

#### Windows

- `_getDevEnv.bat`

### Permanent PATH modification

#### Unixes etc.

- `addThisPathToProfile.sh`.

#### Windows

- `_addToSystemPATH.bat`
- `modpath.exe` is great for adding to the system PATH environment variable. I found it in the uninstall folder of ImageMagick for Windows, but I don't know where it is from originally (if not from ImageMagick). The `_addToSystemPATH.bat` script uses `modpath.exe`.
- `PathEditor.exe` is a handy-dandy application with a graphical user interface that makes editing environment variables easy. I didn't create this tool.
- `setenv.exe` is great for creating new system (or any context) environment varaibles with their values. I think I got it [from here](https://www.codeproject.com/Articles/12153/SetEnv).