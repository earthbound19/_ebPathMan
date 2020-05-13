# _ebPathMan

## DESCRIPTION
Toolset to simplify Windows and 'nixy PATH management.

## INSTALLATION AND USAGE
Clone this repo and open a terminal to the path you have cloned it into, and examine the comments in and, if you think it's a good idea, run `_setBinPaths.bat`.

For now (if not always), refer to comments in that and other scripts in this repo.

`PathEditor.exe` is handy-dandy. It has a GUI. Double-click the program and you'll see. I didn't create this tool.

`gsed.exe`, `gsort.exe`, and `guniq.exe` in this repository are from MSYS2 (I'm unsure whether they run under 32-bit _and_ 64-bit Windows--I know they run under 64), but are renamed. If previous versions remain in git history, they may be from GnuWin32 and Cygwin.

`sed.exe` from Cygwin (which I had here as `gsed.exe` for a long time) causes problems interacting with other utilities if they expect unix line endings, as Cygwin's sed uses Windows line endings.

## TO DO
Document this toolset more clearly.

