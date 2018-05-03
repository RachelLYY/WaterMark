%psnr矩阵
ps=zeros(1,2623);
%容量矩阵
capacity=zeros(1,2623);
%生成512*512灰度图像
rand('state',012);
cover_object=randi(255,512,512);
Mc=size(cover_object,1);	%Height
Nc=size(cover_object,2);	%Width
count1=1;
for count=0:100:Mc*Nc
    %产生一维01随机数矩阵 作为水印
    rand('state',456);
    watermark=randn(1,count);
    watermark(find( watermark<0 ))=0;
    watermark(find( watermark>0 ))=1;
    [wm,wn]=size(watermark);
    %产生和水印同等长度的01矩阵
    rand('state',123);
    A=randn(1,count);
    B=mod(uint8(A),2);
    watermarked_image=cover_object;
    for i = 1:wm
        for j = 1:wn
            %查看当前像素值末尾是0还是1
            pix=mod(watermarked_image(mod(i+(fix(j/Nc+1))-1,Mc)+1,mod(j-1,Nc)+1),2);
            %转换为二进制
            if(pix~=watermark(i,j))
                if(B(i,j)==1)
                    watermarked_image(mod(i+(fix(j/Nc+1))-1,Mc)+1,mod(j-1,Nc)+1)=watermarked_image(mod(i+(fix(j/Nc+1))-1,Mc)+1,mod(j-1,Nc)+1)+1;
                end
                if(B(i,j)==0)
                    watermarked_image(mod(i+(fix(j/Nc+1))-1,Mc)+1,mod(j-1,Nc)+1)=watermarked_image(mod(i+(fix(j/Nc+1))-1,Mc)+1,mod(j-1,Nc)+1)-1;
                end
            end
        end
    end
    ps(1,count1)=psnr(cover_object,watermarked_image,Mc,Nc);
    capacity(1,count1)=wm*wn/(Mc*Nc);
    count1=count1+1;
end

plot(capacity,ps,'g');
saveas(gcf,'LSB-match','bmp');
statics_match=zeros(1,256);
statistics_origin1=zeros(1,256);
index=zeros(1,2000);
for i1=1:256
    index(1,i1)=i1-1;
end
c1=1;
for k=1:2:255
    %计算相邻灰度值个数的差值
    x1=sum(sum(cover_object==k));
    x2=sum(sum(cover_object==k-1));
    x=abs(x1-x2);
    y1=sum(sum(watermarked_image==k));
    y2=sum(sum(watermarked_image==k-1));
    y=abs(y1-y2);
    statistics_origin1(1,c1)=x;
    statics_match(1,c1)=y;
    c1=c1+1;
end
