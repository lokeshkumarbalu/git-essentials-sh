#!/bin/bash

# Name:         GetCurrentBranch
# Description:  This function retrieves the name of the current branch in a Git repository.
# Returns:      The name of the current branch in a Git repository.
function GetCurrentBranch()
{
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# Name:         IsGitRepository
# Description:  This function checks if the current directory is a Git repository.
# Returns:      0 if the current directory is a Git repository, 1 otherwise.
function IsGitRepository()
{
    if [[ $(git branch 2> /dev/null | wc -l) -eq 0 ]]; then return 1
    else return 0
    fi
}

# Name:         IsWorkingDirectoryClean
# Description:  This function checks if the current working directory, which is assumed to be a Git repository,
#               has any uncommitted changes.
# Returns:      0 if there are no uncommitted changes in the current Git repository, 1 otherwise.
function IsWorkingDirectoryClean()
{
    if [[ $(git diff-index --name-only HEAD | wc -w) -eq 0 ]]; then return 0
    else return 1
    fi
}

# Name:         GetDefaultBranchName
# Description:  This function retrieves the name of the default branch in a Git repository.
# Returns:      The name of the default branch in a Git repository.
function GetDefaultBranchName()
{
    git remote show origin | grep 'HEAD branch' | cut -d' ' -f5
}

# Name:         RemoteNamedOriginExists
# Description:  This function checks if a remote named 'origin' exists in the current Git repository.
# Returns:      0 if a remote named 'origin' exists in the current Git repository, 1 otherwise.
function RemoteNamedOriginExists()
{
    if [[ $(git remote | grep -c "origin") -eq 0 ]]; then return 1
    else return 0
    fi
}