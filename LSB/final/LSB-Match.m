%psnr����
ps=zeros(1,2623);
%��������
capacity=zeros(1,2623);
%����512*512�Ҷ�ͼ��
rand('state',012);
cover_object=randi(255,512,512);
Mc=size(cover_object,1);	%Height
Nc=size(cover_object,2);	%Width
count1=1;
for count=0:100:Mc*Nc
    %����һά01��������� ��Ϊˮӡ
    rand('state',456);
    watermark=randn(1,count);
    watermark(find( watermark<0 ))=0;
    watermark(find( watermark>0 ))=1;
    [wm,wn]=size(watermark);
    %������ˮӡͬ�ȳ��ȵ�01����
    rand('state',123);
    A=randn(1,count);
    B=mod(uint8(A),2);
    watermarked_image=cover_object;
    for i = 1:wm
        for j = 1:wn
            %�鿴��ǰ����ֵĩβ��0����1
            pix=mod(watermarked_image(mod(i+(fix(j/Nc+1))-1,Mc)+1,mod(j-1,Nc)+1),2);
            %ת��Ϊ������
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
    %�������ڻҶ�ֵ�����Ĳ�ֵ
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
