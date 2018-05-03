function [psnr] = LSB_improv(x,P)
%��������
%ȱ�ݣ���ͳLSB�滻�㷨����׺Ϊ0��1�򲻱�/��׺Ϊ1��1�򲻱䣩 ��ʹ������ż���ĸ����𽥽ӽ� ��֮ǰͼƬ��������
%
%MEssage='liuyanyan';
%P=imread('lena512.bmp');
curposl=1;
curposc=1;
%����P�õ�M����������Աȣ�
[pi,pj]=size(P);
M=zeros(pi,pj);
M(1:pi,1:pj)=P;
[xl,xc]=size(x);
for i=1:xl
    for j=1:xc
        %ȡ����ǰ��Ƕ���ַ�
        c=x(i,j);
        %ȡ����ǰ����ֵ
        pix=P(curposl,curposc);
        %ת��Ϊ������
        bin=dec2base(pix,2,8);
        %���λ�͵�ǰ�ַ��Ƚ�
        if bin(1,8)~=c
            %�������-1/1 �޸�ͼƬ�Ҷ�ֵ
            r=randi(1)-2;
            P(curposl,curposc)=P(curposl,curposc)+r;
        end
        %�޸�ͼƬ����ֵ
        curposc=mod(curposc,pi)+1;
        curposl=(curposl+fix((curposc+1)/pj));
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