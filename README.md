# Code-Notes

Word 插件用于代码块高亮
Easy Code Formatter

# 提交任务指定节点
要在PBS上提交任务并指定节点，您需要使用-l参数指定节点的资源需求。例如，假设您要在名为node001的节点上运行任务，可以使用以下命令
```shell
qsub -l nodes=node001:ppn=4 myjob.pbs
# 这将向PBS提交myjob.pbs作业，并要求使用node001节点的4个处理器。请注意，ppn参数表示每个节点的处理器数量。
```
如果希望在多个节点上运行作业，则可以使用逗号分隔节点名称，并指定每个节点上的处理器数量。例如，以下命令将在名为node001和node002的节点上分别使用4个处理器运行作业：
```shell
qsub -l nodes=node001:ppn=4+node002:ppn=4 myjob.pbs
# 请注意，在使用节点名称时，PBS需要能够访问节点列表并识别它们。您可能需要在PBS配置文件中指定节点列表，或者使用DNS名称或IP地址代替节点名称。
```
