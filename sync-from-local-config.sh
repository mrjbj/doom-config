#!/bin/bash

# 1. emacs local config for package.el, config.el and init.el 
#    are stored in ~/.doom.d
# 2. the git repo that saves this setup to GitHub is stored 
#    in ~/GitData/doom-config
# 3. this script copies the local config into repo so it can be versiond
#    and updated to github upon demand.

cp ~/.doom.d/* .
echo "sync complete. Now, git commit and push when ready."
