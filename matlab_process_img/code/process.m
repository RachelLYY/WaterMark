M=imread('goldhill512.bmp');
%�Ӹ�˹����
P1=imnoise(M,'gaussian');
%��ͼƬȫ����ʾ ȥ�ױ�
imshow(P1,'border','tight','initialmagnification','fit');
set (gcf,'Position',[0,0,500,500]);
axis normal;
%��ͼ���Ϊbmp��ʽ 
IG = getimage(gcf);
imwrite(IG,'gaussian.bmp');
 
%�ӽ�������
P2=imnoise(M,'salt & pepper');
imshow(P2,'border','tight','initialmagnification','fit');
set (gcf,'Position',[0,0,500,500]);
axis normal;
imshow(P2);
IS = getimage(gcf);
imwrite(IS,'salt&pepper.bmp');
%Ĭ�ϵ������ܶ�Ϊ0.05
 
%��˹������ֵ�˲�
G=imread('gaussian.bmp');
%����ϵͳԤ�����3X3�˲���  
A=fspecial('average'); 
%�����ɵ��˲��������˲�  
Y=imfilter(G,A);      
imshow(Y,'border','tight','initialmagnification','fit');
set (gcf,'Position',[0,0,500,500]);
IAFG = getimage(gcf);
imwrite(IAFG,'aver_filter_gaussian.bmp');
 
%����������ֵ�˲�
S=imread('salt&pepper.bmp');
%����ϵͳԤ�����3X3�˲���  
A=fspecial('average'); 
%�����ɵ��˲��������˲�  
Y=imfilter(S,A);      
imshow(Y,'border','tight','initialmagnification','fit');
set (gcf,'Position',[0,0,500,500]);
IAFS = getimage(gcf);
imwrite(IAFS,'aver_filter_salt.bmp');
 
%��˹������ֵ�˲�
g=medfilt2(G);
imshow(g,'border','tight','initialmagnification','fit');
set (gcf,'Position',[0,0,500,500]);
IMFG = getimage(gcf);
imwrite(IMFG,'mid_filter_gaussian.bmp');
 
%����������ֵ�˲�
g=medfilt2(S);
imshow(g,'border','tight','initialmagnification','fit');
IMFS = getimage(gcf);
imwrite(IMFS,'mid_filter_salt.bmp');
 
%��˹����ֱ��ͼ
imhist(G);
%��˹��ֵ�˲�ֱ��ͼ
GauFilterA=imread('aver_filter_gaussian.bmp');
imhist(GauFilterA);
%��˹��ֵ�˲�ֱ��ͼ
GauFilterM=imread('mid_filter_gaussian.bmp');
imhist(GauFilterM);
 
%��������ֱ��ͼ
imhist(S);
%���ξ�ֵ�˲�ֱ��ͼ
SaltFilterA=imread('aver_filter_salt.bmp');
imhist(SaltFilterA);
%��˹��ֵ�˲�ֱ��ͼ
SaltFilterM=imread('mid_filter_salt.bmp');
imhist(SaltFilterM);
 
%���и�˹������ͼƬ��һ�ײ��ֱ��ͼ
GauDiff=diff(G,1);
imhist(GauDiff);
%���и�˹������ͼƬ��ֵ�˲����һ�ײ��ֱ��ͼ
GauAverDiff=diff(GauFilterA,1);
imhist(GauAverDiff);
%���и�˹������ͼƬ��ֵ�˲����һ�ײ��ֱ��ͼ
GauMidDiff=diff(GauFilterM,1);
imhist(GauMidDiff);
 
%���н���������ͼƬ��һ�ײ��ֱ��ͼ
SaltDiff=diff(S,1);
imhist(SaltDiff);
%���н���������ͼƬ��ֵ�˲����һ�ײ��ֱ��ͼ
SaltAverDiff=diff(SaltFilterA,1);
imhist(SaltAverDiff );
%���н���������ͼƬ��ֵ�˲����һ�ײ��ֱ��ͼ
SaltMidDiff=diff(SaltFilterM,1);
imhist(SaltMidDiff);