%%%%����ֱ����Ҷ�ΪM,N�����ظ�����imΪ����ͼ��
%%%%areaM,areaNΪ��Ӧ�����ظ���
function [areaM,areaN]=area(img,M,N)
[a,~]=find(img==M);
areaM=numel(a);
[c,~]=find(img==N);
areaN=numel(c);
clear img;
end