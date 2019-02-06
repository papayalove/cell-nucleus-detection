%%%%区域生长算法摘自《数字图像处理第二版》
%%%%f为输入图像，S为种子点灰度，T为连通域划分阈值
%%%%g为连通域标记图，NR为连通域个数
function [g,NR,SI,TI]=regiongrow(f,S,T)  
f=double(f);
if numel(S)==1
    SI=f==S;
    S1=S;
else
    SI=bwmorph(S,'shrink',Inf);
    S1=f(SI);
end
TI=false(size(f));
for K=1:length(S1)
    seedvalue=S1(K);
    S=abs(f-seedvalue)<=T;
    TI=TI|S;
end
[g,NR]=bwlabel(imreconstruct(SI,TI));