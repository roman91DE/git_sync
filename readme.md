Here's a basic shell script that you can use to automate the process of pulling and pushing updates for the two git repositories in your Documents directory (`rmn_main` and `md-docs`). You can use a cron job to schedule this script to run at regular intervals.

First, create a shell script named `git_sync.sh` with the following content:

```sh
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
```

Make the script executable:

```sh
chmod +x git_sync.sh
```

Next, you can schedule this script to run at regular intervals using `cron`. Here's how you can set it up:

1. Open your crontab file:

```sh
crontab -e
```

2. Add a new cron job to schedule the script. For example, to run the script every hour, add the following line:

```sh
0 * * * * /path/to/git_sync.sh
```

Make sure to replace `/path/to/git_sync.sh` with the actual path to your `git_sync.sh` script.

This will run the `git_sync.sh` script every hour, automatically pulling and pushing updates for the specified git repositories.