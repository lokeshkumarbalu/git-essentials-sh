#!/bin/bash

Local=false
Remote=false

Parameters=()
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        --local)
        Local=true
        shift # past argument
        ;;
        --remote)
        Remote=true
        shift # past argument
        ;;
        *)    # unknown option
        shift # past argument
        ;;
    esac
done

if [[ $Local == $Remote ]] 
then 
    echo "Cannot run without an option, specify --local or --remote" 
    exit
fi

source Git-Common.sh
IsGitRepository

if [[ $? -eq 1 ]]
then 
    echo "Delete local and remote banches if they have been merged."
    git fetch

    # Check if the working tree is clean.
    IsWorkingDirectoryClean

    if [[ $? -eq 1 ]];
    then
        # Switch to master branch before deleting merged branches.
        git checkout master &> /dev/null
        git pull &> /dev/null

        # Get all the merged branches with master.
        if [[ $Local ]]; then mergedBranches=$(git branch --merged master | grep feature*)
        elif [[ $Remote ]]; then mergedBranches=$(git branch --merged master --remotes | grep feature*)
        fi

        # Loop through the merged branches and delete them.
        for branch in $mergedBranches
        do 
            if [[ $Local ]]; then git branch --delete $branch
            elif [[ $Remote ]]; then git push --delete origin $branch
            fi
        done 
    else
        # Print message if uncommited changes found.
        echo "Working tree is not clean, commit or discard changes."
    fi
fi
