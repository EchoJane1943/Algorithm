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

矢量化（vectorization）运算：不用循环即可对数据执行批量运算。

广播（broadcasting）：不同大小的数组之间的运算。

* 4.基本的索引和切片
```
arr = np.arange(10)
arr[5:8]=12 # 将标量值赋值给一个切片时，该值会自动广播到整个选区。
```
深拷贝：副本 arr[5:8].copy()  
浅拷贝：视图 arr[5:8]

```
arr2d = np.array([[1,2,3],[4,5,6],[7,8,9]])
arr2d[2] # array([7,8,9])
arr2d[0][2] # 3
arr2d[0,2] # 3
```

数组的比较运算（如==）也是矢量化的。

python关键字and和or在布尔型数组中无效。

* 5.花式索引
```
arr = np.arange(32).reshape((8,4))
arr[[1,5,7,2],[0,3,1,2]]
# 会取出数组中坐标为（1，0），（5，3），（7，1），（2，2）的四个数
```

花式索引会将数据复制到新数组中。这是花式索引和切片的区别。

* 6.数组转置和轴对换

```
# 数组的T特性
arr = np.arange(15).reshape((3,5))
arr.T
#应用
arr = np.random.randn(6,3)
np.dot(arr.T,arr)
# 高维转置
arr = np.arange(24).reshape((2,3,4))
arr.transpose((1,0,2))
```
```
