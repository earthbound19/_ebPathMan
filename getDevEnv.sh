# DESCRIPTION
# Sets an environment path containing all paths in ./RELATIVEPATHS.txt (the file read local to whatever path your terminal is at now) for the current shell.

# USAGE
# CD to the dir containing this script, and execute the command:
# source ./thisScript.sh
#
# SUGGESTED USAGE
# TO MAKE THE PATH which contains this script available in your path automagically on terminal launch, from this directory first run:
# ./addThisPathToProfile
# -- which will permanently add the path of this script to your user ~/.bash_profile. Per the instructions in that script, you may then need to run this command to manually reload your shell with the new $PATH:
# source ~/.bash_profile
# AFTER THAT STEP, you may conveniently include any toolchain paths specified in any ./RELATIVEPATHS.txt file (in any directory) by invoking the following command:
# source getDevEnv.sh

# DEV NOTES
# I had the done < RELATIVEPATHS.txt line reading from that file as ./RELATIVEPATHS.txt; why I don't know: maybe it needs that on some platforms and not on others? TO DO: check on different platforms.

# TO DO:
# Have script check platform and replace stupid Windows \ with / if 'nix platform.

_pwd_=$(pwd)

while read -r line
do
	# echo --
	# addPathToDir="$_pwd_"/"$line"
	# echo addPathToDir value\:
	# echo $addPathToDir
	# echo ~~
	echo adding path to \$PATH\:
	echo $line
	export PATH="$PATH:$addPathToDir"
# MAYBE NEEDED on some platforms and not others: ./ before read file? :
# done < ./RELATIVEPATHS.txt
done < RELATIVEPATHS.txt

# echo
# echo ----
# echo TEMPORARY ENVIRONMENT PATHS SET DONE. The new \$PATH is\:
# echo $PATH
# echo
# echo You may test the new environment for visibility of a script in the paths you just added by executing the command\:
# echo
# echo which scriptName.sh
# echo
# echo "NOTE: if the PATH to a script exists in your \$PATH (try the command 'echo \$PATH' to see if the containing folder of that script is indeed in your \$PATH), but the script does not appear via 'which scriptName.sh', there may be permission problems\, and if so ensure that all .sh files in your intended PATHS are executable."
# echo

# HISTORY

# BEFORE NOW
# Things.
# 2017 apr 12 refactored for better cross-platform compatibility.
# 2017-06-07 Tweaked for new repo with this toolset and fixed up comments for clarity.
# 2017-11-20 reworked comments with SUGGESTED USAGE for clarity, for my own sake ;) and others'.