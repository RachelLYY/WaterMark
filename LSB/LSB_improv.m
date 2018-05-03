function [psnr] = LSB_improv(x,P)
%卡方分析
%缺陷：传统LSB替换算法（后缀为0加1或不变/后缀为1减1或不变） 会使得奇数偶数的个数逐渐接近 和之前图片区别明显
%
%MEssage='liuyanyan';
%P=imread('lena512.bmp');
curposl=1;
curposc=1;
%复制P得到M（方便后续对比）
[pi,pj]=size(P);
M=zeros(pi,pj);
M(1:pi,1:pj)=P;
[xl,xc]=size(x);
for i=1:xl
    for j=1:xc
        %取出当前待嵌入字符
        c=x(i,j);
        %取出当前像素值
        pix=P(curposl,curposc);
        %转换为二进制
        bin=dec2base(pix,2,8);
        %最低位和当前字符比较
        if bin(1,8)~=c
            %随机生成-1/1 修改图片灰度值
            r=randi(1)-2;
            P(curposl,curposc)=P(curposl,curposc)+r;
        end
        %修改图片行列值
        curposc=mod(curposc,pi)+1;
        curposl=(curposl+fix((curposc+1)/pj));
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