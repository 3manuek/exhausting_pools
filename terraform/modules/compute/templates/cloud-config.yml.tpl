#cloud-config

write_files:
  - path: /usr/local/bin/lib.sh
    permissions: 0755
    content: !!binary ${lib}
  - path: /usr/local/bin/trigger.sh
    permissions: 0755
    content: !!binary ${triggerscript}
  - path: /usr/local/bin/benchmark_test.sh
    permissions: 0755
    content: !!binary ${benchmark_test}
    - path: /usr/local/bin/plainbench.sh
    permissions: 0755
    content: !!binary ${plainbench}

runcmd:
  - [ sysctl,  -w, fs.file-max=2500000 ]
  - 'ulimit -n 64000'
  - [ echo, never, '>/sys/kernel/mm/transparent_hugepage/enabled']
  - [ echo, never, '>/sys/kernel/mm/transparent_hugepage/defrag']
  - [ sysctl, -w, 'net.ipv4.tcp_fin_timeout=1']
  - [ sysctl, -w, 'net.ipv4.tcp_tw_reuse=1']
  - [ systemctl, 'daemon-reload' ]
  - [ /usr/local/bin/trigger.sh ]
