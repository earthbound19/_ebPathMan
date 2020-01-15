ECHO OFF

REM DESCRIPTION: _setBinPaths.bat adds custom paths to the system PATH (Windows), permanently. MUST BE RUN FROM ADMINISTRATOR command prompt. Reads from RELATIVEPATHS.txt and ABSOLUTEPATHS.txt, which must be in the directory you run this script from (and which may be used to batch set paths for various directories/projects), which files you may populate with custom paths, one per line, no semicolon. Adds the paths in those files to the system PATH variable (Windows), and optionally deletes invalid paths, using the modpath.exe utility.

REM DEPENDENCIES: The modpath.exe tool which I found in the uninstall folder of ImageMagick :) and I don't know where it's from. I presume (perhaps unwisely) that it's free software.

REM LICENSE: I release this work to the Public Domain. 09/24/2015 09:18:03 PM -RAH

REM TO DO:
REM - figure out why it always adds the root of a project even if that's not listed (happens in relative path add loop), and fix that
REM - figure out why it doesn't find that paths are invalid (and delete them from PATH) in relative path add loop.
REM - port this to a .sh script and deprecate this .bat?

REM =========================
REM START RELATIVE PATHS MANAGEMENT

ECHO %PATH% > PATH_backup.txt

REM the magic uniqify and sort commands:
gsort RELATIVEPATHS.txt > temp_W6CyuJ5aCCRGV4.txt
	REM NOTE: I'd had the -u flag on the next line; that messes up my intent (it does not print lines that have duplicates, it only prints unique lines. FACE PALM. ALSO: after I RT_M I learned it only detects *adjacent* duplicate lines. GEH!
guniq temp_W6CyuJ5aCCRGV4.txt > allPathsTemp_apzQT6sZHA5dm6.txt
REM if no trailing newline it concatenates two paths into one in PATH entry; SO:
REM echo only a newline character trick thanks to: https://stackoverflow.com/a/3123194/1397555
REM echo: >> allPathsTemp_apzQT6sZHA5dm6.txt
REM fix potential line ending problems if copied files were modified on
REM other platforms (which might have caused non-windows line endings) :
unix2dos allPathsTemp_apzQT6sZHA5dm6.txt

SET CURRDIR=%CD%

setlocal enabledelayedexpansion
FOR /F "delims=*" %%A IN (allPathsTemp_apzQT6sZHA5dm6.txt) DO (
	SET CHECKPATH=%CURRDIR%\%%A
	REM For reasons I don't fully understand, I can't use %CHECKPATH% and must use !CHECKPATH! :
	REM echo that is "!CHECKPATH!"
	REM The next two lines remove invalid directories from your PATH; comment them out if you don't want them! :
	IF NOT EXIST "!CHECKPATH!" modpath /del "!CHECKPATH!"
	IF NOT EXIST "!CHECKPATH!" ECHO --Did not find and so deleted invalid directory from PATH: "!CHECKPATH!" >> setPathsLog.txt
REM NOTE: without the quote marks on the next line, it won't add directories that include spaces ( ). It will work if the first %%A doesn't have quote marks (and will mess up sorting if they do, it seems--odd).
	IF EXIST "!CHECKPATH!" modpath.exe /add "!CHECKPATH!"
	IF EXIST "!CHECKPATH!" ECHO -Found relative path and added to PATH: "!CHECKPATH!"
)
REM END RELATIVE PATHS MANAGEMENT
REM =========================


REM =========================
REM START ABSOLUTE PATHS management

REM same manipulations as for RELATIVEPATHS.txt:
gsort ABSOLUTEPATHS.txt > tmp_ABSOLUTEPATHS_9nJbHt5WqaqdaS.txt
guniq tmp_ABSOLUTEPATHS_9nJbHt5WqaqdaS.txt > tmp_ABSOLUTEPATHS_29HN7TMFWKHYPj.txt
echo: >> tmp_ABSOLUTEPATHS_29HN7TMFWKHYPj.txt
REM fix potential line ending problems in temp file that may have been modded on other platform:
unix2dos tmp_ABSOLUTEPATHS_29HN7TMFWKHYPj.txt

REM I don't need to use !VARIABLE! in this loop, as "%%A" works for the loop variable:
FOR /F "delims=*" %%A IN (tmp_ABSOLUTEPATHS_29HN7TMFWKHYPj.txt) DO (
	IF NOT EXIST "%%A" modpath /del "%%A"
	IF NOT EXIST "%%A" ECHO --Did not find and so deleted invalid directory from PATH: "%%A"
REM NOTE: without the quote marks on the next line, it won't add directories that include spaces ( ). It will work if the first %%A doesn't have quote marks (and will mess up sorting if they do, it seems--odd).
	IF EXIST "%%A" modpath.exe /add "%%A"
	IF EXIST "%%A" ECHO -Found fixed path and added to PATH: "%%A"
)
REM END ABSOLUTE PATHS management
REM =========================

DEL temp_W6CyuJ5aCCRGV4.txt allPathsTemp_apzQT6sZHA5dm6.txt tmp_ABSOLUTEPATHS_29HN7TMFWKHYPj.txt


REM DEVELOPMENT HISTORY:
REM 2020-01-15 09:57 AM:
REM - simplify log entries
REM - Add trailing newlines to copied path list temp files instead of admonishing to have those in source files.
REM - Change newlines to windows-style in temp files (in case they have unix newlines from edits on other platforms)
REM - Remove vestigal temp file delete.
REM - also sort/dedup ABSOLUTEPATHS.txt.
REM - Don't add %CD% to paths any more; add abs. path to this project to ABSOLUTEPATHS.txt for this project instead.
REM - used !DELAYEDVARIABLEEXPANSION! in relative paths add loop, as that seemed not to work otherwise?! For how long?!
REM 2017 06 07 08:31:11 PM Refactored to operate on relative paths in RELATIVEPATHS.txt (as opposed to absolute) --it will prepend the current (wherever this repo is extracted) to the RELATIVEPATHS for every path mod operation. It will also load and make path change operations based on any RELATIVEPATHS.txt local to whatever directory this script is executed from (after this script itself has been added to the system or user PATH). Renamed BINPATHS.txt to RELATIVEPATHS.txt and EXTERNALPATHS to ABSOLUTEPATHS.txt
REM 2017 05 31 10:17:59 AM severely minor tweaks
REM 2015-12-20 Add bug comment to comments at start of file
REM 2015-11-12 Bug fix to include necessary paths on run (had assumed so many .exes were in the same path.
REM 2015 09 25? -- First version?