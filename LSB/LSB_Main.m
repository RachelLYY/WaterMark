%����ͼ��
ps=zeros(1,2623);
capacity=zeros(1,2623);
statistics_origin=zeros(1,256);
statistics_replace=zeros(1,256);
    %����512*512�Ҷ�ֵͼ��
    rand('state',012);
    cover_object=randi(255,512,512);
    %ȡ������ͼ��ĳ���
    Mc=size(cover_object,1);	%Height
    Nc=size(cover_object,2);	%Width
    %ѭ������watermark
    count1=1;
    %ͼƬ�ĺ�������
    for count=0:100:Mc*Nc
        %����ˮӡ��Ϣ
        rand('state',456);
        watermark=randn(1,count);
        %С��0����0 ����0����1
        watermark(find( watermark<0 ))=0;
        watermark(find( watermark>0 ))=1;
        [wm,wn]=size(watermark);
        watermarked_image=cover_object;
        c11=1;
        for i=1:Mc
            for j=1:Nc
                % Ƕ��count��bit
                if(c11<=count)
                    watermarked_image(i,j)=bitset(watermarked_image(i,j),1,watermark(1,c11));
                    c11=c11+1;
                end
            end
        end
        %����psnrֵ������
        ps(1,count1)=psnr(cover_object,watermarked_image,Mc,Nc);
        capacity(1,count1)=wm*wn/(Mc*Nc);
        count1=count1+1;       
    end

%����-psnr����ͼ
plot(capacity,ps,'b');
saveas(gcf,'psnr-capacity','bmp');
%��������
c1=1;
for k=1:2:255
    x1=sum(sum(cover_object==k));
    x2=sum(sum(cover_object==k-1));
    %����
    x=abs(x1-x2);
    y1=sum(sum(watermarked_image==k));
    y2=sum(sum(watermarked_image==k-1));
    y=abs(y1-y2);
    % ��ͼ
    statistics_origin(1,c1)=x;
    statistics_replace(1,c1)=y;
    c1=c1+1;
end
plot(statistics_origin)