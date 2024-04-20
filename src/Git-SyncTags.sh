#!/bin/bash

source Git-Common.sh
if IsGitRepository;
then
    git fetch --prune origin "+refs/tags/*:refs/tags/*"
else
    printf "Not a git repository."
fi