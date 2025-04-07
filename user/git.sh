#!/bin/bash

nm-online

gh personal

repositories=(
	"/home/zeaiter/Documents/API/Canvas/"
	"/home/zeaiter/Documents/API/GitHub/"
	"/home/zeaiter/Documents/Script Tools/"
	"/home/zeaiter/Documents/Config Files/"
	"/home/zeaiter/Documents/Tipon"
	"/home/zeaiter/Documents/DB_Backups"
	"/home/zeaiter/Documents/Learning Java"
	"/home/zeaiter/Documents/University/"
	"/home/zeaiter/texmf"
	"/home/zeaiter/Documents/CV/"
)

for (( i=0 ; i < ${#repositories[@]} ; i++ ))
do
	git -C "${repositories[$i]}" pull origin master
done

gh uni

repositories=(
	"/home/zeaiter/Documents/canvasapi/"
	"/home/zeaiter/Documents/periodic-logistic"
)

for (( i=0 ; i < ${#repositories[@]} ; i++ ))
do
	git -C "${repositories[$i]}" pull origin master
done

gh personal

# First change directories and set variables for current day date and
# yesterday's date.
cd /home/zeaiter/Documents/DB_Backups/Tipon

# Count the number of files in the directory.
file_count=$(ls -q *.sql | wc -l)

if [ $file_count == 0 ]
then
	# If there is no previous backup just copy over the serve backup and
	# add and commit it.
	scp zeaiter@tipon:*.sql .
	backup=$(echo $(ls *.sql | sed -e 's/\.sql$//'))
	git add .
	git commit -m "Updated TipOn backup to ${backup}"
	git push origin master
	echo "Updated backup to ${backup}."
else
	# If there is a previous backup copy over the current server backup and
	# check if this differs from the current one. If it differs add and
	# commit it, otherwise do nothing.
	prev_backup=$(echo $(ls *.sql | sed -e 's/\.sql$//'))
	scp zeaiter@tipon:*.sql .
	file_count=$(ls -1 *.sql | wc -l)
	if [ $file_count -gt 1 ]
	then
		rm -f ${prev_backup}.sql
		new_backup=$(echo $(ls *.sql | sed -e 's/\.sql$//'))
		git add .
		git commit -m "Updated TipOn backup to ${new_backup}"
		git push origin master
		echo "Updated backup to ${new_backup}."
	else
		echo "Backup already up to date."
	fi
fi
