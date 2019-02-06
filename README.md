# cell-nucleus-detection

open main.m and replace code below with your path of cell picture
```
img = imread('C:\Users\Kevin Liu\Documents\大三下\图像处理\实验四\cell2.BMP');
```
The results below were from an old version. Now you can achieve better results by running main.m
### cells
![cells](https://raw.githubusercontent.com/papayalove/cell-nucleus-detection/master/cell%20nucleus%20detection/cell2.bmp "cells")
### cells after filters
![cells after filters](https://raw.githubusercontent.com/papayalove/cell-nucleus-detection/master/pictures/cells_progress1.png "cells after filters")
### cells after otsu
![cells after otsu](https://raw.githubusercontent.com/papayalove/cell-nucleus-detection/master/pictures/cells_progress2.png "cells after otsu")
### cells grayscale-reversed
![cells reversed in grayscale](https://raw.githubusercontent.com/papayalove/cell-nucleus-detection/master/pictures/cells_progress3.png "cells reversed in grayscale")
### cells grayscale-labeled
![cells grayscale-labeled](https://raw.githubusercontent.com/papayalove/cell-nucleus-detection/master/pictures/cells_progress4.png "cells grayscale-labeled")
### cells separated result
![cells separated result](https://raw.githubusercontent.com/papayalove/cell-nucleus-detection/master/pictures/cells_result1.png "cells separated result")
### cells separated result2
![cells separated result2](https://raw.githubusercontent.com/papayalove/cell-nucleus-detection/master/pictures/cells_result2.png "cells separated result2")
### cells result
![cells result](https://raw.githubusercontent.com/papayalove/cell-nucleus-detection/master/pictures/cells_result_final1.png "cells result")
### cells result2
![cells result2](https://raw.githubusercontent.com/papayalove/cell-nucleus-detection/master/pictures/cells_result_final2.png "cells result2")
### results
nucleus area|cell area|ratio of nucleus to cell|ratio of nucleus to Cytoplasm
--|:--:|--:|--:
375|2084|0.1525|0.1799
532|1837|0.2246|0.2896
619|1739|0.2625|0.3560
750|2722|0.2160|0.2755
562|3058|0.1552|0.1838
0	 |1130|0	   |0
407|1713|0.1920|0.2376
399|2534|0.1360|0.1575
599|2415|0.1987|0.2480
583|2168|0.2119|0.2689
618|1794|0.2562|0.3445
0	 |952	|0	   |0
688|3038|0.1846|0.2264
389|1845|0.1741|0.2108
0	 |726 |0     |0
