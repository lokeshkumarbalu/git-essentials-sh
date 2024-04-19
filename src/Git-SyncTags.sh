#!/bin/bash

source Git-Common.sh
IsGitRepository

git fetch --prune origin "+refs/tags/*:refs/tags/*"