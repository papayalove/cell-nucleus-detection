img = imread('C:\Users\Kevin Liu\Documents\������\ͼ����\ʵ����\cell2.BMP');   %��ȡͼ��
[height,width,flag] = size(img);  %��ȡ�ߴ�
img=rgb2gray(img); 
imshow(img);title('ԭͼ');
img1=medfilt2(img); %��ֵ�˲�
figure;subplot(2,3,1);imshow(img1);title('��ֵ�˲�');
m=fspecial('average',[3,3]);  %��ֵ�˲�
img2=imfilter(img,m);
subplot(2,3,2);imshow(img2);title('��ֵ�˲�');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��̬ѧ�����㣬�������˲�
se=strel('disk',5);
img3=imopen(img,se);    %������
subplot(2,3,3);imshow(img3);title('������');
img4=imclose(img,se);   %������
subplot(2,3,4);imshow(img4);title('������');
img5=imclose(img3,se);   %�ȿ��������
subplot(2,3,5);imshow(img5);title('�ȿ��������');
img6=imopen(img4,se);   %�ȱպ�����
subplot(2,3,6);imshow(img6);title('�ȱպ�����');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����ֵ���ֵͼ��
[T1,SM]=graythresh(img1);  %��ֵ�˲������ֵ�ָ�
imga=im2bw(img1,T1);
figure;subplot(2,3,2);imshow(imga);title('��ֵ�˲���ֵ�ָ�');
%%%%%%%%%%%%%%%%%%%%%%%%��ֵ�˲������ֵ�ָ�
[T2,SM]=graythresh(img2);
imgb=im2bw(img2,T2);
subplot(2,3,3);imshow(imgb);title('��ֵ�˲���ֵ�ָ�');
%%%%%%%%%%%%%%%%%%%%%%%��������ֵ�ָ�
[T3,SM]=graythresh(img3);
imgc=im2bw(img3,T3);
subplot(2,3,4);imshow(imgc);title('��������ֵ�ָ�');
%%%%%%%%%%%%%%%%%%%%%%%%��������ֵ�ָ�
[T4,SM]=graythresh(img4);
imgd=im2bw(img4,T4);
subplot(2,3,5);imshow(imgd);title('��������ֵ�ָ�');
%%%%%%%%%%%%%%%%%%%%%%%�ȿ����������ֵ�ָ�
[T5,SM]=graythresh(img5);
imge=im2bw(img5,T5);
subplot(2,3,6);imshow(imge);title('�ȿ����������ֵ�ָ�');
%%%%%%%%%%%%%%%%%%%%%%%%�ȱպ�������ֵ�ָ�
[T6,SM]=graythresh(img6);
imgf=im2bw(img6,T6);
subplot(2,3,1);imshow(imgf);title('�ȱպ�������ֵ�ָ�');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ϸ���ûҶ�1~RN
imgee=imcomplement(imge);  %imgeȡ����imge��img5���ȿ�������㣩��ֵ�ָ��Ķ�ֵͼ
figure;imshow(imgee,[]);title('imge(�ȿ���ն�ֵͼ)ȡ��ͼ');
imgee=bwareaopen(imgee,500); %�Ƴ��������С��500��С��ͨ����
figure;imshow(imgee,[]);title('imgee��imge(�ȿ���ն�ֵͼ)ȡ��ͼ���Ƴ�С��ͨ����');     
figure;imhist(img5);    %��img5���ȿ�������㣩�Ҷ�ֱ��ͼ
[g,NR,SI,TI]=regiongrow(imgee,1,0.26); %���������������ͨ��
g=uint8(g);            %g�Ǳ��ͼ��NR����ͨ������
figure;imshow(g,[]);title('�Ҷȱ��ͼ���Ҷȴ�1~NR����Ӧ��ʾ��');
%figure;imshow(SI,[]);
%figure;imshow(TI,[]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ȡϸ��λ�ü��Ҷ�
imggcount= ones(height,width); %�����ʼ����imggcount����ȷ��ÿ����ͨ����λ�ú����
imggshow=zeros(height,width);   %����չʾ�����
imggnewshow=zeros(height,width);  %����չʾ����������ͼ�ܽ��
T=zeros(1,NR); %���ڼ�¼ÿ����ͨ����Ĵ����ֵ
M=100;N=0;     %�Զ��庯��area������im2bwnew()�Ĳ�����ǰ�߼���Ҷ�ֵ�ֱ�ΪM,N���������������������Ϊ��ֵ��������ֻҶ�ֵ��MΪ������ֵ�����ص�ת�����أ�NΪС����ֵ�����ص�ת������
areaCELLSUBSTANCE=zeros(NR,1);   %���ڴ洢ÿ��ϸ�������
areaCELLCORE=zeros(NR,1);  %���ڴ洢ÿ��ϸ���˵����
areaRATIO_CC=zeros(NR,1);  %���ڴ洢ÿ��ϸ���ĺ˰���
areaRATIO_CS=zeros(NR,1);  %���ڴ��ÿ��ϸ���ĺ��ʱ�
for k=1:NR               %ѭ������ÿ��ϸ������Ϣ
    clear position;      %���λ�þ���
    clear row;
    clear line;
    clear imggcount;                %���imggcount��Ϣ
    clear imggcountnew; 
    imggcount=ones(height,width);   %��ʼ��
    imggcount(:,:)=255;             %ʹimggcountΪ����ͼ���ף�
     imggcount=uint8(imggcount);    %תΪuint8��
    [row,line]=find(g==k);          %�ҵ����лҶ�Ϊk�����أ���k��ϸ������������Ϣ
    position(:,1:2)=[row line];     %��λ����Ϣ��ֵ��λ�þ���
    [height1,width1] = size(position);  %����λ�þ���߿���Ϊ������
    for i=1:height1 %��ԭͼ���˲�ͼ��(img5)��λ��Ϊposition���λ����Ϣ�����أ���ֵ�����ڼ����ȫ��ͼimggcount
            imggcount(position(i,1),position(i,2))=img5(position(i,1),position(i,2));
    end             %�������ڷֱ�NR����ͨ����ϸ������ԭͼ�пٳ���������ͼ
    figure;imshow(imggcount);title(['ϸ��No.' num2str(k)]);
      T(k)=otsunew(imggcount,position); %����ϸ��k�ľֲ������ֵ�����ﶨ���µĴ����ֵ����ֻ�ɼ�ϸ������
      imggcountnew=im2bwnew(imggcount,T(k),position,M,N);%���ݵ�k��ϸ���ľֲ������ֵ��position����������λ�ö�ֵ�������ֻҶ�ֵ�ֱ�ΪM,N
      figure;imshow(imggcountnew);title(['�˰�����ͼNo.' num2str(k)]);
      [a,b]=area(imggcountnew,M,N);     %�Զ��庯��area�����ֱ����Ҷ�ΪM,N���������
      areaCELLCORE(k)=a;                %�洢��k��ϸ���лҶ�ΪM�����ظ����������
      areaCELLSUBSTANCE(k)=b;                  %�洢��k��ϸ���лҶ�ΪN�����ظ����������
      areaRATIO_CC(k)=a/(a+b);                 %�洢��k��ϸ���к˰������
      areaRATIO_CS(k)=a/b;                     %�洢��k��ϸ���к��������
    imggshow=imggshow+double(imggcount);       %��ǰk��ϸ���ĻҶ�ͼ����һ�Ű�ͼ��
    imggnewshow=imggnewshow+double(imggcountnew);  %��ǰk��ϸ���Ķ�ֵͼ����һ�Ű�ֽ��
end
figure;imshow(imggshow,[]);title('ϸ��ͼ');           
figure;imshow(imggnewshow,[]);title('ϸ���˰���ֵͼ');  
aa=ones(NR,1); 
aa=cumsum(aa);
table=[aa areaCELLCORE areaCELLSUBSTANCE areaRATIO_CC areaRATIO_CS];  %�洢ϸ���������
bb={'���','ϸ�������/������','ϸ�����/������','�˰������','���������'};%��һ�мӱ���
disp(bb);   %��ӡ�������д���
disp(table);

