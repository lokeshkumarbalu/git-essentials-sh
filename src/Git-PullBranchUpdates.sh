#!/bin/bash

source Git-Common.sh

if IsGitRepository
then

    if IsWorkingDirectoryClean;
    then
        # Print message if uncommited changes found.
        echo "Working tree is not clean, commit or discard changes."
    else
        git fetch
        # Get all the local branches.
        localBranches=$(git branch | sed -e 's/*/ /g')
        
        # Loop through the local branches and update them one by one.
        for branch in $localBranches
        do
            git checkout "$branch" 1> /dev/null
            remote=$(git rev-parse --abbrev-ref --symbolic-full-name @{u})

            if git merge-base --is-ancestor "$branch" "$remote";
                then git merge --ff-only "$remote"
            fi
        done

        # Checkout to master branch once all the update is done.
        echo ""
        echo "All branches have been updated."
        git checkout master &> /dev/null
    fi
else 
    echo "No updates found on remote aborting branch update"
fi
