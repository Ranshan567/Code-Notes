# Linux脚本并行
## 1 使用 & 和 wait
串行
···
#!/bin/bash
#当前目录下执行如下脚本  相对路径
./1.sh 
./2.sh 
echo "继续执行剩下的逻辑..."
···
并行
···
#!/bin/bash
#当前目录下执行如下脚本  相对路径
./1.sh &
./2.sh &
wait
echo "继续执行剩下的逻辑..."
···
并行
···
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
···

