#!/bin/bash

source Git-Common.sh

if IsGitRepository
then
    if IsWorkingDirectoryClean && RemoteNamedOriginExists;
    then
        # Get the default branch name.
        defaultBranch=$(GetDefaultBranchName)
        
        git fetch
        # Get all the local branches.
        localBranches=$(git branch | sed -e 's/*/ /g')
        
        # Loop through the local branches and update them one by one.
        for branch in $localBranches
        do
            git checkout "$branch" 1> /dev/null
            remote=$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}')
                        
            if [ -z "$remote" ];
            then
                printf "No remote branch found for '%s'\n\n" "$branch"
                continue
            fi
            
            if git merge-base --is-ancestor "$branch" "$remote";
                then git merge --ff-only "$remote"
            fi
            
            printf "\n"
        done

        # Checkout to default branch once all the update is done.
        printf "All branches have been updated\n"
        git checkout "$defaultBranch" &> /dev/null
    fi
fi
