:: DESCRIPTION
:: Adds custom paths to the cmd prompt PATH temporarily (for that run of the cmd prompt).

:: DEPENDENCIES
:: - RELATIVEPATHS.txt and ABSOLUTEPATHS.txt, as customized for any folder you place them in and run this script from, and as detailed under USAGE.

:: USAGE
:: In any folder for which you wish to temporarily add the path of that folder and/or folders inside it to your cmd prompt PATH environment variable, place these files:
:: - RELATIVEPATHS.txt, which is a list of directories inside the folder, written as paths relative to the folder, and which you want to also add temporarily to your PATH. If you list nothing in this file, only the directory that contains this file will be added permanently to the System PATH variable. See the example file of that name in this repository.
:: - ABSOLUTEPATHS.txt, which is a list of absolute (or full) paths to directories you wish to have added to your PATH temporarily, one path per line of the file. See also the example file of that name in this repository.
:: Both of these files should have Windows-style paths (using backslashes (\) and/or drive letter indicators with colons like C:\. You do not need to surround any paths with quote marks if they have spaces in them; this script does that dynamically.
:: With those files in place and in the format described, and with this script either copied to the directory you wish to run this script from, or with this script in your System PATH, open a cmd prompt to the directory with these files, and run it:
::    _getDevEnv.bat
:: The script will print feedback on what was added or not added to the cmd prompt's temporary PATH environment variable.
:: NOTES
:: - It may be preferable to use this script and not _addToSystemPATH.bat, as in some (all?) situations, the permanent System variable has a hard upper length limit, and errors happen if you attempt to exceed it (which excessive adding to that PATH via _addToSystemPATH might do). This script (_getDevEnv.bat) avoids that problem by modifying the PATH environment variable dynamically and temporarily in the current run of the cmd prompt.
:: - Directory paths are added dynamically to %PATH% _before_ it, so that any executables or scripts etc. in the paths added (via this script) will be found by the cmd prompt before files of the same name that may appear in other paths, and the cmd prompt will use the ones first found (they will have precedence).


:: CODE
ECHO OFF
ECHO    ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
:: START PREPARE TO SET TEMPORARY RELATIVE PATHS
:: Fix potential line ending problems if copied files were modified on other platforms (which might have caused non-windows line endings) ; re: https://stackoverflow.com/a/27844521/1397555
TYPE RELATIVEPATHS.txt | MORE /P > allPathsTemp_xb5yjefRmejnjV.txt
SET CURRDIR=%CD%
:: Echo a blank line RE a genius breath yonder: https://stackoverflow.com/a/20696885/1397555
ECHO[
ECHO Will work from RELATIVEPATHS.txt . . .
SET PATH=%CURRDIR%;%PATH%
ECHO Added root project folder temporarily to PATH: %CURRDIR%
	:: NOTES about DOS scripting:
	:: - I do not know why DOS uses the value from a first pass in a loop in every subsequent iteration of it, and totally ignores application of changes to a variable. To me that seems to totally defeat the purpose of a loop. To me that actually seems fundamentally broken. And you have to use special syntax that means "No, I really meant to, like, _use_ the _changed_ value of the variable in each iteration of the loop." Gah! That's what setlocal enabledelayedexpansion and !variable! are; re: https://stackoverflow.com/a/23799543/1397555
	:: - ALSO, DOS refuses to modify the PATH environment variable in a loop, apparently. I must declare and set SOME OTHER variable, then use that to modify PATH, AFTER the loop! This is why I left DOS batch scripting behind and am only revisiting this becuase it might be nice to have this script.
SETLOCAL ENABLEDELAYEDEXPANSION
SET TO_ADD_TO_PATH=
:: Without the quote marks around path names it adds directories that include spaces ( ). It will work if %%A doesn't have quote marks.
FOR /F "DELIMS=*" %%A IN (allPathsTemp_xb5yjefRmejnjV.txt) DO (
	SET CHECKPATH=%CURRDIR%\%%A
	IF NOT EXIST !CHECKPATH! ECHO --NOT FOUND so not added dynamically to PATH: !CHECKPATH!
	IF EXIST !CHECKPATH! ECHO -------FOUND so will add dynamically to PATH: !CHECKPATH!
	IF EXIST !CHECKPATH! SET TO_ADD_TO_PATH=!CHECKPATH!;!TO_ADD_TO_PATH!
)
:: END PREPARE TO SET TEMPORARY RELATIVE PATHS

:: START PREPARE TO ADD TEMPORARY ABSOLUTE PATHS
:: Same manipulations as for RELATIVEPATHS.txt:
ECHO[
ECHO Will work from ABSOLUTEPATHS.txt . . .
TYPE ABSOLUTEPATHS.txt | MORE /P > tmp_ABSOLUTEPATHS_aXezAzgrmAzqrt.txt
SET ALSO_TO_ADD_TO_PATH=
FOR /F "DELIMS=*" %%A IN (tmp_ABSOLUTEPATHS_aXezAzgrmAzqrt.txt) DO (
	REM IF NOT EXIST %%A ECHO --NOT FOUND so not added dynamically to PATH: %%A
	IF EXIST %%A ECHO -------FOUND so will add dynamically to PATH: %%A
	IF EXIST %%A SET ALSO_TO_ADD_TO_PATH=%%A;!ALSO_TO_ADD_TO_PATH!
)
ECHO[
:: END PREPARE TO ADD TEMPORARY ABSOLUTE PATHS

:: DO THE ACTUAL TEMPORARY PATH MANIPULATION. AND SHOUT ABOUT IT. BECAUSE THIS IS DOS!!!
SET PATH=%TO_ADD_TO_PATH%%ALSO_TO_ADD_TO_PATH%%PATH%
ECHO NEW PATH IS: %PATH%

:: Delete temp files:
DEL allPathsTemp_xb5yjefRmejnjV.txt tmp_ABSOLUTEPATHS_aXezAzgrmAzqrt.txt
ECHO[
ECHO    ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
ECHO DONE with dynamic alter of PATH environment variable for current cmd prompt.
ECHO[
