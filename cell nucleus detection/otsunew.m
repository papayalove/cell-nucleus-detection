%%%%�����µľֲ������ֵ���㺯����imΪ�������
%%%%positionΪ�洢�ֲ�ͼ���������������λ�þ���
%%%%TΪ�õ��ľֲ������ֵ
function T=otsunew(im,position)
count=imhistnew(im,position);       %��ȡ�Ҷ������������ͻҶ�ֵ����
x=ones(256,1);
x=cumsum(x)-1;
[height,width] = size(im);  %��ȡͼ��߶ȿ��
N=length(im);             %��ȡ������
%summ=sum(count);  %N
pi=count/N;                 %����Ҷ�ֵ��������
%summ2=sum(pi);    %ֵΪ1
r2=zeros(1,256);            %����һ��256���ȵ������������淽��ֵ
for T=0:numel(x)-1          %��ֵT����0~255
     w0=sum(pi(1:T+1));     %T�����ĸ���
     w1=1-w0;               %T�Ҳ���ĸ���
     a=pi.*x;               %����Ҷ�ֵ��������
     u0=sum(a(1:T+1))/w0;   %��������Ҷ�������
     u1=sum(a(T+2:numel(x)))/w1;  %��������Ҷ�������
     r2(T+1)=w0*w1*(u1-u0)^2;     %���������ķ���
     R2=max(r2);                  %��¼��󷽲�
end
c=find(r2==R2);      %�ҵ���󷽲��Ӧ��T
T=(c(1)-1)/255;          %T��һ��
clear im;
clear position;
clear count;
end