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
    if [[ $(git branch 2> /dev/null | wc -l) -eq 0 ]]; then return 0
    else return 1
    fi
}

# Name:         IsWorkingDirectoryClean
# Description:  The method returns 1 if the current directory is clean and no
#               changes are found, 0 otherwise.
function IsWorkingDirectoryClean()
{
    if [[ $(git diff-index --name-only HEAD | wc -w) -eq 0 ]]; then return 1
    else return 0
    fi
}
