SHELL=/bin/bash

DIR=01_trimmed
mkdir -p $DIR

k=0
for file in `find 00_raw/ -name "*.gz" -type f | sort`; do
    if [ $k = 0 ]
    then
        s1=$file
        k+=1
    else
        s2=$file
        k=0
        java -jar /opt/Trimmomatic-0.32/trimmomatic-0.32.jar PE -phred33 -threads 10 $s1 $s2 $DIR/`basename $s1 .fastq.gz`_paired.fastq.gz $DIR/`basename $s1 .fastq.gz`_unpaired.fastq.gz $DIR/`basename $s2 .fastq.gz`_paired.fastq.gz $DIR/`basename $s2 .fastq.gz`_unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
    fi
done
