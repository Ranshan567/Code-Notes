# 隐藏回收站，防止误删
添加到 .bashrc 文件中
```shell
# mkdir ~/.trash
alias rm=del
del()               
{
  mv $@ ~/.trash/
}
```
通过 Linux 的 crontab 命令用来定期执行程序。
![image](https://user-images.githubusercontent.com/93338266/229783799-05a54c5b-2b28-464d-9088-e57842170cb7.png)

例如(每天1点清理一次)：
```shell
0 1 * * * /bin/rm -rf /share/home/stu_wanbeiyuan/.trash/*
```
查看与删除定时任务
```shell
crontab -l # 查看已经创建的计划任务
crontab -e 
# 回车后进入crontab命令的计划服务配置界面。
# 直接使用“dd”，删除计划任务。
# 输入命令“：wq!”保存并退出。
# 使用crontab -l再次查看，就没有计划任务了
```
