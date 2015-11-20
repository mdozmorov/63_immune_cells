INDEX=/home/mdozmorov/work/mdozmorov/ExtData/UCSC/hg19/chromFaMasked/hg19

SHELL=/bin/bash

DIR=02_aligned_trimmed
mkdir -p $DIR

k=0
for file in `find 01_trimmed/ -name "*_paired.fastq.gz" -type f | sort`; do
    if [ $k = 0 ]
    then
        s1=$file
        k+=1
    else
        s2=$file
        k=0
        subread-align -T 10 -i $INDEX -r $s1 -R $s2 --gzFASTQinput --BAMoutput --reportFusions -o $DIR/`basename $s2 _2_paired.fastq.gz`.bam
    fi
done

