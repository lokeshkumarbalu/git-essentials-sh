#!/usr/bin/env bats

load './../src/Git-Common.sh'

@test "IsWorkingDirectoryClean returns 0 when there are no uncommitted changes" {
  # Setup
  mkdir -p /tmp/test-repo && cd /tmp/test-repo
  git init && git commit --allow-empty -m "Initial commit"
  
  # Add a file to the repo
  touch test.txt && echo "Hello, World!" > test.txt
  git add test.txt && git commit -m "Add test.txt"

  # Test
  run IsWorkingDirectoryClean
  
  # Teardown
  cd /tmp && rm -rf test-repo
  
  # Assert
  [ "$status" -eq 0 ]
}

@test "IsWorkingDirectoryClean returns 1 when there are uncommitted changes" {
  # Setup
  mkdir -p /tmp/test-repo && cd /tmp/test-repo
  git init && git commit --allow-empty -m "Initial commit"
  
  # Add a file to the repo
  touch test.txt && echo "Hello, World!" > test.txt
  git add test.txt && git commit -m "Add test.txt"
  echo "Hello, World!" > test.txt
  
  # Test
  run IsWorkingDirectoryClean
  
  # Teardown
  cd /tmp && rm -rf test-repo
  
  # Assert
  [ "$status" -eq 0 ]
}