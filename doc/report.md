
## Results


### Simple 

2 computes running the following each:

```
pgbench  -h ${DBIP} -P 2 -C -p 6432 -T 90 -C -c 1000 -n -U user_bench postgres | egrep 'tps|latency' & 
```

workers 7:
latency average = 1679.311 ms
latency stddev = 809.684 ms
tps = 566.491808 (including connections establishing)
tps = 566.861389 (excluding connections establishing)
latency average = 1645.742 ms
latency stddev = 803.122 ms
tps = 602.159418 (including connections establishing)
tps = 602.580991 (excluding connections establishing)

workers 4:
latency average = 1445.696 ms
latency stddev = 694.174 ms
tps = 670.540794 (including connections establishing)
tps = 671.032352 (excluding connections establishing)
latency average = 1430.642 ms
latency stddev = 700.661 ms
tps = 692.321697 (including connections establishing)
tps = 692.839824 (excluding connections establishing)

workers 1:
latency average = 1326.686 ms
latency stddev = 292.447 ms
tps = 747.936707 (including connections establishing)
tps = 748.469460 (excluding connections establishing)
latency average = 1338.647 ms
latency stddev = 291.762 ms
tps = 723.711239 (including connections establishing)
tps = 724.224637 (excluding connections establishing)


Single thread works better on non-stressed environment.

### Simple x 4

Same command x4 on each machine.

worker 1:

Client 1

```
latency average = 16983.467 ms
latency average = 16796.224 ms
latency stddev = 16382.761 ms
latency stddev = 16212.135 ms
tps = 58.187971 (including connections establishing)
tps = 57.528826 (including connections establishing)
latency average = 16758.817 ms
latency stddev = 16158.897 ms
tps = 58.208965 (excluding connections establishing)
tps = 58.374786 (including connections establishing)
tps = 57.553906 (excluding connections establishing)
tps = 58.397680 (excluding connections establishing)
latency average = 16795.156 ms
latency stddev = 16114.288 ms
tps = 58.152206 (including connections establishing)
tps = 58.171902 (excluding connections establishing)
```

client 2:
```
latency average = 21316.112 ms
latency stddev = 16953.855 ms
tps = 45.713737 (including connections establishing)
tps = 45.722677 (excluding connections establishing)
latency average = 21235.730 ms
latency stddev = 16809.233 ms
tps = 45.863651 (including connections establishing)
tps = 45.874673 (excluding connections establishing)
latency average = 21172.428 ms
latency stddev = 16972.055 ms
tps = 45.995110 (including connections establishing)
tps = 46.004635 (excluding connections establishing)
latency average = 21231.577 ms
latency stddev = 16735.296 ms
tps = 45.855924 (including connections establishing)
tps = 45.863425 (excluding connections establishing)
```


workers 4:

c1
```
latency average = 21593.920 ms
latency stddev = 29076.788 ms
tps = 45.509321 (including connections establishing)
tps = 45.543096 (excluding connections establishing)
latency average = 21187.313 ms
latency stddev = 28809.827 ms
tps = 46.382473 (including connections establishing)
tps = 46.410902 (excluding connections establishing)
latency average = 21566.501 ms
latency stddev = 29385.999 ms
tps = 45.566391 (including connections establishing)
tps = 45.591312 (excluding connections establishing)
latency average = 21972.079 ms
latency stddev = 29324.720 ms
tps = 44.723216 (including connections establishing)
tps = 44.752016 (excluding connections establishing)
```

c2
```
latency average = 26184.200 ms
latency stddev = 36339.877 ms
tps = 37.527402 (including connections establishing)
tps = 37.529810 (excluding connections establishing)
latency average = 25626.522 ms
latency stddev = 36007.878 ms
tps = 38.356157 (including connections establishing)
tps = 38.358594 (excluding connections establishing)
latency average = 25591.010 ms
latency stddev = 35997.885 ms
tps = 38.409127 (including connections establishing)
tps = 38.411620 (excluding connections establishing)
latency average = 25768.502 ms
latency stddev = 36088.158 ms
tps = 38.161753 (including connections establishing)
tps = 38.164609 (excluding connections establishing)

```




## Pgbouncer

More than 1000 connections, pgbouncer stalls

```
root@client-node-0:~# pgbench -h 10.164.15.194 -P 2 -C -p 6433 -T 90 -C -c 500 -n -U user_bench postgres

number of transactions actually processed: 118047
latency average = 380.029 ms
latency stddev = 13.745 ms
tps = 1310.159360 (including connections establishing)
tps = 1312.325104 (excluding connections establishing)
```


For odyssey, on that amont of connections, is less performant, but it keeps replying at a very high number of connections:

```
number of transactions actually processed: 54030
latency average = 827.701 ms
latency stddev = 122.164 ms
tps = 599.397707 (including connections establishing)
tps = 600.481851 (excluding connections establishing)
```