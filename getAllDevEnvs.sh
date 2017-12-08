# DESCRIPTION
# Sets up a lot of temporary, customizable project paths for development. This script reads a list of project root paths from ~/projectsRootPaths.txt, and navigates to each of them in turn and invokes getDevEnv.sh for that path

# THIS IS A STUB. IN DEVELOPMENT.

while read -r element
do
  echo $element
done < ~/projectsRootPaths.txt


# TANGENT: you can determine platform with the following commands:
# uname
# echo $OSTYPE