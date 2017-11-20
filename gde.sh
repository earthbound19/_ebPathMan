# DESCRIPTION
# Sets an environment path containing all paths in ./RELATIVEPATHS.txt for the current shell.

# USAGE
# CD to the dir containing this script, and execute the command:

# source ./thisScript.sh

# To conveniently invoke this script from the home dir of your terminal, copy e.g. the following two lines of code to gde.sh in your home dir:

# cd "$USERPROFILE\Documents\scrap\_devtools-master"
# source ./thisScript.sh

# -- and then when you open your terminal (at the home dir), type:
# source ./gde.sh
# -- and you will now have a prompt with all paths in RELATIVEPATHS.txt .

while read -r line
do
			# echo line is $line
	_pwd_=$(pwd)
	addPathToDir="$_pwd_"/"$line"
	export PATH="$PATH":"$addPathToDir"
done < ./RELATIVEPATHS.txt

echo ----------------
echo TEMPORARY ENVIRONMENT PATHS SET DONE.

# HISTORY

# BEFORE NOW
# Things.
# 2017 apr 12 refactored for better cross-platform compatibility.
# 2017-06-07 Tweaked for new repo with this toolset and fixed up comments for clarity.