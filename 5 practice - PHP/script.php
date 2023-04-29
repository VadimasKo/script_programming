<?php
$fileFormat = isset($argv[1]) ? $argv[1] : 'txt'; 
$username = isset($argv[2]) ? $argv[2] : '';

if ($username === '') {
  shell_exec('ps axo user,pid,ppid,%cpu,%mem,vsz,rss,tty,stat,start,time,command > processes.txt');
} else {
  shell_exec("ps axo user,pid,ppid,%cpu,%mem,vsz,rss,tty,stat,start,time,command -u $username > processes.txt");
}

switch ($fileFormat) {
  case 'txt':
    shell_exec("awk '{ printf \"%-15s\", \$1; \$1=\"\"; print }' processes.txt > processes_table.txt");
    break;
  case 'html':
    shell_exec("awk 'BEGIN { print \"<html><head><title>Processes Table</title></head><body><table>\" }
      NR==1 { print \"<tr><th>\" \$0 \"</th></tr>\" }
      NR>1 { print \"<tr><td>\" \$0 \"</td></tr>\" }
      END { print \"</table></body></html>\" }' processes.txt > processes_table.html");
    break;
  case 'csv':
    shell_exec("awk 'BEGIN { OFS=\",\"; print \"User,PID,PPID,CPU%,Mem%,VSZ,RSS,TTY,STAT,Start,Time,Command\" }
      NR>1 { print \$0 }' processes.txt > processes_table.csv");
    break;
}

echo 'Press any key to delete log files...';
system('read -rs -n1');

unlink('processes.txt');
switch ($fileFormat) {
  case 'txt':
    unlink('processes_table.txt');
    break;
  case 'html':
    unlink('processes_table.html');
    break;
  case 'csv':
    unlink('processes_table.csv');
    break;
}
