#!/bin/bash

# Name:         GetCurrentBranch
# Description:  The method returns current branch that is checked out for work.
function GetCurrentBranch() 
{
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# Name:         IsGitRepository
# Description:  The method returns 1 if the current directory is a GIT 
#               repository, 0 otherwise.
function IsGitRepository()
{
    if [[ $(git branch 2> /dev/null | wc -l) -eq 0 ]];
    then 
        return 0
    else
        return 1
    fi
}
