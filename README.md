# performace-measurement

Resources for measuring EXPRESSCLUSTER mirror-disk performance 

---

/sys/block/sdb/queue/max_sectors_kb
  - Cent 6.9 = 512
  - Cent 8.2 = 1280

/sys/block/sdb/queue/max_hw_sectors_kb
  - Cent 6.9 = 32767
  - Cent 8.2 = 32767

/sys/block/sdb/queue/scheduler
  - Cent 6.9 = noop anticipatory deadline [cfq]
  - Cent 8.2 = [mq-deadline] kyber bfq none

---

[RHEL7 の パフォーマンスチューニングガイド](https://access.redhat.com/documentation/ja-jp/red_hat_enterprise_linux/7/html/performance_tuning_guide/sect-red_hat_enterprise_linux-performance_tuning_guide-storage_and_file_systems-configuration_tools)

max_sectors_kb

I/O 要求の最大サイズをキロバイト単位で指定します。デフォルト値は 512 KB です。このパラメーターの最小値はストレージデバイスの論理ブロックサイズで確定されます。パラメーターの最大値は max_hw_sectors_kb の値で確定されます。
一部のソリッドステートディスクは、I/O リクエストが内部消去ブロックサイズよりも大きいとパフォーマンスが悪化します。システムにアタッチするソリッドステートディスクモデルがこれに該当するかを判断するには、ハードウェアのベンダーに確認し、ベンダーの推奨事項に従います。Red Hat は、常に max_sectors_kb を最適な I/O サイズと内部消去ブロックサイズの倍数にするよう推奨しています。これらの値がゼロであったり、ストレージデバイスの指定がない場合は、いずれかのパラメーターに logical_block_size の値を使用します。 
