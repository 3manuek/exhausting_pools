#!/bin/bash

# Variables
# This variable is for initialize data pourpuse
init_bench=$1
scale_factor=10
#################
workmap=$2
test_times=$3   # Times to execute the test
host=$4
port=$5        # Port
ctest=$6        # Amount of connections to test
time=$7         # test time
user=$8         # Database user
db=$9           # Database

tmpfile_log=/tmp/.$RANDOM-$RANDOM
tmpfile_resume=/tmp/.$RANDOM-$RANDOM
tmpfile_csv=/tmp/.$RANDOM-$RANDOM
## postgresql password
export PGPASSFILE=/var/lib/postgresql/.pgpass

#./benchmark_test.sh 1 1 localhost 5432 4 10 postgres bench
## Functions

function error_and_exit() {
    echo -ne "\n\nError: $1 \n"
    exit $2
}

function usage() {
    error_and_exit "\n$0 <init_data> <work_map> <test_time> <host> <port> <conns> <time> <user> <db> [<output_file>]" 1
}


function verify_is_root() {
    if [[ $EUID -ne 0 ]]; then
          error_and_exit "You must be root to run this script"  2
    fi
}


function verify_is_root() {
    if [[ $EUID -ne 0 ]]; then
        error_and_exit "You must be root to run this script"  2
    fi
}

function drop_chache_so(){
		sync; sudo su -c "echo 1 > /proc/sys/vm/drop_caches"
}

function check_pgbench() {
	PGBENCH=$( which pgbench )
    if [ ! -e $PGBENCH ]; then
    	error_and_exit "pgbench does not exist" 5
    fi
}


function init_data(){

		if [[ $1 -eq 1 ]]; then
			sudo -u postgres pgbench -i -h $host -p $port -s $scale_factor -U $user $db #> /dev/null 2>&1
		fi
}

function work_map(){

		if [[ $1 -eq 1 ]]; then
			sudo -u postgres pgbench -i -h $host -p $port -c $ctest -n -T $time -U $user $db > /dev/null 2>&1
		fi
}


function run_test(){
	if [ $1 -eq 1 ]; then
  	  sudo -u postgres $PGBENCH -h $host -p $port -c $ctest -n -T $time -U $user $db > $tmpfile_log
  		grep -E "tps\s=\sa?\d*.a?\d*" $tmpfile_log | tee -a $tmpfile_resume > /dev/null
  		grep latency $tmpfile_log | tee -a $tmpfile_resume > /dev/null
  		rm $tmpfile_log

  		tps=($(grep including $tmpfile_resume |awk '{print $3}'))
  		latency=($(grep average $tmpfile_resume |awk '{print $4}'))
  		echo $ctest";"$time";"$tps";"$latency #| tee -a $csv_file
  	exit 0
	elif [ $1 -gt 1 ]; then
			i=0
			total=0
			sum=0
			total_latency=0
			sum_latency=0

				while [ $i -lt $1 ]
					do

					  sudo -u postgres pgbench -h $host -p $port -c $ctest -n -T $time -U $user $db | tee -a $tmpfile_log #> /dev/null
					  #echo $cnx $port | tee -a $tmpfile_resume
					  grep -E "tps\s=\sa?\d*.a?\d*" $tmpfile_log | tee -a $tmpfile_resume #> /dev/null
					  grep latency $tmpfile_log | tee -a $tmpfile_resume #> /dev/null
					  rm $tmpfile_log

						i=$(( $i + 1 ))
					done


				tps=($(grep including $tmpfile_resume |awk '{print $3}'))
				latency=($(grep average $tmpfile_resume |awk '{print $4}'))

				############## Average TPS  ########################

					for i in ${tps[@]}
					do
					  sum=$(bc <<< "scale = 2; $sum + $i")
					  ((total++))
					done
					avg_tps=$(bc <<< "scale = 2; $sum / $total")
				############# Average Latency #######################

					for j in ${latency[@]}
					do
					  sum_latency=$(bc <<< "scale = 2; $sum_latency + $j")
					  ((total_latency++))
					done

					avg_latency=$(bc <<< "scale = 2; $sum_latency / $total_latency")

					############ output ###############################
					n=0
					for i in ${tps[@]}
					do
					  echo $n";"$ctest";"$time";"$i";"${latency[$n]} #| tee -a $csv_file
					  ((n++))
					done
					echo "Average;;;"$avg_tps";"$avg_latency | tee -a $csv_file

##################################################################################################
		else
				usage "Incorrect parameters values" 3
	fi



}

## Main

if [ $# -lt 9 ]; then usage "Invalid arguments"; fi
verify_is_root
check_pgbench
drop_chache_so
init_data $init_bench
work_map $workmap
run_test $test_times





