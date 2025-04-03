#! /bin/bash

set -e

# commit, default "checkpoint", prefer args
commit_message="checkpoint"
if [ -n "$1" ]; then
    commit_message="$1"
fi

git add .
git commit -m "$commit_message"
git push
