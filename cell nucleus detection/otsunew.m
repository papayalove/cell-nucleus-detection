%%%%定义新的局部大津阈值计算函数，im为输入参数
%%%%position为存储局部图像像素行列坐标的位置矩阵
%%%%T为得到的局部大津阈值
function T=otsunew(im,position)
count=imhistnew(im,position);       %获取灰度像素数向量和灰度值向量
x=ones(256,1);
x=cumsum(x)-1;
[height,width] = size(im);  %获取图像高度宽度
N=length(im);             %获取像素数
%summ=sum(count);  %N
pi=count/N;                 %计算灰度值概率向量
%summ2=sum(pi);    %值为1
r2=zeros(1,256);            %产生一个256长度的零数组用来存方差值
for T=0:numel(x)-1          %阈值T遍历0~255
     w0=sum(pi(1:T+1));     %T左侧组的概率
     w1=1-w0;               %T右侧组的概率
     a=pi.*x;               %计算灰度值期望向量
     u0=sum(a(1:T+1))/w0;   %计算左组灰度总期望
     u1=sum(a(T+2:numel(x)))/w1;  %计算右组灰度总期望
     r2(T+1)=w0*w1*(u1-u0)^2;     %计算两组间的方差
     R2=max(r2);                  %记录最大方差
end
c=find(r2==R2);      %找到最大方差对应的T
T=(c(1)-1)/255;          %T归一化
clear im;
clear position;
clear count;
end