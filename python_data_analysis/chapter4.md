note : chapter3 forcus on ipython, which i am not interested in.

## Numpy : which means numerical python

* ndarray n维数组对象，快速灵活的大数据集容器，可以实现矢量算术运算和复杂广播能力，且快速节约空间。
* 对整组数据进行标准数学运算，不使用循环
* 读写磁盘数据，操作内存文件
* 线性代数、随机数生成、傅立叶变换
* 集成其他语言，如c，c++，fortran（提供一个简单易用的CAPI）


### 数据分析应用

* 数据整理和清理，子集构造和过滤，转换等快速的矢量化数组运算
* 数组算法，如排序、唯一化、集合运算
* 高效的描述统计和数据聚合/摘要运算
* 用于异构数据集的合并/连接运算的数据对齐，关系型数据运算
* 将条件逻辑表述为数组表达式
* 数组的分组运算，聚合、转换、函数应用等

pandas提供了numpy所没有的功能，比如时间序列处理。

### ndarray

ndarray是一个通用的同构数据多维容器，每个数组（numpy数组/ndarray对象）都有一个shape和一个dtype。

* 1.创建 

```
# no1
import numpy as np
data = np.array([1,2,3,4])
# no2
np.zeros((3,6))
# no3
np.empty((4,3,2))# 返回未初始化的垃圾值
# no4
np.arange(15) # python内置函数range的数组版
```

* 2.数据类型（如果没有特别指定，数据类型基本都是float64）

```
# no1
np.array([1,2,3],dtype = np.int32)
# no2
arr = np.array([1,2,3,4])
f_arr = arr.astype(np.float64) # 显式转换dtype
```

* 3.数组和标量之间的运算
