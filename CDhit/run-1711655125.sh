#!/bin/sh
#$ -S /bin/bash
#$ -v PATH=:/opt/cd-hit:/opt/cd-hit/cd-hit-auxtools:/opt/cd-hit/psi-cd-hit:/opt/ncbi-blast-2.8.1+/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin



#$ -e /opt/data/1711655125/1711655125.err
#$ -o /opt/data/1711655125/1711655125.out
cd /opt/data/1711655125
sed -i "s/\x0d/\n/g" 1711655125.fas.0

faa_stat.pl 1711655125.fas.0

/opt/cd-hit/cd-hit -i 1711655125.fas.0 -d 0 -o 1711655125.fas.1 -c 0.9 -n 5  -G 1 -g 1 -b 20 -l 10 -s 0.0 -aL 0.0 -aS 0.0 -T 4 -M 32000
faa_stat.pl 1711655125.fas.1
/opt/cd-hit/clstr_sort_by.pl no < 1711655125.fas.1.clstr > 1711655125.fas.1.clstr.sorted
/opt/cd-hit/clstr_list.pl 1711655125.fas.1.clstr 1711655125.clstr.dump
gnuplot1.pl < 1711655125.fas.1.clstr > 1711655125.fas.1.clstr.1; gnuplot2.pl 1711655125.fas.1.clstr.1 1711655125.fas.1.clstr.1.png
/opt/cd-hit/clstr_list_sort.pl 1711655125.clstr.dump 1711655125.clstr_no.dump
/opt/cd-hit/clstr_list_sort.pl 1711655125.clstr.dump 1711655125.clstr_len.dump len
/opt/cd-hit/clstr_list_sort.pl 1711655125.clstr.dump 1711655125.clstr_des.dump des
tar -zcf 1711655125.result.tar.gz * --exclude=*.dump --exclude=*.env
echo hello > 1711655125.ok
