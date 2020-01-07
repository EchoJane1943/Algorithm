```
Tuple 是不可变 list。 一旦创建了一个 tuple 就不能以任何方式改变它。

Tuple 与 list 的相同之处
定义 tuple 与定义 list 的方式相同, 除了整个元素集是用小括号包围的而不是方括号。
Tuple 的元素与 list 一样按定义的次序进行排序。 Tuples 的索引与 list 一样从 0 开始, 所以一个非空 tuple 的第一个元素总是 t[0]。
负数索引与 list 一样从 tuple 的尾部开始计数。
与 list 一样分片 (slice) 也可以使用。注意当分割一个 list 时, 会得到一个新的 list ；当分割一个 tuple 时, 会得到一个新的 tuple。

Tuple 不存在的方法
您不能向 tuple 增加元素。Tuple 没有 append 或 extend 方法。
您不能从 tuple 删除元素。Tuple 没有 remove 或 pop 方法。
然而, 您可以使用 in 来查看一个元素是否存在于 tuple 中。

用 Tuple 的好处
Tuple 比 list 操作速度快。如果您定义了一个值的常量集，并且唯一要用它做的是不断地遍历它，请使用 tuple 代替 list。
如果对不需要修改的数据进行 “写保护”，可以使代码更安全。使用 tuple 而不是 list 如同拥有一个隐含的 assert 语句，说明这一数据是常量。如果必须要改变这些值，则需要执行 tuple 到 list 的转换。

Tuple 与 list 的转换
Tuple 可以转换成 list，反之亦然。内置的 tuple 函数接收一个 list，并返回一个有着相同元素的 tuple。而 list 函数接收一个 tuple 返回一个 list。从效果上看，tuple 冻结一个 list，而 list 解冻一个 tuple。

Tuple 的其他应用
一次赋多值
>>> v = ('a', 'b', 'e')
>>> (x, y, z) = v
解释：v 是一个三元素的 tuple, 并且 (x, y, z) 是一个三变量的 tuple。将一个 tuple 赋值给另一个 tuple, 会按顺序将 v  的每个值赋值给每个变量。
```
