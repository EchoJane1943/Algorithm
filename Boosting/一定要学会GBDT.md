references:

[1]https://blog.csdn.net/niuniuyuh/article/details/76922210

[2]paper:greedy function approximation: a gradient boosting machine

简介：GBDT：Gradient BoostingDecisionTree，基于boosting的思想，并行地构造多棵决策树来进行数据的预测。具有特征自动组合、高效运算等特点

疑问：为什么能够实现特征自动组合，高效运算等。

先验知识：CART（因为GBDT的T即为CART回归树）

## CART
reference:https://www.cnblogs.com/yonghao/p/5135386.html

1）CART can be classification tree or regression tree

2）when classification tree,采用GINI值作为分裂依据；when regression tree，采用样本的最小方差作为分裂依据

3）CART是一颗二叉树

<a href="https://www.codecogs.com/eqnedit.php?latex=gain&space;=&space;\sum\sigma_i" target="_blank"><img src="https://latex.codecogs.com/gif.latex?gain&space;=&space;\sum\sigma_i" title="gain = \sum\sigma_i" /></a>
