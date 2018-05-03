# DESCRIPTION
# Updates the index for every file in a repo of .sh, .py, .bat, and .exe type to regard it executable, and also sets folder and file permissions to avoid permission changes triggering a git change detection.

# SEE ALSO
# http://www.lagentesoft.com/batchmod/

# NOTE
# This may not work as a script. You may have to copy and paste these commands from a root dir of so many scripts you want to grant execute permissions to, and prefix the commands with `sudo`. This is also kind of a crap shot at fixing anything--I don't understand what all these commands do, but I have tested this and permissions (finally!) show up correctly in a freshly cloned repo which has had this script run against it and then every file update added, committed and pushed. Still, you've been warned.


# CODE
find . -name '*.sh' -o -name '*.py' -print0 | xargs -0 chmod +x

# Re: https://stackoverflow.com/a/1580644
find . -type d -exec chmod a+rwx {} \;
find . -type f -exec chmod a+rw {} \;

# Re: https://stackoverflow.com/a/24704900/1397555
for f in `find . -name '*.sh' -o -name '*.py'`
do
 git update-index --chmod=+x $f
done

# Re: https://stackoverflow.com/questions/1580596/how-do-i-make-git-ignore-file-mode-chmod-changes#comment47788079_2083563
# git diff --summary | grep --color 'mode change 100644 => 100755' | cut -d' ' -f7-|tr '\n' '\0'|xargs -0 chmod -x