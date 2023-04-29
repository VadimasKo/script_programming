# 2 PRACTICE - POWER-SHELL
| 📖 Table Of Contents | link       |
|----------------------|------------|
| Task description     | [here](#1) |
| How to run           | [here](#3) |

## Task description  🔍 <a name='1'></a>
### Create **POWER-SHELL** script which:
 1. Reads all processes which runs on computer into array
 2. Iterates this array and forms separate log file for each user (no user -> ownerless file)
 3. Opens all logs in notepad.
 4. Script pauses
#### After user continues the script
 5. Closes notepad
 6. FINISH

### Requirements:
 1. parameter - `username` ( default current user)
 2. If `username` provided prepare to log for this user only
 3. Use only powershell commands. 
 4. Log file should have this format:
  ```
  // file name “$username-process-log-$date-$time.txt
  current date 
  current time
  process name
  process pid
  process other parameters (take any 2)

  ```

## How to run 🛠️ <a name="3"></a>
 - open powershell
 - set `Set-ExecutionPolicy RemoteSigned`
 - run `./script.ps1`
