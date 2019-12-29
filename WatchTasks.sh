#!/bin/ksh 
####################################################################### watch tasks script #######################################################################

NO_OF_DAYS=1
days=1
interval=300
####################################################

## Calculate the sleep time and number of cycles #
x=0
#sleeptime=$( awk 'BEGIN{ print int ('$interval' * 60 * 60) }' ) 
cycle=$( awk 'BEGIN{ print int ('$days'/'$interval' * 24 * 60 * 60) }' )

echo "delay=" $interval "second(s)"
echo "cycle=" $cycle
taskcount=0
echo "watcher starting....."
taskcount=`vxtask list | wc -l`
########################################## ## Check if the file already exists #
if [ $taskcount -lt 6 ] then
    echo "Need additional tasks to be scheduled"
  else
	echo "Required number of tasks in progress"
fi
## Commence checking for tasks #
while [ $x -lt $cycle ] do
if [ $taskcount -lt 10 ] then
	 echo "Need additional tasks to be scheduled"
	 exit 0 
else
     #echo "Required number of tasks in progress"
     sleep $interval
 fi
x=$(($x+1)) 
done

if [ $taskcount -le 0 ] then
echo "Migration is complete and all tasks are complete on this server" | mail -s "Migration completed" nr4537@att.com
else
echo "Migration in progress and still running"
echo "Exiting the Taskwatcher script"
fi
exit 0