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
# thisScript.sh

# TO DO:
# Have script check platform and replace stupid Windows \ with / if 'nix platform.

while read -r line
do
	echo ~~
	echo adding path to \$PATH\:
	echo $line
	_pwd_=$(pwd)
	addPathToDir="$_pwd_"/"$line"
	echo ~~
	echo addPathToDir value\:
	echo $addPathToDir
	export PATH="$PATH":"$addPathToDir"
done < ./RELATIVEPATHS.txt

echo ----------------
echo TEMPORARY ENVIRONMENT PATHS SET DONE. The new \$PATH is\:
echo $PATH
echo Test the new environment for visibility of a script in the paths you just added by executing the command\:
echo which scriptName.sh

# HISTORY

# BEFORE NOW
# Things.
# 2017 apr 12 refactored for better cross-platform compatibility.
# 2017-06-07 Tweaked for new repo with this toolset and fixed up comments for clarity.
# 2017-11-20 reworked comments with SUGGESTED USAGE for clarity, for my own sake ;) and others'.