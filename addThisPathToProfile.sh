# DESCRIPTION
# Adds the current directory permanently to your $PATH. Possibly must be run with admin priveleges (e.g. sudo on mac or various linux). 

# USAGE
# To get this script in your permanent $PATH so that you can use it from anywhere, open a terminal to the directory where you permanently store this script, and then run it with ./ in front of it:
#    ./addThisPathToProfile.sh
# Then you may restart your terminal, and navigate to any other directory, and with this script in your $PATH already (via the previous step), you may run this script without any indication of where it is, to add the directory you call it from to your $PATH. For example, if you wish to add the directory:
#    /bobsCyberPants
# To your $PATH, you will then be able to open a terminal and navigate to that directory:
#    cd /bobsCyberPants
# And run this script without any ./ or any other path prefix to indicate where it is (as it is already in your $PATH), to add /bobsCyberPants to your $PATH:
#    addThisPathToProfile.sh
# NOTES
# - I have activated the three-repetition-requires-four-or-more contingency. PATH, PATH, PATH, PATH. PATH. PATH! PATHY PATHY PATHY PATHY PATH! What is the path to Cyber Bob's pants? It is RIGHT HERE! /bobsCyberPants
# - It is strongly recommended that Bob's Cyber Pants be in your path. You have no idea what good things await you if they are.


# CODE
# TO DO:
# Adapt to this fact? "You should use ~/.profile instead." Re: https://askubuntu.com/questions/510709/i-cannot-find-bash-profile-in-ubuntu
# - How to use that instead/or? Deduce platform by existence or non-existence of platform-specific environment variables--and alter path by platform-specific methods?
# Re: https://ss64.com/nt/syntax-variables.html
# - For windows: %SYSTEMROOT%?
# - For macOS: ?
# - For linux: ? specifics for different distros e.g. lubuntu? Can get all via `printenv > env.txt`. Candidates? : DEFAULTS_PATH, PATH, DESKTOP_SESSION, HOME, LOGNAME
thisDir=`pwd`

# IF THERE IS no .bash_profile in the home dir, create one:
if [ ! -a ~/.bash_profile ]
then
  touch ~/.bash_profile
fi

echo export PATH=$thisDir:\$PATH >> ~/.bash_profile
# NOTE that the following may do no good; you may have to invoke that command separately after running this script:
source ~/.bash_profile
