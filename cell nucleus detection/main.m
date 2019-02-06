img = imread('C:\Users\Kevin Liu\Documents\大三下\图像处理\实验四\cell2.BMP');   %读取图像
[height,width,flag] = size(img);  %读取尺寸
img=rgb2gray(img); 
imshow(img);title('原图');
img1=medfilt2(img); %中值滤波
figure;subplot(2,3,1);imshow(img1);title('中值滤波');
m=fspecial('average',[3,3]);  %均值滤波
img2=imfilter(img,m);
subplot(2,3,2);imshow(img2);title('均值滤波');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%形态学开运算，闭运算滤波
se=strel('disk',5);
img3=imopen(img,se);    %开运算
subplot(2,3,3);imshow(img3);title('开运算');
img4=imclose(img,se);   %闭运算
subplot(2,3,4);imshow(img4);title('闭运算');
img5=imclose(img3,se);   %先开后闭运算
subplot(2,3,5);imshow(img5);title('先开后闭运算');
img6=imopen(img4,se);   %先闭后开运算
subplot(2,3,6);imshow(img6);title('先闭后开运算');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%大津阈值求二值图像
[T1,SM]=graythresh(img1);  %中值滤波后的阈值分割
imga=im2bw(img1,T1);
figure;subplot(2,3,2);imshow(imga);title('中值滤波阈值分割');
%%%%%%%%%%%%%%%%%%%%%%%%均值滤波后的阈值分割
[T2,SM]=graythresh(img2);
imgb=im2bw(img2,T2);
subplot(2,3,3);imshow(imgb);title('均值滤波阈值分割');
%%%%%%%%%%%%%%%%%%%%%%%开运算阈值分割
[T3,SM]=graythresh(img3);
imgc=im2bw(img3,T3);
subplot(2,3,4);imshow(imgc);title('开运算阈值分割');
%%%%%%%%%%%%%%%%%%%%%%%%闭运算阈值分割
[T4,SM]=graythresh(img4);
imgd=im2bw(img4,T4);
subplot(2,3,5);imshow(imgd);title('闭运算阈值分割');
%%%%%%%%%%%%%%%%%%%%%%%先开后闭运算阈值分割
[T5,SM]=graythresh(img5);
imge=im2bw(img5,T5);
subplot(2,3,6);imshow(imge);title('先开后闭运算阈值分割');
%%%%%%%%%%%%%%%%%%%%%%%%先闭后开运算阈值分割
[T6,SM]=graythresh(img6);
imgf=im2bw(img6,T6);
subplot(2,3,1);imshow(imgf);title('先闭后开运算阈值分割');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%标记细胞用灰度1~RN
imgee=imcomplement(imge);  %imge取反，imge是img5（先开后闭运算）阈值分割后的二值图
figure;imshow(imgee,[]);title('imge(先开后闭二值图)取反图');
imgee=bwareaopen(imgee,500); %移除像素面积小于500的小连通区域；
figure;imshow(imgee,[]);title('imgee，imge(先开后闭二值图)取反图（移除小连通区）');     
figure;imhist(img5);    %画img5（先开后闭运算）灰度直方图
[g,NR,SI,TI]=regiongrow(imgee,1,0.26); %区域生长法标记连通区
g=uint8(g);            %g是标记图，NR是连通区数量
figure;imshow(g,[]);title('灰度标记图，灰度从1~NR（适应显示）');
%figure;imshow(SI,[]);
%figure;imshow(TI,[]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%提取细胞位置及灰度
imggcount= ones(height,width); %矩阵初始化，imggcount用于确定每个连通区域位置和面积
imggshow=zeros(height,width);   %用于展示最后结果
imggnewshow=zeros(height,width);  %用于展示最后核仁区分图总结果
T=zeros(1,NR); %用于记录每个连通区域的大津阈值
M=100;N=0;     %自定义函数area（）和im2bwnew()的参数，前者计算灰度值分别为M,N的像素数（面积），后者为二值化后的两种灰度值，M为大于阈值的像素的转换像素，N为小于阈值的像素的转换像素
areaCELLSUBSTANCE=zeros(NR,1);   %用于存储每个细胞的面积
areaCELLCORE=zeros(NR,1);  %用于存储每个细胞核的面积
areaRATIO_CC=zeros(NR,1);  %用于存储每个细胞的核胞比
areaRATIO_CS=zeros(NR,1);  %用于存放每个细胞的核质比
for k=1:NR               %循环计算每个细胞的信息
    clear position;      %清空位置矩阵
    clear row;
    clear line;
    clear imggcount;                %清空imggcount信息
    clear imggcountnew; 
    imggcount=ones(height,width);   %初始化
    imggcount(:,:)=255;             %使imggcount为最亮图（白）
     imggcount=uint8(imggcount);    %转为uint8型
    [row,line]=find(g==k);          %找到所有灰度为k的像素（第k个细胞）的行列信息
    position(:,1:2)=[row line];     %将位置信息赋值给位置矩阵
    [height1,width1] = size(position);  %计算位置矩阵高宽，高为像素数
    for i=1:height1 %将原图的滤波图像(img5)上位置为position存的位置信息的像素，赋值给用于计算的全亮图imggcount
            imggcount(position(i,1),position(i,2))=img5(position(i,1),position(i,2));
    end             %意义在于分别将NR个连通区域（细胞）从原图中抠出，单独成图
    figure;imshow(imggcount);title(['细胞No.' num2str(k)]);
      T(k)=otsunew(imggcount,position); %计算细胞k的局部大津阈值，这里定义新的大津阈值函数只采集细胞像素
      imggcountnew=im2bwnew(imggcount,T(k),position,M,N);%根据第k个细胞的局部大津阈值将position包含的像素位置二值化，两种灰度值分别为M,N
      figure;imshow(imggcountnew);title(['核胞区分图No.' num2str(k)]);
      [a,b]=area(imggcountnew,M,N);     %自定义函数area（）分别计算灰度为M,N的像素面积
      areaCELLCORE(k)=a;                %存储第k个细胞中灰度为M的像素个数（面积）
      areaCELLSUBSTANCE(k)=b;                  %存储第k个细胞中灰度为N的像素个数（面积）
      areaRATIO_CC(k)=a/(a+b);                 %存储第k个细胞中核胞面积比
      areaRATIO_CS(k)=a/b;                     %存储第k个细胞中核质面积比
    imggshow=imggshow+double(imggcount);       %将前k个细胞的灰度图放在一张白图上
    imggnewshow=imggnewshow+double(imggcountnew);  %将前k个细胞的二值图放在一张白纸上
end
figure;imshow(imggshow,[]);title('细胞图');           
figure;imshow(imggnewshow,[]);title('细胞核胞二值图');  
aa=ones(NR,1); 
aa=cumsum(aa);
table=[aa areaCELLCORE areaCELLSUBSTANCE areaRATIO_CC areaRATIO_CS];  %存储细胞面积数据
bb={'序号','细胞核面积/像素数','细胞面积/像素数','核胞面积比','核质面积比'};%第一列加标题
disp(bb);   %打印到命令行窗口
disp(table);

