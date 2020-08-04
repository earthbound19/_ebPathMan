:: DESCRIPTION
:: Adds custom paths to the System PATH environment variable (Windows), permanently. Must be run from a command prompt with administrative privileges to do so.

:: DEPENDENCIES
:: - modpath.exe, which is in the same directory of this script
:: - RELATIVEPATHS.txt and ABSOLUTEPATHS.txt, as customized for any folder you place them in and run this script from, and as detailed under USAGE.

:: USAGE
:: In any folder for which you wish to permanently add the path of that folder and/or folders inside it to your System PATH environment variable, place these files:
:: - RELATIVEPATHS.txt, which is a list of directories inside the folder, written as paths relative to the folder, and which you want to also add permanetly to your Sytem PATH environment variable. If you list nothing in this file, only the directory that contains this file will be added permanently to the System PATH variable. See the example file of that name in this repository.
:: - ABSOLUTEPATHS.txt, which is a list of absolute (or full) paths to directories you wish to have added to your System (permanent) PATH, one path per line of the file. See also the example file of that name in this repository.
:: Both of these files should have Windows-style paths (using backslashes (\) and/or drive letter indicators with colons like C:\. You do not need to surround any paths with quote marks if they have spaces in them; this script does that dynamically.
:: With those files in place and in the format described, and with this script either copied to the directory you wish to run this script from, or with this script in your System PATH, open a cmd prompt to the directory with these files, and run it:
::    _addToSystemPATH.bat
:: NOTES
:: - It may be preferable to not use this script, as in some (all?) situations, the permanent System variable has a hard upper length limit, and errors happen if you attempt to exceed it. You may wish to instead use getDevEnv.sh, getAllDevEnvs.sh, and/or _getDevEnv.bat, all of which dynamically alter the cmd prompt/terminal path per run, and do not permanently alter the System PATH.
:: - This batch will DELETE from the System PATH any paths in those files which do not actually exist, via modpath.exe
:: - Paths added dynamically to PATH are added _before_ it, so that any executables or scripts etc. added to the PATH via this script will be found by the cmd prompt system before files of the same name that may appear in other paths, and the cmd prompt will use the ones first found (they will have precedence).


:: CODE
ECHO OFF
:: Wipe log for new run:
type NUL > setPathsLog.txt
ECHO    ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
:: START RELATIVE PATHS MANAGEMENT
ECHO %PATH% > PATH_backup.txt
:: Fix potential line ending problems if copied files were modified on other platforms (which might have caused non-windows line endings) ; re: https://stackoverflow.com/a/27844521/1397555
TYPE RELATIVEPATHS.txt | MORE /P > allPathsTemp_apzQT6sZHA5dm6.txt
SET CURRDIR=%CD%
:: Because the root of project folders is also often wanted:
modpath.exe /add %CURRDIR%
ECHO --ADDED to PATH: %CURRDIR% >> setPathsLog.txt
:: Echo a blank line RE a genius breath yonder: https://stackoverflow.com/a/20696885/1397555
ECHO[ >> setPathsLog.txt
ECHO[
ECHO Will work from RELATIVEPATHS.txt . . .
ECHO ADDS/REMOVES from RELATIVEPATHS.txt: >> setPathsLog.txt
ECHO Added root project folder to PATH: %CURRDIR%
SETLOCAL ENABLEDELAYEDEXPANSION
:: Without the quote marks around path names it adds directories that include spaces ( ) just fine. It will work if %%A doesn't have quote marks.
FOR /F "DELIMS=*" %%A IN (allPathsTemp_apzQT6sZHA5dm6.txt) DO (
	:: DELETE RELATIVE PATHS that aren't found:
	SET CHECKPATH="%CURRDIR%\%%A"
	ECHO Will check for !CHECKPATH! . . .
	IF NOT EXIST !CHECKPATH! modpath /del !CHECKPATH!
	IF NOT EXIST !CHECKPATH! ECHO --NOT FOUND so removed from PATH: !CHECKPATH! >> setPathsLog.txt
	:: ADD RELATIVE PATHS that are found:
	IF EXIST !CHECKPATH! modpath.exe /add !CHECKPATH!
	IF EXIST !CHECKPATH! ECHO ---------FOUND and added to PATH: !CHECKPATH! >> setPathsLog.txt
)
:: END RELATIVE PATHS MANAGEMENT

:: START ABSOLUTE PATHS management
:: Same manipulations as for RELATIVEPATHS.txt:
ECHO[ >> setPathsLog.txt
ECHO[
ECHO Will work from ABSOLUTEPATHS.txt . . .
ECHO ADDS/REMOVES from ABSOLUTEPATHS.txt: >> setPathsLog.txt
TYPE ABSOLUTEPATHS.txt | MORE /P > tmp_ABSOLUTEPATHS_29HN7TMFWKHYPj.txt
FOR /F "DELIMS=*" %%A IN (tmp_ABSOLUTEPATHS_29HN7TMFWKHYPj.txt) DO (
	ECHO Will check for "%%A" . . .
	IF NOT EXIST "%%A" modpath /del "%%A"
	IF NOT EXIST "%%A" ECHO --NOT FOUND so removed from PATH: "%%A" >> setPathsLog.txt
	IF EXIST "%%A" modpath.exe /add "%%A"
	IF EXIST "%%A" ECHO ---------FOUND and added to PATH: "%%A" >> setPathsLog.txt
)
:: END ABSOLUTE PATHS management

:: Delete temp files:
DEL allPathsTemp_apzQT6sZHA5dm6.txt tmp_ABSOLUTEPATHS_29HN7TMFWKHYPj.txt
ECHO[
ECHO    ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
ECHO DONE. All finds/not finds/deletes/adds to path were logged to setPathsLog.txt.
ECHO[

:: DEVELOPMENT HISTORY:
:: 2020-08-03:
:: - per removal of GNU coreutils executable and dlls, remove lines that use those (we can get away with not using them)
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