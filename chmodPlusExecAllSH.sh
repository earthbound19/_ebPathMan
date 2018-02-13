# DESCRIPTION
# Recursively sets the execute bit on all permissions of all .sh files.

# SEE ALSO
# http://www.lagentesoft.com/batchmod/

# NOTE
# This may not work as a script. You may have to copy and paste this command from a root dir of so many scripts you want to grant execute permissions to.


# CODE
find . -name '*.sh' -print0 | xargs -0 chmod +x