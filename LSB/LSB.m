function [psnr] = LSB(x,P)
%����Ƕ���ַ� ����PSNRֵ
%�����򲻶ϵ��øú���
%Ƕ�뷽ʽ��1.˳��/���Ƕ�� 2.Ƕ����Ϣ����/������ 
%�о���1.Ƕ����ϢΪ�೤��Ƕ����Ϊ���٣�ʱ���ܻ�ʹ��ͼ�������½� ���PSNR 
%��ͼ������Ƕ����Ƕ��ǰ��ֱ��ͼ�����жԱȡ���hist+bar��

%--------------------------------����һ��˳��Ƕ�룻message�����ܣ�ֻǶ�����λ---------------------------------%
%PSNRֵ����
%����Ƕ��������Ϣת�ɶ�����
%convert ascii code to char
%y=char(bin2dec(x));
%��ǰͼƬ���ص��±ꡣcurposl��ʾ�У�curposc��ʾ�С�
curposl=1;
curposc=1;
%����P�õ�M����������Աȣ�
[i,j]=size(P);
M=zeros(i,j);
M(1:i,1:j)=P;
%ѭ��Ƕ��
[xl,xc]=size(x);
for i=1:xl
    for j=1:xc
        %ȡ����ǰ��Ƕ���ַ�
        c=x(i,j);
        %ȡ����ǰ����ֵ
        pix=P(curposl,curposc);
        %ת��Ϊ������
        bin=dec2base(pix,2,8);
        %�޸����λ
        bin(1,8)=c;     
        %д��ͼƬ��      
        m=bin2dec(bin);    
        P(curposl,curposc)=m;
        %�޸�ͼƬ����ֵ
        curposc=mod(curposc,i)+1;
        curposl=(curposl+fix((curposc+1)/j));
        %������±����������������
        if curposl>size(P,1)
            print 'The message is too large!';
            exit(1);
        end              
    end
end
%����ֱ��ͼ
%hist(M(:),0:255);
%hist(P(:),0:255);
%����PSNRֵ 
%��ͼ��ת��Ϊdouble
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