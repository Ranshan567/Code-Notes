# Linux脚本并行
## 1 使用 & 和 wait
串行
```shell
#!/bin/bash
#当前目录下执行如下脚本  相对路径
./1.sh 
./2.sh 
echo "继续执行剩下的逻辑..."
```
并行
```shell
#!/bin/bash
#当前目录下执行如下脚本  相对路径
./1.sh &
./2.sh &
wait
echo "继续执行剩下的逻辑..."
```
并行
```shell
#!/bin/bash
beginTime=`date +%s`
num=1
for i in `seq 1 3`
do
	{	
       	echo $i  "业务逻辑 开始执行,当前时间:" `date "+%Y-%m-%d %H:%M:%S"`
		sleep 2s
		echo $i  "业务逻辑 执行完成,当前时间:" `date "+%Y-%m-%d %H:%M:%S"`
		echo "-----------------------------------------------------------"
	# 结尾的&确保每个进程后台执行
	}&
done
# wait关键字确保每一个子进程都执行完成
wait
endTime=`date +%s`
echo "总共耗时:" $(($endTime-$beginTime)) "秒"
```

## 2 使用xargs -P 并行
四进程并行 -P 4
```shell
echo "one two three four five" | xargs -P 4 -I {} echo {}
```
最大进程并行 -P 0
```shell
ls *fastq | xargs -iF -P 0 bash -c  'gzip F'
# -I {} 与 -iF 同义
# 主要用到它以下几个参数
#「-i」, --replace[=R], replace R in INITIAL-ARGS with names read from standard input; if R is unspecified,assume {} : 将xargs传递的内容一行一行赋值给 {}，「-iF」即将xargs的输出一行一行赋值给F。
#「-P」, --max-procs=MAX-PROCS    run at most MAX-PROCS processes at a time : 最大进程数
```

# 3 多任务并行神器parallel
Parallel 是一种通用的并行化程序，可以在同一台机器上或在具有SSH访问权限的多台机器上轻松并行运行作业。
## 软件安装
```shell
#CentOS / RHEL
yum install parallel
#Ubuntu / Debian
sudo apt install parallel
```




