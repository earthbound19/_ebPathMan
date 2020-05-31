# DESCRIPTION
# Sets an environment path containing all paths in ./RELATIVEPATHS.txt (the file read local to whatever path your terminal is at now) for the current shell.

# USAGE
# CD to the dir containing this script, and execute the command:
# source ./getDevEnv.sh
#
# SUGGESTED USAGE
# TO MAKE THE PATH which contains this script available in your path automagically on terminal launch, from this directory first run:
# ./addThisPathToProfile
# -- which will permanently add the path of this script to your user ~/.bash_profile. Per the instructions in that script, you may then need to run this command to manually reload your shell with the new $PATH:
# source ~/.bash_profile
# AFTER THAT STEP, you may conveniently include any toolchain paths specified in any ./RELATIVEPATHS.txt file (in any directory) by invoking the following command:
# source getDevEnv.sh

# TO DO:
# Have script replace any \ with /. Modify all toolsets that use this script to define paths with / and assume this script will correct that on the fly.


# CODE
_pwd_=$(pwd)
# Before adding subpaths via RELATIVEPATHS.txt, add the current path:
export PATH="$PATH":"$_pwd_"

# Loop over RELATIVEPATHS.txt and add paths listed in it to $PATH:
while IFS= read -r line || [ -n "$line" ]
do
	# There is so much wrong with the following necessity: reverse windows backslashes, trim windows newlines so that the result isn't clobbered:
	line=`echo $line | gsed 's/\\\\/\//g' | tr -d '\15\32'`
	addPathToDir="$_pwd_"/"$line"
    export PATH=$addPathToDir:$PATH
done < RELATIVEPATHS.txt


# HISTORY
# 2020-01-14 delete cluttered echo statements.
# 2018-04-17 It wasn't working? Fixed (by simplifying?) and path ordering in final $PATH better.
# 2018-02-13 Add current path before iterating over RELATIVEPATHS.txt
# 2018-02-12 Mystified at why this didn't work and now it does (on Mac) after haggling with it.
# BEFORE NOW
# Things.
# 2017 apr 12 refactored for better cross-platform compatibility.
# 2017-06-07 Tweaked for new repo with this toolset and fixed up comments for clarity.
# 2017-11-20 reworked comments with SUGGESTED USAGE for clarity, for my own sake ;) and others'.