

## Odyssey 20 iterations, 500 connections each , 20 secs, 7 workers

```
+ pgbench -h 10.164.15.212 -C -p 6432 -T 20 -C -c 500 -n -U user_bench postgres
+ tee -a /var/bench/odyssey/eebb99693f2e4fabd269d74e.log
+ tee -a /var/bench/odyssey/eebb99693f2e4fabd269d74e.log
root@client-node-0:~# latency average = 21444.016 ms
tps = 23.316528 (including connections establishing)
tps = 23.343742 (excluding connections establishing)
latency average = 12521.826 ms
tps = 39.930280 (including connections establishing)
tps = 39.934527 (excluding connections establishing)
latency average = 20320.051 ms
tps = 24.606238 (including connections establishing)
tps = 24.637535 (excluding connections establishing)
latency average = 21236.664 ms
tps = 23.544187 (including connections establishing)
tps = 23.548009 (excluding connections establishing)
latency average = 20597.590 ms
tps = 24.274684 (including connections establishing)
tps = 24.311870 (excluding connections establishing)
latency average = 20706.931 ms
tps = 24.146505 (including connections establishing)
tps = 24.183309 (excluding connections establishing)
latency average = 20428.295 ms
tps = 24.475855 (including connections establishing)
tps = 24.509004 (excluding connections establishing)
latency average = 12934.282 ms
tps = 38.656958 (including connections establishing)
tps = 38.660922 (excluding connections establishing)
latency average = 12960.937 ms
tps = 38.577459 (including connections establishing)
tps = 38.581278 (excluding connections establishing)
latency average = 20815.909 ms
tps = 24.020090 (including connections establishing)
tps = 24.056597 (excluding connections establishing)
latency average = 20568.164 ms
tps = 24.309413 (including connections establishing)
tps = 24.344238 (excluding connections establishing)
latency average = 12399.437 ms
tps = 40.324411 (including connections establishing)
tps = 40.328641 (excluding connections establishing)
latency average = 13211.532 ms
tps = 37.845725 (including connections establishing)
tps = 37.849390 (excluding connections establishing)
latency average = 12630.032 ms
tps = 39.588181 (including connections establishing)
tps = 39.595564 (excluding connections establishing)
latency average = 20638.662 ms
tps = 24.226377 (including connections establishing)
tps = 24.263212 (excluding connections establishing)
latency average = 20888.757 ms
tps = 23.936321 (including connections establishing)
tps = 23.966709 (excluding connections establishing)
latency average = 12996.750 ms
tps = 38.471157 (including connections establishing)
tps = 38.474943 (excluding connections establishing)
latency average = 20396.777 ms
tps = 24.513677 (including connections establishing)
tps = 24.540639 (excluding connections establishing)
latency average = 20431.714 ms
tps = 24.471760 (including connections establishing)
tps = 24.502860 (excluding connections establishing)
latency average = 20891.233 ms
tps = 23.933485 (including connections establishing)
tps = 23.961807 (excluding connections establishing)
```


## Odyssey 20 iterations, 500 connections each , 20 secs, 3 workers

