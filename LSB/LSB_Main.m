%测试图像
ps=zeros(1,2623);
capacity=zeros(1,2623);
statistics_origin=zeros(1,256);
statistics_replace=zeros(1,256);
    %生成512*512灰度值图像
    rand('state',012);
    cover_object=randi(255,512,512);
    %取出载体图像的长宽
    Mc=size(cover_object,1);	%Height
    Nc=size(cover_object,2);	%Width
    %循环产生watermark
    count1=1;
    %图片的横纵坐标
    for count=0:100:Mc*Nc
        %产生水印信息
        rand('state',456);
        watermark=randn(1,count);
        %小于0的置0 大于0的置1
        watermark(find( watermark<0 ))=0;
        watermark(find( watermark>0 ))=1;
        [wm,wn]=size(watermark);
        watermarked_image=cover_object;
        c11=1;
        for i=1:Mc
            for j=1:Nc
                % 嵌入count个bit
                if(c11<=count)
                    watermarked_image(i,j)=bitset(watermarked_image(i,j),1,watermark(1,c11));
                    c11=c11+1;
                end
            end
        end
        %计算psnr值和容量
        ps(1,count1)=psnr(cover_object,watermarked_image,Mc,Nc);
        capacity(1,count1)=wm*wn/(Mc*Nc);
        count1=count1+1;       
    end

%容量-psnr曲线图
plot(capacity,ps,'b');
saveas(gcf,'psnr-capacity','bmp');
%卡方分析
c1=1;
for k=1:2:255
    x1=sum(sum(cover_object==k));
    x2=sum(sum(cover_object==k-1));
    %做差
    x=abs(x1-x2);
    y1=sum(sum(watermarked_image==k));
    y2=sum(sum(watermarked_image==k-1));
    y=abs(y1-y2);
    % 绘图
    statistics_origin(1,c1)=x;
    statistics_replace(1,c1)=y;
    c1=c1+1;
end
plot(statistics_origin)