# 3 PRACTICE - BASH
| 📖 Table Of Contents | link       |
|----------------------|------------|
| Task description     | [here](#1) |
| How to run           | [here](#3) |

## Task description  🔍 <a name='1'></a>
### Create **BASH** script which:
 1. Reads all processes with users that runs on computer into array.
 2. Forms log file for each user
 3. Creates directory and puts all files in one directory
 4. Outputs directory name, all log file names, with line count in each, total line count
 5. Script pauses
#### After user continues the script
 1. Deletes all files and directory's
 2. FINISH

### Requirements:
 1. Optional parameter - `username`
 2. If `username` is provided - forms only one log and at the end prints its content.
 3. Use only bash commands. 
 4. Log file should have this format:
 ```
  // file name “$username-process-log-$date-$time.log
  current date 
  current time
  process name
  process pid
  process other parameters ( take any 2 )
 ```


## How to run 🛠️ <a name="3"></a>
 1. make script executable `chmod +x script.sh`
 2. run script `./script.sh` or `./script.sh username`