```
+ pgbench -h 10.164.15.212 -C -p 6432 -T 20 -C -c 500 -n -U user_bench postgres
+ egrep 'tps|latency'
+ egrep 'tps|latency'
root@client-node-0:~# latency average = 15981.809 ms
tps = 31.285570 (including connections establishing)
tps = 31.335695 (excluding connections establishing)
latency average = 21416.338 ms
tps = 23.346661 (including connections establishing)
tps = 23.350058 (excluding connections establishing)
latency average = 15773.515 ms
tps = 31.698705 (including connections establishing)
tps = 31.743783 (excluding connections establishing)
latency average = 16088.618 ms
tps = 31.077871 (including connections establishing)
tps = 31.124826 (excluding connections establishing)
latency average = 16542.431 ms
tps = 30.225304 (including connections establishing)
tps = 30.273679 (excluding connections establishing)
latency average = 20971.660 ms
tps = 23.841698 (including connections establishing)
tps = 23.845202 (excluding connections establishing)
latency average = 12034.381 ms
tps = 41.547628 (including connections establishing)
tps = 41.552537 (excluding connections establishing)
latency average = 20938.783 ms
tps = 23.879133 (including connections establishing)
tps = 23.882657 (excluding connections establishing)
latency average = 21238.529 ms
tps = 23.542120 (including connections establishing)
tps = 23.543445 (excluding connections establishing)
latency average = 15956.660 ms
tps = 31.334877 (including connections establishing)
tps = 31.382147 (excluding connections establishing)
latency average = 16174.324 ms
tps = 30.913194 (including connections establishing)
tps = 30.962700 (excluding connections establishing)
latency average = 21336.341 ms
tps = 23.434197 (including connections establishing)
tps = 23.435471 (excluding connections establishing)
latency average = 15808.979 ms
tps = 31.627596 (including connections establishing)
tps = 31.678326 (excluding connections establishing)
latency average = 11848.733 ms
tps = 42.198606 (including connections establishing)
tps = 42.203651 (excluding connections establishing)
latency average = 15587.412 ms
tps = 32.077166 (including connections establishing)
tps = 32.125623 (excluding connections establishing)
latency average = 11801.923 ms
tps = 42.365978 (including connections establishing)
tps = 42.371040 (excluding connections establishing)
latency average = 15799.694 ms
tps = 31.646182 (including connections establishing)
tps = 31.696559 (excluding connections establishing)
latency average = 16270.780 ms
tps = 30.729934 (including connections establishing)
tps = 30.779012 (excluding connections establishing)
latency average = 15784.522 ms
tps = 31.676600 (including connections establishing)
tps = 31.727339 (excluding connections establishing)
latency average = 16138.592 ms
tps = 30.981637 (including connections establishing)
tps = 31.031332 (excluding connections establishing)
```

## Odyssey 20 iterations, 500 connections each , 20 secs, 1 workers

```
+ pgbench -h 10.164.15.212 -C -p 6432 -T 20 -C -c 500 -n -U user_bench postgres
root@client-node-0:~# latency average = 18147.308 ms
tps = 27.552296 (including connections establishing)
tps = 27.589592 (excluding connections establishing)
latency average = 17965.901 ms
tps = 27.830499 (including connections establishing)
tps = 27.861176 (excluding connections establishing)
latency average = 18246.291 ms
tps = 27.402829 (including connections establishing)
tps = 27.435250 (excluding connections establishing)
latency average = 11056.012 ms
tps = 45.224262 (including connections establishing)
tps = 45.266046 (excluding connections establishing)
latency average = 11348.753 ms
tps = 44.057704 (including connections establishing)
tps = 44.109270 (excluding connections establishing)
latency average = 18098.703 ms
tps = 27.626289 (including connections establishing)
tps = 27.668108 (excluding connections establishing)
latency average = 21805.832 ms
tps = 22.929645 (including connections establishing)
tps = 22.933356 (excluding connections establishing)
latency average = 18267.436 ms
tps = 27.371111 (including connections establishing)
tps = 27.398935 (excluding connections establishing)
latency average = 18489.058 ms
tps = 27.043021 (including connections establishing)
tps = 27.072711 (excluding connections establishing)
latency average = 18028.135 ms
tps = 27.734427 (including connections establishing)
tps = 27.774261 (excluding connections establishing)
latency average = 18505.281 ms
tps = 27.019315 (including connections establishing)
tps = 27.055599 (excluding connections establishing)
latency average = 18108.777 ms
tps = 27.610920 (including connections establishing)
tps = 27.648198 (excluding connections establishing)
latency average = 18377.816 ms
tps = 27.206714 (including connections establishing)
tps = 27.250166 (excluding connections establishing)
latency average = 21272.147 ms
tps = 23.504914 (including connections establishing)
tps = 23.508757 (excluding connections establishing)
latency average = 11083.802 ms
tps = 45.110876 (including connections establishing)
tps = 45.137940 (excluding connections establishing)
latency average = 18188.674 ms
tps = 27.489635 (including connections establishing)
tps = 27.528993 (excluding connections establishing)
latency average = 18161.397 ms
tps = 27.530921 (including connections establishing)
tps = 27.563416 (excluding connections establishing)
latency average = 18607.717 ms
tps = 26.870572 (including connections establishing)
tps = 26.897585 (excluding connections establishing)
latency average = 18188.730 ms
tps = 27.489551 (including connections establishing)
tps = 27.531112 (excluding connections establishing)
latency average = 11383.646 ms
tps = 43.922657 (including connections establishing)
tps = 43.977352 (excluding connections establishing)
```

