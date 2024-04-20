#!/bin/bash

source Git-Common.sh

if IsGitRepository
then 
    echo "Sync all local branches with master with a merge commit."
    git fetch

    if IsWorkingDirectoryClean
    then
        # Switch to master branch and pull master before sync.
        git checkout master &> /dev/null
        git pull &> /dev/null

        # Get all the local feature branches to sync.
        featureBranches=$(git branch | grep "feature.*")

        # Loop through the local branches and sync them with master.
        for branch in $featureBranches
        do 
            git checkout "$branch" &> /dev/null
            git merge master --no-edit &> /dev/null
            git push &> /dev/null
        done
    else
        prinft "Working tree is not clean, commit or discard changes."
    fi
fi