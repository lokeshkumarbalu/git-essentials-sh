#!/bin/bash

# Check if the working tree is clean.
differenceCount=$(git diff-index --name-only HEAD | wc -w)

if [[ $differenceCount -gt 0 ]];
then
    # Print message if uncommited changes found.
    echo "Working directory is not clean, commit or discard changes."
else
    # Get all the local branches.
    localBranches=$(git branch | sed -e 's/*/ /g')
    
    # Loop through the local branches and update them one by one.
    for branch in $localBranches
    do
        git checkout $branch
	git pull
    done
fi

