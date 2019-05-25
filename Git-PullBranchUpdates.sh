#!/bin/bash

# Get all the local branches.
localBranches=$(git branch | sed -e 's/*/ /g')

# Loop through the local branches and update them one by one.
for branch in $localBranches
do
    git checkout $branch
    git pull
done


