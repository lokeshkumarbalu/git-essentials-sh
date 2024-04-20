#!/bin/bash

source Git-Common.sh

if IsGitRepository
then 
    printf "Sync all local branches with default with a merge commit\n"
    git fetch

    if IsWorkingDirectoryClean && RemoteNamedOriginExists;
    then
        # Get the default branch name.
        defaultBranch=$(GetDefaultBranchName)
        printf "Default branch is: %s\n" "$defaultBranch"
        
        # Switch to default branch and pull default before sync.
        git checkout "$defaultBranch" &> /dev/null
        git pull &> /dev/null

        # Get all the local feature branches to sync.
        featureBranches=$(git branch | grep "feature.*")

        # Loop through the local branches and sync them with default.
        for branch in $featureBranches
        do 
            git checkout "$branch" &> /dev/null
            git merge "$defaultBranch" --no-edit &> /dev/null
            git push &> /dev/null
        done
    else
        prinft "Working tree is not clean, commit or discard changes\n"
    fi
fi