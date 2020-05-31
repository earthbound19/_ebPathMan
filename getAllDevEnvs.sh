# DESCRIPTION
# Sets up a lot of temporary, customizable project paths for development. This script reads a list of project root paths from ~/projectsRootPaths.txt, and navigates to each of them in turn and invokes getDevEnv.sh for each. This in turn reads any expected RELATIVEPATHS.txt in each and adds all paths listed in that to the $PATH as well.

# USAGE
# source ./thisScript.sh

# NOTES
# The paths in RELATIVEPATHS.txt must be findable by the operating system if preceded only with a forwared slash /. ALSO, unless you invoke this script via `source` as given under USAGE, the temporarily modified $PATH won't "stick." SEE ALSO "DEPENDENCIES."

# DEPENDENCIES
# A nix' environment. This script must first be in your $PATH via manual add to ~/.bash_profile etc. or adding in on the command line, or invoking this script from the path containing it. A file ~/projectsRootPaths.txt with all desired root paths listed in it.


# CODE
# Save current path to come back to later:
# echo Saving current path with `pushd .` . . .
pushd .

while IFS= read -r element || [ -n "$element" ]
do
    # echo =======================
  cd /$element
    # echo listing contents of $element . . .
    # ls
  source getDevEnv.sh
    # echo -----------------------
done < ~/projectsRootPaths.txt

popd

echo "~ getDevEnv.sh has been run with each path listed in ~/projectsRootPaths.txt, respectively."