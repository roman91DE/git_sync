#!/bin/bash

# Directories
REPO1="$HOME/Documents/rmn_main"
REPO2="$HOME/Documents/md-docs"

# Log file
LOGFILE="$HOME/git_sync.log"

# Function to update a repository
update_repo() {
  REPO_DIR=$1
  cd "$REPO_DIR" || { echo "Failed to cd to $REPO_DIR"; exit 1; }
  
  echo "Updating repository: $REPO_DIR" >> "$LOGFILE"
  
  # Pull the latest changes
  git pull >> "$LOGFILE" 2>&1
  if [ $? -ne 0 ]; then
    echo "Failed to pull in $REPO_DIR" >> "$LOGFILE"
    return
  fi
  
  # Add new changes
  git add . >> "$LOGFILE" 2>&1
  
  # Commit changes
  git commit -m "Automated commit $(date)" >> "$LOGFILE" 2>&1
  
  # Push changes
  git push >> "$LOGFILE" 2>&1
  if [ $? -ne 0 ]; then
    echo "Failed to push in $REPO_DIR" >> "$LOGFILE"
  fi
  
  echo "Finished updating repository: $REPO_DIR" >> "$LOGFILE"
}

# Update both repositories
update_repo "$REPO1"
update_repo "$REPO2"

echo "Script run completed at $(date)" >> "$LOGFILE"
