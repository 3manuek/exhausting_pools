#!/bin/bash

set -x

# Variables
# This variable is for initialize data pourpuse
init_bench=$1
scale_factor=100
#################
warmup=$2  # run a test without capture values
test_times=$3   # Times to execute the test
host=$4
port=$5        # Port
ctest=$6        # Amount of connections to test
time=$7         # test time
user=$8         # Database user
db=$9           # Database
#sar_time=$(($test_times * $time))
echo "sar time: "$sar_time
# date and time
dt=$(date '+%Y%m%d_%H-%M-%S');

# temp files
tmpfile_log=/tmp/.$RANDOM-$RANDOM
tmpfile_resume=/tmp/.$RANDOM-$RANDOM
tmpfile_csv=/tmp/.$RANDOM-$RANDOM
tmpfile_sar=/tmp/.sar-$RANDOM-$RANDOM
tmpfile_sar_avg=/tmp/.sar_avg-$RANDOM-$RANDOM
insert_sql=/tmp/bench_data_${dt}.sql
## postgresql password
export PGPASSFILE=/var/lib/postgresql/.pgpass

#./benchmark_test.sh 1 1 localhost 5432 4 10 postgres bench
## Functions

function error_and_exit() {
    echo -ne "\n\nError: $1 \n"
    exit $2
}

function usage() {
    error_and_exit "\n$0 <init_data> <warmup> <test_time> <host> <port> <conns> <time> <user> <db> [<output_file>]" 1
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
			# create table to collect the bench info
			runuser -u postgres -m -p -- psql -h $host -p $port -U $user $db -c "
				CREATE TABLE IF NOT EXISTS bench_test_data(
						batch_id integer,
						execution integer,
						pool_size integer,
						connections_amount integer,
						execution_time_seconds integer,
						tps numeric,
						latency numeric,
						execution_date timestamp default now());

				CREATE TABLE cpu_stats (
						batch_id integer,
						cpu integer,
						percent_user numeric,
						percent_nice numeric,
						percent_system numeric,
						percent_iowait numeric,
						percent_steal numeric,
						percent_idle numeric);
						"

			# initialize bench tables
			runuser -u postgres -m -p -- pgbench -i -h $host -p $port -s $scale_factor -U $user $db #> /dev/null 2>&1
		fi

}

function warmup(){

		if [[ $1 -eq 1 ]]; then
			runuser -u postgres -m -p -- pgbench -i -h $host -p $port -c $ctest -n -T $time -U $user $db > /dev/null 2>&1
		fi
}


function run_test(){
	if [ $1 -eq 1 ]; then
  	  # runuser -u postgres -m -p -- $PGBENCH -h $host -p $port -c $ctest -n -T $time -U $user $db > $tmpfile_log # bak
			runuser -u postgres -m -p -- $PGBENCH -h $host -p $port -c $ctest -C -t 1 -n -T $time -U $user $db > $tmpfile_log
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

			get_last_bacth
			get_pool_size_from_conf

				while [ $i -lt $1 ]
					do

					  runuser -u postgres -m -p -- pgbench -h $host -p $port -c $ctest -n -T $time -U $user $db | tee -a $tmpfile_log #> /dev/null
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
						bench_data+="insert into bench_test_data (batch_id,execution,pool_size,connections_amount, execution_time_seconds,tps,latency) values($batch_id,$n,${pool_size:-0},$ctest,$time,$i,${latency[$n]});"
					  ((n++))
					done
					echo "Average;;;"$avg_tps";"$avg_latency #| tee -a $csv_file
					#echo "Query: $test_data"

##################################################################################################
		else
				usage "Incorrect parameters values" 3
	fi

if [ ! -z "$bench_data" ]
then
		echo "** Inserting data to table **"
  	runuser -u postgres -m -p -- psql -h $host -p $port -U $user $db -c "$bench_data"
fi

}

function get_last_bacth(){
	batch_id=`runuser -u postgres -m -p -- psql -h $host -p $port -U $user $db -t -c "select coalesce(max(batch_id)+1,1) from bench_test_data"`
}

function get_pool_size_from_conf(){
	if [ -s /etc/odyssey/odyssey.conf ]
    then
			# odyssey conf
			pool_size=$(cat /etc/odyssey/odyssey.conf | grep -o -E 'pool_size\s\w*' | awk '{print $2}')
		else
			# pending pgbouncer
			pool_size=0
    fi
}

### wip
function get_cpu_stats(){
	threads=$(nproc --all)

	if sar -P ALL $time 3 -o $tmpfile_sar; then
		batch_id="$(echo -e "${batch_id}" | sed -e 's/^[[:space:]]*//')"
		cpu_stats_data=$(
				sar -P ALL $time 3  -f $tmpfile_sar | grep Average | sed 's/,/./g' \
				| awk 'FNR > 1 {print "insert into cpu_stats (batch_id,cpu,percent_user,percent_nice,percent_system,percent_iowait,percent_steal,percent_idle ) values (id_batch,"$2",",$3",",$4",",$5",",$6",",$7",",$8");"}' | sed "s/id_batch/$batch_id/g" )

		#  cpu_stats_data=$(echo $cpu_stats_data_tmp | sed s/batch/$batch_id/g)
		#  echo $cpu_stats_data
	fi

	if [ ! -z "$cpu_stats_data" ]
	then
		echo "** Inserting data to table **"
  	runuser -u postgres -m -p -- psql -h $host -p $port -U $user $db -c "$cpu_stats_data"
	fi


}
### wip

## Main

if [ $# -lt 9 ]; then usage "Invalid arguments"; fi
verify_is_root
check_pgbench
drop_chache_so
init_data $init_bench
warmup $warmup
#run_test $test_times
get_last_bacth
run_test $test_times & pid_bench=$!; get_cpu_stats & pid_sar=$!; wait $pid_bench $pid_sar



