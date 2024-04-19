#!/usr/bin/env bats

load './../src/Git-Common.sh'

# Test cases for IsGitRepository
@test "IsGitRepository returns 0 when in a git repository" {
  
  # Setup
  mkdir -p /tmp/test-repo && cd /tmp/test-repo
  git init && git commit --allow-empty -m "Initial commit"

  # Test
  run IsGitRepository

  # Teardown
  cd /tmp && rm -rf /tmp/test-repo
  
  # Assert
  [ "$status" -eq 0 ]
}

# Test cases for IsGitRepository
@test "IsGitRepository returns 1 when not in a git repository" {

  # Setup
  cd /tmp
  
  # Test
  run IsGitRepository
  
  # Assert
  [ "$status" -eq 1 ]
}