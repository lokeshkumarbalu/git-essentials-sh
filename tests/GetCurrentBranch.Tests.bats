#!/usr/bin/env bats

load './../src/Git-Common.sh'

# Test GetCurrentBranch when on a valid branch
@test "GetCurrentBranch returns the current branch name when on a valid branch" {

  # Setup
  mkdir /tmp/test-repo && cd /tmp/test-repo
  git init && git commit --allow-empty -m "Initial commit"
  
  # Test
  run GetCurrentBranch
  
  # Teardown
  cd /tmp && rm -rf test-repo
  
  # Assert
  [ "$status" -eq 0 ]
  [ "$output" = "master" ]
}

# Test GetCurrentBranch when not in a git repository
@test "GetCurrentBranch returns nothing when not in a git repository" {

  # Set up
  cd /tmp
  
  # Test
  run GetCurrentBranch
  
  # Assert
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
}