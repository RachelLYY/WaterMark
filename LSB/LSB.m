function [psnr] = LSB(x,P)
%输入嵌入字符 返回PSNR值
%主程序不断调用该函数
%嵌入方式：1.顺序/随机嵌入 2.嵌入信息加密/不加密 
%研究：1.嵌入信息为多长（嵌入率为多少）时可能会使得图像质量下降 求出PSNR 
%绘图：画出嵌入后和嵌入前的直方图并进行对比。（hist+bar）

%--------------------------------样本一：顺序嵌入；message不加密；只嵌入最低位---------------------------------%
%PSNR值计算
%将待嵌入秘密信息转成二进制
%convert ascii code to char
%y=char(bin2dec(x));
%当前图片像素的下标。curposl表示列；curposc表示行。
curposl=1;
curposc=1;
%复制P得到M（方便后续对比）
[i,j]=size(P);
M=zeros(i,j);
M(1:i,1:j)=P;
%循环嵌入
[xl,xc]=size(x);
for i=1:xl
    for j=1:xc
        %取出当前待嵌入字符
        c=x(i,j);
        %取出当前像素值
        pix=P(curposl,curposc);
        %转换为二进制
        bin=dec2base(pix,2,8);
        %修改最低位
        bin(1,8)=c;     
        %写回图片中      
        m=bin2dec(bin);    
        P(curposl,curposc)=m;
        %修改图片行列值
        curposc=mod(curposc,i)+1;
        curposl=(curposl+fix((curposc+1)/j));
        %如果行下标大于总行数，报错。
        if curposl>size(P,1)
            print 'The message is too large!';
            exit(1);
        end              
    end
end
%绘制直方图
%hist(M(:),0:255);
%hist(P(:),0:255);
%计算PSNR值 
%将图像转换为double
A = double(P);
B = double(M);
a=0;
[line,colume]=size(A);
for i=1:line
    for j=1:colume
        a=a+(A(i,j)-B(i,j))*(A(i,j)-B(i,j));
    end
end
% imshow(P,'border','tight','initialmagnification','fit');
% set (gcf,'Position',[0,0,500,500]);
% IAFS = getimage(gcf);
% imwrite(IAFS,'index_least.bmp');

MSE=a / (line*colume);

psnr=10*log10(double(255*255/MSE));
end