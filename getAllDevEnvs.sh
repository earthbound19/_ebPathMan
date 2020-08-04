# DESCRIPTION
# Sets up a lot of temporary, customizable project paths for development or use of scripts, binaries, etc in any path. This script reads a list of project root paths from ~/projectsRootPaths.txt, and navigates to each of them in turn and invokes getDevEnv.sh for each. This in turn reads any expected RELATIVEPATHS.txt in each and adds all paths listed in that to the $PATH as well.

# DEPENDENCIES
# A Unixy environment.

# USAGE
#    source getAllDevEnvs.sh
# NOTES
# - This script must first be in your $PATH via manual add to ~/.bash_profile etc. or adding in on the command line, or invoking this script from the path containing it. A file ~/projectsRootPaths.txt with all desired root paths listed in it.
# - The paths in RELATIVEPATHS.txt must be findable by the operating system if preceded only with a forwared slash / (like /path_to_something).
# - Unless you run this script via `source` as given under USAGE, the temporarily modified $PATH will not "stick:" it will only apply to this script's run, and will no longer exist when this script's execution terminates and returns to the calling shell. Calling it with "source" causes the modifications to stay in the shell after this scripts terminates. I may be describing this technically incorrectly. But anyway, using "source" does what you want. Not using it doesn't.


# CODE
# Save current path to come back to later:
# echo Saving current path with `pushd .` . . .
pushd .

while IFS= read -r element || [ -n "$element" ]
do
  cd /$element
    # echo =======================
    # echo listing contents of $element . . .
    # ls
  source getDevEnv.sh
    # echo -----------------------
done < ~/projectsRootPaths.txt

popd

echo "~ getDevEnv.sh has been run with each path listed in ~/projectsRootPaths.txt, respectively."