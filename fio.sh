#!/bin/bash

waiting () {
	while [ 1 ];do
		sleep 2
		clpmdstat -m md1 | grep "Mirror Color" | grep -E "GREEN.*GREEN" > /dev/null
		if [ $? -eq 0 ]; then
			break
		fi
	done
}

echo [d] Random START
for SIZE in 1K 2K 4K 8K 16K 32K 64K 128K 256K 512K 1M 2M 4M 8M 16M 32M 64M 128M 256M 512M; do
	clplogcmd -m "$SIZE" 2>&1 > /dev/null
	echo -n "$SIZE " >> log.txt
	# Random write
	fio -filename=/md/f.fio -direct=1 -rw=randwrite -bs=$SIZE -size=8G -runtime=30 -name=job1 | grep "write:" | sed 's/^.*bw=//' | sed "s/KB\/s.*//" | tee -a log.txt

	# Wait for completion of mirror recovery
	#waiting; waiting;
	sleep 5
done

echo [d] Sequential START
for SIZE in 1K 2K 4K 8K 16K 32K 64K 128K 256K 512K 1M 2M 4M 8M 16M 32M 64M 128M 256M 512M; do
	clplogcmd -m "$SIZE" 2>&1 > /dev/null
	echo -n "$SIZE " >> log.txt
	# Sequential write
	fio -filename=/md/f.fio -direct=1 -rw=write     -bs=$SIZE -size=8G -runtime=30 -name=job1 | grep "write:" | sed 's/^.*bw=//' | sed "s/KB\/s.*//" | tee -a log.txt

	# Wait for completion of mirror recovery
	#waiting; waiting;
	sleep 5
done

echo [d] END