## Pgbouncer 20 iterations, 500 connections each , 20 secs

```
+ pgbench -h 10.164.15.214 -C -p 6432 -T 20 -C -c 500 -n -U user_bench postgres
+ egrep 'tps|latency'
+ egrep 'tps|latency'
+ egrep 'tps|latency'
+ tee -a /var/bench/pgbouncer/3d9618312f21aa070d3064c9.log
latency average = 3498.406 ms
tps = 142.922254 (including connections establishing)
tps = 142.995587 (excluding connections establishing)
latency average = 3515.845 ms
tps = 142.213326 (including connections establishing)
tps = 142.283837 (excluding connections establishing)
latency average = 3517.266 ms
tps = 142.155872 (including connections establishing)
tps = 142.228302 (excluding connections establishing)
latency average = 3526.725 ms
tps = 141.774576 (including connections establishing)
tps = 141.842882 (excluding connections establishing)
latency average = 3869.453 ms
tps = 129.217245 (including connections establishing)
tps = 129.304498 (excluding connections establishing)
latency average = 3871.844 ms
tps = 129.137431 (including connections establishing)
tps = 129.224276 (excluding connections establishing)
latency average = 3883.240 ms
tps = 128.758445 (including connections establishing)
tps = 128.845023 (excluding connections establishing)
latency average = 3887.185 ms
tps = 128.627795 (including connections establishing)
tps = 128.714811 (excluding connections establishing)
latency average = 3891.265 ms
tps = 128.492919 (including connections establishing)
tps = 128.579317 (excluding connections establishing)
latency average = 3891.117 ms
tps = 128.497814 (including connections establishing)
tps = 128.584349 (excluding connections establishing)
latency average = 3880.747 ms
tps = 128.841176 (including connections establishing)
tps = 128.928323 (excluding connections establishing)
latency average = 3865.295 ms
tps = 129.356238 (including connections establishing)
tps = 129.444101 (excluding connections establishing)
latency average = 3872.765 ms
tps = 129.106714 (including connections establishing)
tps = 129.193483 (excluding connections establishing)
latency average = 3867.009 ms
tps = 129.298883 (including connections establishing)
tps = 129.386241 (excluding connections establishing)
latency average = 3875.385 ms
tps = 129.019430 (including connections establishing)
tps = 129.108107 (excluding connections establishing)
latency average = 3882.263 ms
tps = 128.790875 (including connections establishing)
tps = 128.877174 (excluding connections establishing)
latency average = 3875.018 ms
tps = 129.031652 (including connections establishing)
tps = 129.118686 (excluding connections establishing)
latency average = 3883.822 ms
tps = 128.739178 (including connections establishing)
tps = 128.825983 (excluding connections establishing)
latency average = 3889.359 ms
tps = 128.555880 (including connections establishing)
tps = 128.642800 (excluding connections establishing)
latency average = 3877.883 ms
tps = 128.936320 (including connections establishing)
tps = 129.023854 (excluding connections establishing)
```