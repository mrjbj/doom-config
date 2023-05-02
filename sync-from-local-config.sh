#!/bin/bash

# 1. emacs active config for package.el, config.el and init.el 
#    are stored locally in ~/.doom.d
# 2. the git repo that saves this setup to my personal GitHub library is stored 
#    in ~/GitData/doom-config
# 3. this script copies the local config into repo so it can be versiond
#    and updated to github upon demand and thereby saved for use in future.

cp -r ~/.config/doom/* .
echo "sync complete. Now, git commit and push when ready."
