
# Git Sync Script

This script automates the process of pulling and pushing updates for two git repositories located in your Documents directory (`rmn_main` and `md-docs`). It is designed to be used on macOS and is ideal for keeping your repositories synchronized with remote changes automatically.

## Purpose

The `git_sync.sh` script:
- Pulls the latest changes from the remote repositories.
- Adds any new changes in the local repositories.
- Commits the new changes with an automated commit message.
- Pushes the changes back to the remote repositories.

## Installation

1. Save the script to a file named `git_sync.sh` in your preferred location. For example, you can save it in your home directory.

2. Make the script executable by running the following command in your terminal:

    ```sh
    chmod +x ~/git_sync.sh
    ```

3. Ensure you have the necessary permissions and that your git repositories (`rmn_main` and `md-docs`) are correctly set up in your Documents directory.

## Usage

### Running the Script Manually

You can run the script manually by executing:

```sh
~/git_sync.sh
```

### Setting Up the Cron Job

To automate the execution of the script, you can set up a cron job. Here’s how you can do it:

1. Open your crontab file by running:

    ```sh
    crontab -e
    ```

2. Add a new cron job to schedule the script. For example, to run the script every hour, add the following line:

    ```sh
    0 * * * * /path/to/git_sync.sh
    ```

   Make sure to replace `/path/to/git_sync.sh` with the actual path to your `git_sync.sh` script.

3. Save and close the crontab file.

## Script Details

Here is the content of the `git_sync.sh` script:

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

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](https://www.gnu.org/licenses/gpl-3.0.en.html) file for details.

## Contributing

If you wish to contribute to this project, please fork the repository and submit a pull request. Contributions are welcome!

## Support

If you encounter any issues or have any questions, feel free to open an issue in the repository or contact the maintainer.

---

By following the steps above, you can set up automatic synchronization for your git repositories on a macOS system using the `git_sync.sh` script.
