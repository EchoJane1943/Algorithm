# pandas

## pandas数据结构--Series & DataFrame

```
import pandas as pd
obj = pd.Series([4,7,-5,3])
obj
obj.values
obj.index

obj2 = pd.Series([4,7,-5,3],index = ['d','b','a','c'])
obj2['a']
obj['d'] = 6
obj2[['c','a','d']]

'b' in obj2 # True
```
