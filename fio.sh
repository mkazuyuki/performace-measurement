#!/bin/bash

# Measuring mirror-disk performance with FIO
# Assuming mirror-disk mount point as /md, data-partition size more than 8GB

waiting () {
	while [ 1 ];do
		sleep 2
		clpmdstat -m md1 | grep "Mirror Color" | grep -E "GREEN.*GREEN" > /dev/null
		if [ $? -eq 0 ]; then
			break
		fi
	done
}

for METHOD in randwrite write; do
	echo [d] $METHOD START
	for SIZE in 1K 2K 4K 8K 16K 32K 64K 128K 256K 512K 1M 2M 4M 8M 16M 32M 64M 128M 256M 512M; do
		clplogcmd -m "$SIZE" 2>&1 > /dev/null
		echo -n "$SIZE " >> log.txt
		fio -filename=/md/f.fio -direct=1 -rw=$METHOD -bs=$SIZE -size=8G -runtime=30 -name=job1 | grep "write:" | sed 's/^.*bw=//' | sed "s/KB\/s.*//" | tee -a log.txt

		# Wait for completion of mirror recovery
		waiting; waiting;
	done
done
echo [d] END
