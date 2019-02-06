%%%%定义分别计算灰度为M,N的像素个数，im为输入图像
%%%%areaM,areaN为对应的像素个数
function [areaM,areaN]=area(img,M,N)
[a,~]=find(img==M);
areaM=numel(a);
[c,~]=find(img==N);
areaN=numel(c);
clear img;
end