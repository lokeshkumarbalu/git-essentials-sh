#!/bin/bash

source ./Git-Common.sh
IsGitRepository

if [[ $? -eq 1 ]]
then 
    # Switch to master branch before deleting merged branches.
    git checkout master
    git pull

    # Get all the merged branches with master.
    mergedBranches=$(git branch --merged master | grep feature*)

    # Loop through the merged branches and delete them.
    for branch in $mergedBranches
    do 
        git push --delete origin $branch
        git branch --delete $branch
    done 
fi
