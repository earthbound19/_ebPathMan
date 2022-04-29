# DESCRIPTION
# Sets an environment path containing all paths in ./RELATIVEPATHS.txt (the file read local to whatever path your terminal is at now) for the current shell.

# DEPENDENCIES
# A Unixy environment.

# USAGE
# To make the path which contains this script available in your $PATH automagically on terminal launch, from this directory first run:
#    ./addThisPathToProfile.sh
# -- which will permanently add the path of this script to your user ~/.bash_profile. Per the instructions in that script, you may then need to run this command to manually reload your shell with the new $PATH:
#    source ~/.bash_profile
# After that step, you may conveniently include any toolchain paths specified in any ./RELATIVEPATHS.txt file (in any directory) by invoking the following command:
#    source getDevEnv.sh
# NOTES
# - SEE ALSO getAllDevEnvs.sh, which invokes this script repeatedly against a list of folders.
# - This script is written with the intent that the path containing it be included in your $PATH environment variable via manual add to ~/.bash_profile etc. But you may also add the path containing this script manually to $PATH via the terminal (by running the command PATH=/path/to_this_script/:$PATH, or open a terminal to the path containing this script (or a copy of it), and run it from that directory.
# - Directory paths are added dynamically to $PATH _before_ it, so that any executables or scripts etc. in the paths added (via this script) will be found by the terminal before files of the same name that may appear in other paths, and the terminal will use the ones first found (they will have precedence).


# CODE
# TO DO:
# Have script replace any \ with /. Modify all toolsets that use this script to define paths with / and assume this script will correct that on the fly.

_pwd_=$(pwd)
# Before adding subpaths via RELATIVEPATHS.txt, add the current path:
export PATH="$_pwd_":"$PATH"

# Loop over RELATIVEPATHS.txt and add paths listed in it to $PATH:
while IFS= read -r line || [ -n "$line" ]
do
	# There is so much wrong with the following necessity: reverse windows backslashes, trim windows newlines so that the result isn't clobbered:
	line=`echo $line | sed 's/\\\\/\//g' | tr -d '\15\32'`
	addPathToDir="$_pwd_"/"$line"
    export PATH=$addPathToDir:$PATH
done < RELATIVEPATHS.txt


# HISTORY

# ????-??-?? [and documented much later by patching a log from one branch to another]
# - REMOVE sed.exe et al, via script updates to no longer use them?? I don't remember how/why. 
# 2020-08-03 [yet documented much later by patching this log from one branch to another]
# - change gsed.exe [back??] to sed.exe (as dependency included in many Unixy environments or emulated environments)
# - put custom path includes before $PATH
# - improve doc comments
# 2020-01-14 delete cluttered echo statements.
# 2018-04-17 It wasn't working? Fixed (by simplifying?) and path ordering in final $PATH better.
# 2018-02-13 Add current path before iterating over RELATIVEPATHS.txt
# 2018-02-12 Mystified at why this didn't work and now it does (on Mac) after haggling with it.
# BEFORE NOW
# Things.
# 2017-04-12 refactored for better cross-platform compatibility.
# 2017-06-07 Tweaked for new repo with this toolset and fixed up comments for clarity.
# 2017-11-20 reworked comments with SUGGESTED USAGE for clarity, for my own sake ;) and others'.