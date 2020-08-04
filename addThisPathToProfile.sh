# DESCRIPTION
# ADDS THE CURRENT path permanently to your $PATH. Possibly must be run with admin priveleges (e.g. sudo on mac or various linux). NOTE that after this has been done for the path which contains this script, since this script is then in the path, the same can be done from any other path, by calling this script.

# USAGE
# ./thisScript.sh

# TO DO:
# Adapt to this fact: "You should use ~/.profile instead." Re: https://askubuntu.com/questions/510709/i-cannot-find-bash-profile-in-ubuntu
# - How to use that instead/or? Deduce platform by existence or non-existence of platform-specific environment variables--and alter path by platform-specific methods?
# Re: https://ss64.com/nt/syntax-variables.html
# For windows: %SYSTEMROOT%?
# For macOS: ?
# For linux: ? specifics for different distros e.g. lubuntu? Can get all via `printenv > env.txt`. Candidates? : DEFAULTS_PATH, PATH, DESKTOP_SESSION, HOME, LOGNAME


# CODE
thisDir=`pwd`

# IF THERE IS no .bash_profile in the home dir, create one:
if [ ! -a ~/.bash_profile ]
then
  touch ~/.bash_profile
fi

echo export PATH=$thisDir:\$PATH >> ~/.bash_profile
# NOTE that the following may do no good; you may have to invoke that command separately after running this script:
source ~/.bash_profile
