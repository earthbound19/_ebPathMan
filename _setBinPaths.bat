ECHO OFF

REM DESCRIPTION: _setBinPaths.bat adds custom paths to the system PATH (Windows), permanently. MUST BE RUN FROM ADMINISTRATOR command prompt. NOTE: BINPATHS.txt must have a blank line after the last entry, or this batch will fail (and combined two intended defferent lines on the same line in a result). [DESCRIBE MORE WHEN THIS SCRIPT IS DONE.] Reads from BINPATHS.txt and EXTERNALPATHS.txt, which you may populate with custom paths, one per line, no semicolon. Adds the paths in those files to the system PATH variable (Windows), and optionally deletes invalid paths, using the modpath.exe utility.

REM DEPENDENCIES: The modpath.exe tool which I found in the uninstall folder of ImageMagick :) and I don't know where it's from. I presume (perhaps unwisely) that it's free software.

REM LICENSE: I release this work to the Public Domain. 09/24/2015 09:18:03 PM -RAH

REM TO DO? : port this to a .sh script and deprecate this .bat.
REM TO DO: handle EXTERNALPATHS.txt separately (but still in this batch). See IN DEVELOPMENT section.

REM =========================
REM START RELATIVE PATHS MANAGEMENT

REM Just in case, that'll be there:
SET CURRDIR=%CD%

ECHO %PATH% > PATH_backup.txt

REM the magic uniqify and sort commands:
gsort RELATIVEPATHS.txt > temp.txt
	REM NOTE: I'd had the -u flag on the next line; that messes up my intent (it does not print lines that have duplicates, it only prints unique lines. FACE PALM. ALSO: after I RT_M I learned it only detects *adjacent* duplicate lines. GEH!
guniq temp.txt > allPathsTemp.txt
REM ECHO Ready to modify PATH.

SET CURRDIR=%CD%
REM Because this script is intended to be run also from other directories with their own custom RELATIVEPATHS.txt setup, and using the binaries in this repo:
modpath.exe /add "%CURRDIR%"
ECHO Added directory to PATH: "%CURRDIR%"

FOR /F "delims=*" %%A IN (allPathsTemp.txt) DO (
			REM ECHO PATH IN QUESTION IS:
			REM ECHO %%A
	REM Optional, if you want this to clean up invalid paths in the list which you may have in your path PATH already ;) :
	REM NOTE: If you don't want this deleting anything in the path, comment out the next two lines!
	IF NOT EXIST "%CURRDIR%\%%A" modpath /del "%CURRDIR%\%%A"
	IF NOT EXIST "%CURRDIR%\%%A" ECHO Deleted invalid directory in PATH: "%CURRDIR%\%%A" >> setPathsLog.txt
	IF NOT EXIST "%CURRDIR%\%%A" ECHO Could not find path: "%CURRDIR%\%%A" >> setPathsLog.txt
	IF EXIST "%CURRDIR%\%%A" ECHO Found path: "%CURRDIR%\%%A" >> setPathsLog.txt
REM NOTE: without the quote marks on the next line, it won't add directories that include spaces ( ). It will work if the first %%A doesn't have quote marks (and will mess up sorting if they do, it seems--odd).
	IF EXIST "%CURRDIR%\%%A" modpath.exe /add "%CURRDIR%\%%A"
	IF EXIST "%CURRDIR%\%%A" ECHO Added directory to PATH: "%CURRDIR%\%%A"
)

DEL temp.txt temp2.txt allPathsTemp.txt
REM END RELATIVE PATHS MANAGEMENT
REM =========================


REM =========================
REM START ABSOLUTE PATHS management
FOR /F "delims=*" %%A IN (ABSOLUTEPATHS.txt) DO (
	IF NOT EXIST "%%A" modpath /del "%%A"
	IF NOT EXIST "%%A" ECHO Deleted invalid directory in PATH: "%%A" >> setPathsLog.txt
	IF NOT EXIST "%%A" ECHO Could not find path: "%%A" >> setPathsLog.txt
	IF EXIST "%%A" ECHO Found path: "%%A" >> setPathsLog.txt
REM NOTE: without the quote marks on the next line, it won't add directories that include spaces ( ). It will work if the first %%A doesn't have quote marks (and will mess up sorting if they do, it seems--odd).
	IF EXIST "%%A" modpath.exe /add "%%A"
	IF EXIST "%%A" ECHO Added directory to PATH: "%%A"
)
REM END ABSOLUTE PATHS management
REM =========================


REM DEVELOPMENT HISTORY:
REM 2015 09 25? -- First version?
REM 2015-11-12 Bug fix to include necessary paths on run (had assumed so many .exes were in the same path.
REM 2015-12-20 Add bug comment to comments at start of file
REM 05/31/2017 10:17:59 AM severely minor tweaks
REM 06/07/2017 08:31:11 PM Refactored to operate on relative paths in RELATIVEPATHS.txt (as opposed to absolute) --it will prepend the current (wherever this repo is extracted) to the RELATIVEPATHS for every path mod operation. It will also load and make path change operations based on any RELATIVEPATHS.txt local to whatever directory this script is executed from (after this script itself has been added to the system or user PATH). Renamed BINPATHS.txt to RELATIVEPATHS.txt and EXTERNALPATHS to ABSOLUTEPATHS.txt