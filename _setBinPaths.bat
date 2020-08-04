:: DESCRIPTION
:: Adds custom paths to the System PATH environment variable (Windows), permanently. Must be run from a command prompt with administrative privileges to do so.

:: DEPENDENCIES
:: - modpath.exe, which is in the same directory of this script
:: - RELATIVEPATHS.txt and ABSOLUTEPATHS.txt, as customized for any folder you place them in and run this script from.

:: LICENSE: I wrote this and I dedicate this to the Public Domain.

:: USAGE
:: In any folder which you wish to add to your SYSTEM PATH, place these files:
:: - RELATIVEPATHS.txt, which is a list of directories relative to the folder which you wish to have added to your System PATH envrionment variable.
:: - ABSOLUTEPATHS.txt, which is a list of absolute paths to directories you wish to have added to your System PATH environment variable.
:: Both of these files should have Windows-style paths (using backslashes (\) and/or Drive indicators with colons like C:\.
:: NOTES
:: This batch will DELETE from the System PATH any paths in those files which do not actually exist, via modpath.exe

:: CODE
ECHO OFF
:: TO DO
:: - figure out why it doesn't find that paths are invalid (and delete them from PATH) in relative path add loop. (Verify that that is happening also)
:: I have contradictory notes and usage in this script: some say !CHECKPATH! (!AA!) ? doesn't work; others say %%A works. Which is it? Or is it both?
:: - port this to a .sh script and deprecate this .bat?

:: DEVELOPER NOTES
:: Without the quote marks around path names it add directories that include spaces ( ). It will work if the first %%A doesn't have quote marks (and will mess up sorting if they do, it seems--odd).

:: Wipe log for new run; it's beyond silly that I haven't found a way to echo nothing to a new file:
ECHO    ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
ECHO Blanking log file . . .
COPY NUL setPathsLog.txt

:: START RELATIVE PATHS MANAGEMENT
ECHO %PATH% > PATH_backup.txt
:: fix potential line ending problems if copied files were modified on other platforms (which might have caused non-windows line endings) ; re: https://stackoverflow.com/a/27844521/1397555
TYPE RELATIVEPATHS.txt | MORE /P > allPathsTemp_apzQT6sZHA5dm6.txt
SET CURRDIR=%CD%
:: Because the root of project folders is also often wanted:
modpath.exe /add %CURRDIR%
ECHO --ADDED to PATH: %CURRDIR% >> setPathsLog.txt
ECHO[ >> setPathsLog.txt
ECHO[
ECHO Working from RELATIVEPATHS.txt . . .
ECHO ADDS/REMOVES from RELATIVEPATHS.txt: >> setPathsLog.txt
ECHO Added root project folder to path: %CURRDIR%
setlocal enabledelayedexpansion
FOR /F "delims=*" %%A IN (allPathsTemp_apzQT6sZHA5dm6.txt) DO (
	:: DELETE RELATIVE PATHS that aren't found:
	SET CHECKPATH=%CURRDIR%\%%A
	ECHO Operating on !CHECKPATH! . . .
	IF NOT EXIST !CHECKPATH! modpath /del !CHECKPATH!
	IF NOT EXIST !CHECKPATH! ECHO --NOT FOUND so removed from PATH: !CHECKPATH! >> setPathsLog.txt
	:: ADD RELATIVE PATHS that are found:
	IF EXIST !CHECKPATH! modpath.exe /add !CHECKPATH!
	IF EXIST !CHECKPATH! ECHO ---------FOUND and added to PATH: !CHECKPATH! >> setPathsLog.txt
)
:: END RELATIVE PATHS MANAGEMENT

:: START ABSOLUTE PATHS management
:: same manipulations as for RELATIVEPATHS.txt:
ECHO[ >> setPathsLog.txt
ECHO[
ECHO Working from ABSOLUTEPATHS.txt . . .
ECHO ADDS/REMOVES from ABSOLUTEPATHS.txt: >> setPathsLog.txt
TYPE ABSOLUTEPATHS.txt | MORE /P > tmp_ABSOLUTEPATHS_29HN7TMFWKHYPj.txt
FOR /F "delims=*" %%A IN (tmp_ABSOLUTEPATHS_29HN7TMFWKHYPj.txt) DO (
	ECHO Operating on "%%A" . . .
	IF NOT EXIST "%%A" modpath /del "%%A"
	IF NOT EXIST "%%A" ECHO --NOT FOUND so removed from PATH: "%%A" >> setPathsLog.txt
	IF EXIST "%%A" modpath.exe /add "%%A"
	IF EXIST "%%A" ECHO ---------FOUND and added to PATH: "%%A" >> setPathsLog.txt
)
:: END ABSOLUTE PATHS management

:: Delete temp files:
DEL allPathsTemp_apzQT6sZHA5dm6.txt tmp_ABSOLUTEPATHS_29HN7TMFWKHYPj.txt
:: RE a genius breath yonder: https://stackoverflow.com/a/20696885/1397555
ECHO[
ECHO    ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
ECHO DONE. All finds/not finds/deletes/adds to path were logged to setPathsLog.txt.
ECHO[

:: DEVELOPMENT HISTORY:
:: 2020-08-03:
:: - per removal of GNU coreutils exes, remove lines that use those (we can get away with not using them)
:: - use a DOS/Windows exe to convert line endings to dos (allows removal of unix2dos.exe
:: - went through my code and realized I did things  . . . correctly :)
:: - remove echo to stdout of info on add/remove paths
:: - layout echo to log file for paths to be column-aligned
:: - improve doc comments per convention
:: 2020-01-15 09:57 AM:
:: - simplify log entries
:: - Add trailing newlines to copied path list temp files instead of admonishing to have those in source files.
:: - Change newlines to windows-style in temp files (in case they have unix newlines from edits on other platforms)
:: - Remove vestigal temp file delete.
:: - also sort/dedup ABSOLUTEPATHS.txt.
:: - Don't add %CD% to paths any more; add abs. path to this project to ABSOLUTEPATHS.txt for this project instead.
:: - used !DELAYEDVARIABLEEXPANSION! in relative paths add loop, as that seemed not to work otherwise?! For how long?!
:: 2017 06 07 08:31:11 PM Refactored to operate on relative paths in RELATIVEPATHS.txt (as opposed to absolute) --it will prepend the current (wherever this repo is extracted) to the RELATIVEPATHS for every path mod operation. It will also load and make path change operations based on any RELATIVEPATHS.txt local to whatever directory this script is executed from (after this script itself has been added to the system or user PATH). Renamed BINPATHS.txt to RELATIVEPATHS.txt and EXTERNALPATHS to ABSOLUTEPATHS.txt
:: 2017 05 31 10:17:59 AM severely minor tweaks
:: 2015-12-20 Add bug comment to comments at start of file
:: 2015-11-12 Bug fix to include necessary paths on run (had assumed so many .exes were in the same path.
:: 2015 09 25? -- First version?