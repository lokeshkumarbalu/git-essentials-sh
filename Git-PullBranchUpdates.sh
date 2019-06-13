#!/bin/bash

source Git-Common.sh
IsGitRepository

if [[ $? -eq 1 ]]
then
    # Check if the working tree is clean.
    differenceCount=$(git diff-index --name-only HEAD | wc -w)

    if [[ $differenceCount -gt 0 ]];
    then
        # Print message if uncommited changes found.
        echo "Working tree is not clean, commit or discard changes."
    else
        # Get all the local branches.
        localBranches=$(git branch | sed -e 's/*/ /g')
        
        # Loop through the local branches and update them one by one.
        for branch in $localBranches
        do
            git checkout $branch 1> /dev/null
            git pull
        done

        # Checkout to master branch once all the update is done.
        echo ""
        echo "All brnaches have been updated."
        git checkout master &> /dev/null
    fi
fi
