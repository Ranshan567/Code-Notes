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
缺点：不能控制并行数量

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

## 3 多任务并行神器parallel
Parallel 是一种通用的并行化程序，可以在同一台机器上或在具有SSH访问权限的多台机器上轻松并行运行作业。
## 软件安装
```shell
#CentOS / RHEL
yum install parallel
#Ubuntu / Debian
sudo apt install parallel
```
OR
```shell
(wget -O - pi.dk/3 || curl pi.dk/3/) | bash
```
Usage
![image](https://user-images.githubusercontent.com/93338266/229763547-37cd810b-bdd7-4175-948f-8685d3ac9fa6.png)
```
常用参数
::: 后面接参数
:::: 后面接文件
-j/--jobs   并行任务数
-N  每次输入的参数数量
--xargs会在一行中输入尽可能多的参数
-xapply 从每一个源获取一个参数（或文件一行）
--header  把每一行输入中的第一个值做为参数名
-m   表示每个job不重复输出“背景”（context）
-X   与-m相反，会重复输出“背景文本”
-q  保护后面的命令
--trim  lr 去除参数两头的空格，只能去除空格，换行符和tab都不能去除
--keep-order/-k   强制使输出与参数保持顺序 --keep-order/-k
--tmpdir/ --results   都是保存文件，但是后者可以有结构的保存
--delay  延迟每个任务启动时间
--halt  终止任务
--pipe    该参数使得我们可以将输入（stdin）分为多块（block）
--block  参数可以指定每块的大小
```
使用---jobs/-j来指定并行的任务数

```shell
# 使用64个任务执行128个休眠命令
time parallel -N0 -j64 sleep 1 ::: {1..128}

# 每个cpu两个任务
time parallel -N0 --jobs 200% sleep 1 ::: {1..128}

# 使用--jobs 0 表示执行尽可能多的并行任务
time parallel -N0 --jobs 0 sleep 1 ::: {1..128}

# 除了基于cpu使用率之外，也可以基于cpu数
time parallel --use-cpus-instead-of-cores -N0 sleep 1 ::: {1..128}
```

注：目前的测试，使用第二种方法 xargs -P 并行的效果好一些。
