#!/bin/bash

pidfile='hipstafyd_name.txt'
log="log.txt"

# "Output should be printed to a logfile. You may separate stderr into its own file."
# No need to close other files in our case

[[ -t 0 ]] && exec </dev/null 
[[ -t 1 ]] && exec >> $log 
[[ -t 2 ]] && exec 2>1


stop_daemon() {
 # -P to kill all child processes 
 # hipstafy-wait.sh spawns a subshell 
 # -> different PID
 pkill -TERM -P $(cat $pidfile)
 echo "daemon stopped"
 echo "----------------"
}

check_status(){
 pkill -0 -F $pidfile
 if [ "$?" -eq  "0" ] 
  then
   echo "still alive"
   return "0"
  else
   echo "not alive"
   return "1"
 fi    
}

start_daemon() {
 check_status
  if [ "$?" -eq "0" ]; then
   echo "already running"
  else 
   nohup ./hipstafy-wait.sh & echo $! > $pidfile && echo "$pidfile"
   echo "started with PID $!"
  fi 
}


case "$1" in
 start)
  start_daemon
  ;;
 stop)
  stop_daemon
  ;;
 status)
  check_status
  ;;
 restart) 
  stop_daemon
  start_daemon
  ;;
esac
