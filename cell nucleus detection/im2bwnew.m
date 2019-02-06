%%%%%%自定义局部二值化函数，imggcount为输入图像
%%%%%%position为存储局部图像像素行列坐标的位置矩阵，T为阈值
%%%%%%M为大于阈值的像素的转换像素，N为小于阈值的像素的转换像素
function imggcount=im2bwnew(imggcount,T,position,M,N) 
  [height1,width1] = size(position);
for i=1:height1
    if imggcount(position(i,1),position(i,2))<T*255;
        imggcount(position(i,1),position(i,2))=M;
    else
        imggcount(position(i,1),position(i,2))=N;
    end
end
    clear immggcount;
    clear position;
end
