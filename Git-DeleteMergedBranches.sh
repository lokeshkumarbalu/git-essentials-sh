#!/bin/bash

git checkout master
git pull

mergedBranches=$(git branch --merged master | grep feature*)

for branch in $mergedBranches
do 
    git push --delete origin $branch
    git branch --delete $branch
done
