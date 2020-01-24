
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

worker 1:

clietn 1
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