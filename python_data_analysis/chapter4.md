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
# 数组的T特性 二维
arr = np.arange(15).reshape((3,5))
arr.T
#应用
arr = np.random.randn(6,3)
np.dot(arr.T,arr)
# 高维转置 
arr = np.arange(24).reshape((2,3,4))
arr.transpose((1,0,2))

# another method
arr.swapaxes(0,1)
```
https://zhuanlan.zhihu.com/p/61203757

~~我爱知乎（doge）~~


## 通用函数ufunc：快速的元素级数组函数
 简单函数的矢量化包装器
 
 ```
  # 一元ufunc
 arr = np.arange(10)
 np.sqrt(arr)
 np.exp(arr)
 # 二元ufunc
 x = randn(8)
 y = randn(8)
 np.maximum(x,y) #返回每一个位置x y 中的最大值
 
 
 arr = np.random.randn(7)*5
 np.modf(arr) # 分别返回arr的小数部分和整数部分
 ```
常见的一元ufunc
```
abs、fabs 计算绝对值，fabs对于非复数值计算更加快
sqrt 平方根
square 平方
exp 指数e^x
log、log10、log2、log1p 底数分别为e、10、2、（1+p)
sign 计算正负号，1，0，-1
ceil 大于等于该值的最小整数
floor 小于等于该值的最大整数
rint 四舍五入到整数
modf 返回小数和整数部分
innan 
infinite、isinf
cos、cosh、sin、sinh、tan、tanh、arccos、arccosh、arcsin、arcsinh、arctan、arctanh
logical_not 计算not x的值
```
二元ufunc
```
add 加法
subtract 减法
multiply 乘法
divide\floor_divide 除法、向下整除法（丢弃余数）
power 次方
maximum\fax\minimum\fmin 计算最大值或者最小值（fmam\fmin会忽略NaN
mod 求模（除法的余数）
copysign 复制符号，将第二数组的符号复制给第一个数组
greater\greater_equal\less\less_equal\equal\not_equal 
logical_and\logical_or\logical_xor 与或异或
```

## 利用数组进行数据处理
网格型计算
```
points = np.arange(-5,5,0.01) # 1000 个等间隔点
xs,ys = np.meshgrid(points,points)
z = np.sqrt(xs**2+ys**2)
import matplotlib.pyplot as plt
plt.imshow(z,cmap = plt.cm.gray);plt.colorbar()
```

### 将条件逻辑表述为数组运算
```
# np.where 是三元表达式 x if condition else y 的矢量化版本
 xarr = np.array([1.1,1.2,1.3,1.4,1.5])
 yarr = np.array([2.1,2.2,2.3,2.4,2.5])
 cond = np.array([True,False,True,True,False])
 
 result = [(x if c else y) for x,y,c in zip(xarr,yarr,cond)]
 # 上述对于大数组的处理速度不是很快，且无法应用于多维数组
 # 使用np.where
 result = np.where(cond,xarr,yarr)
```
### 数学和统计方法

```
sum
mean
std\var
min\max
argmin\argmax 最大值、最小值的索引
cumsum 所有元素的累计和
cumprod 所有元素的累积积
```


上述方法中，布尔值会被强制转换为1（TRUE）和0（FALSE）。

```
import numpy as np
arr = np.random.randn(100)
(arr>0).sum()
```

```
bools = np.array([False,False,True,False])
bools.any()
bools.all()
# any & all用于非布尔型数组时，非0元素都会被当作True。
```

``` 
# 排序
import numpy as np
arr = np.random.randn(8)
arr.sort()# 直接改变arr
#多维
arr = np.random.randn(3,5)
arr.sort(1)# 直接改变arr
```

### 唯一化和其他的集合逻辑

np.unique(arr)可以找出数组中的唯一值并返回已排序的结果，等价于纯python代码sorted(set(arr))
np.unique(arr)可以找出数组中的唯一值并返回已排序的结果，等价于纯python代码sorted(set(

