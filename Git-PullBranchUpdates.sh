#!/bin/bash

# Check if the working tree is clean
currentStatus=$(git status)
if [[ $currentStatus != *"working directory clean"* ]]; 
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

