%%%%%%�Զ���ֲ���ֵ��������imggcountΪ����ͼ��
%%%%%%positionΪ�洢�ֲ�ͼ���������������λ�þ���TΪ��ֵ
%%%%%%MΪ������ֵ�����ص�ת�����أ�NΪС����ֵ�����ص�ת������
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
