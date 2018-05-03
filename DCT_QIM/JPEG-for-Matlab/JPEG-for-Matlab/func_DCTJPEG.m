% function ReconImage=func_DCTJPEG(I,q)

%%**************************************************************************************%%
%% 1.This function tests the DCTJPEG codec 
%%   written by Chengyou WANG in Tianjin University,China in April 2006.
%%   Contact me: E-mail: chengyou_wang@yahoo.com.cn,wangchengyou@tju.edu.cn
%%   Address:Mailbox 23,School of Electronic Information Engineering,
%%           Tianjin University,Tianjin,P.R.China,300072
%%   ReconImage=DCTJPEG(I,q),I为待压缩图像，q为量化因子，ReconImage为解压缩重建图像。
%% 2.This function calls: 
%%   blkproc.m,DCHuffmanEncoding.m,ACHuffmanEncoding.m,zigzag.m,PSNR.m,
%%   对灰度图像进行DCT变换,量化,ZigZag扫描,Huffman编解码,反量化,反DCT变换而重建图像。
%%   其中，blkproc.m为分块DCT变换函数；
%%   DCHuffmanEncoding.m，ACHuffmanEncoding.m分别为DC和AC变换系数的Huffman码表函数；
%%   zigzag.m为ZigZag扫描函数；PSNR.m为求图像峰值信噪比函数。
%% Copyright 2008 Reserved @ Chengyou WANG @ Tianjin University,P.R.China. 
%%**************************************************************************************%%

%%Test
close all;clear all;clc;%关闭其他所有IMAGE；清除变量空间其他非常驻系统变量；清除工作屏幕
% fname=input('Please input the bmp image name:','s');%%读一幅bmp灰度图像
% [I,map]=imread(fname,'bmp');
I=imread('lena.bmp');%%读bmp灰度图像
q=1;%%设定量化因子

OriginalImage=I;Q=q;
OriginalImage=double(OriginalImage);%%图像数据类型转换
ImageSub=OriginalImage-128;%%电平平移128
[Row,Col]=size(OriginalImage);%%图像的大小
BlockNumber=Row*Col/64;%%8*8分块数

%% dct2变换：把ImageSub分成8*8像素块，分别进行dct2变换，得变换系数矩阵Coef
Coef=blkproc(ImageSub,[8 8],'dct2(x)');

%% 量化：用量化矩阵L量化Coef得CoefAfterQ
%% JPEG建议量化矩阵
L=Q*[16  11  10  16  24  40  51  61
     12  12  14  19  26  58  60  55
     14  13  16  24  40  57  69  56
     14  17  22  29  51  87  80  62
     18  22  37  56  68 109 103  77
     24  35  55  64  81 104 113  92
     49  64  78  87 103 121 120 101
     72  92  95  98 112 100 103  99]; 
CoefAfterQ=blkproc(Coef,[8 8],'round(x./P1)',L);%%向靠近的整数取圆整

%% 把CoefAfterQ分成8*8的块得分块矩阵CoefBlock
m=0;
for row=1:Row/8
    for col=1:Col/8
      m=m+1;
      CoefBlock(:,:,m)=CoefAfterQ(((row-1)*8+1):(row*8),((col-1)*8+1):(col*8));
    end
end
m;

%% 把量化后各个分块的DC系数存放到行矩阵DC中
DC(m)=0;
for i=1:m
    DC(i)=CoefBlock(1,1,i);
end
DC;

%% 求由各个DC系数的差值组成的行矩阵DCdif
DCdif(BlockNumber)=0;
DCdif(1)=DC(1);
for i=2:BlockNumber
    DCdif(i)=DC(i)-DC(i-1);
end
DCdif;

%% 用行矩阵DCdif中的差值替换原来系数矩阵CoefBlock中各个分块的DC系数
m=0;
for i=1:Row/8
    for j=1:Col/8
        m=m+1;
        CoefBlock(1,1,m)=DCdif(m);
    end
end
m;

%% 把分块矩阵CoefBlock放到变换系数大矩阵CoefDCchanged中
n=0;
for row=1:Row/8
    for col=1:Col/8
        n=n+1;
        CoefDCchanged(((row-1)*8+1):(row*8),((col-1)*8+1):(col*8))=CoefBlock(:,:,n);
   end
end
n;

%%**************************************************************************************************
%% 至此，完成了所有块中DC系数的替换（除第一个分块以外），为以后的DC系数差分编码做好了准备
%%**************************************************************************************************

%%*********************** the first--end blocks ************************
%% 以下对每个分块进行量化，ZigZag扫描和编码（分别对DC系数和AC系数）
%%**********************************************************************

%% 整个图像编码后的bit序列以及bit序列的长度
ImageBitSeq=[];
ImageBitLen=[];

%% 调试用，用来记循环的次数
rowloop=0;
for row=1:Row/8
    colloop=0;
    for col=1:Col/8
       m(1:8,1:8)=CoefDCchanged((row-1)*8+1:(row-1)*8+8,(col-1)*8+1:(col-1)*8+8);
       k= round(m); %% 就近取整
       %k;
       %% k为变换系数矩阵经量化并就近取整后的矩阵

       %% ZigZag Scaning
       %%*********************************************************
       t=zigzag(k);
       %t;
       %% t为zigzag扫描结果

       %% Removing Extra Zeros
       %%*********************************************************
       w=0;
       u=64;
       while u ~= 0
             if t(u) ~= 0
                w=u;
                break;
             end
             u=u-1;
       end
       w;
       
       %% 分块中后面的63个系数全为0的情况，因为下面的程序要对e赋初值，而矩阵的下标不能为0，所以另w=1
       if w==0 
          w=1;
       end
       
       %% w为最后一个不为0的系数的下标（从1开始计数）
       e(w)=0;
       for i=1:w
           e(i)=t(i);
       end
       %e;
       %% e为zigzag扫描结果t去掉末尾的0后得到的一维行向量
        
       %%*********************************************************
       %%  ENCODING TO BINARY BITS
       %%  Encoded Values Generation
       %%*********************************************************

       %%*********************************************************
       %% 对DC系数进行Huffman编码
       %e(1);
       [blockDCbit_seq,blockDCcode_len]=DCHuffmanEncoding(e(1));
       blockDCbit_seq;
       blockDCcode_len;

       %%********************** VLE code **************************
       %% zerolen为连0串中0的个数，amplitude为连0串后非0值的幅度，
       %% 对AC系数游程二维事件进行Huffman编码：
       %% bit_seq为对每个二维事件的编码结果，
       %% blockACbit_seq为所有AC系数的编码结果，
       %% *********************************************************
       eob_seq=dec2bin(10,4);%%eob=1010(块结束符EOB码)
       blockACbit_seq=[];
       blockbit_seq=[];
       zrl_seq=[];
       trt_seq=[];
       zerolen=0;
       zeronumber=0;
       
       %% 分块中只有第一个DC系数为0或不为0，AC系数全为0的情况
       if numel(e)==1
          blockACbit_seq=[];%%20080413张丽晓改动，原因是原程序在量化矩阵倍乘3以上时DC解码有错
          blockbit_seq=[blockDCbit_seq,eob_seq];
          blockbit_len=length(blockbit_seq);
       else 
          for i=2:w
              if ( e(i)==0 & zeronumber<16)
                  zeronumber=zeronumber+1;
              elseif (e(i)==0 & zeronumber==16); 
                  bit_seq=dec2bin(2041,11);%%zrl=1111 1111 001
                  zeronumber=1;
                  blockACbit_seq=[blockACbit_seq,bit_seq];
              elseif (e(i)~=0 & zeronumber==16)
                  zrl_seq=dec2bin(2041,11);
                  amplitude=e(i);
                  trt_seq=ACHuffmanEncoding(0,amplitude);
                  bit_seq=[zrl_seq,trt_seq];
                  blockACbit_seq=[blockACbit_seq,bit_seq];
                  zeronumber=0;
              elseif(e(i))
                  zerolen=zeronumber;          
                  amplitude=e(i); 
                  zeronumber=0;
                  bit_seq=ACHuffmanEncoding(zerolen,amplitude);
                  blockACbit_seq=[blockACbit_seq,bit_seq];
              end
          end
       end                 
       blockbit_seq=[blockDCbit_seq,blockACbit_seq,eob_seq];
       blockbit_len=length(blockbit_seq);

       %% blockbit_seq为整个块的编码序列，blockbit_len为整个块的编码长度
       blockbit_seq;
       blockbit_len;
       ImageBitSeq=[ImageBitSeq,blockbit_seq];
       ImageBitLen=numel(ImageBitSeq);       
       colloop=colloop+1;
   end
   rowloop=rowloop+1;
end

%% 整个图像编码后的bit序列ImageBitSeq以及bit序列的长度ImageBitLen
ImageBitSeq;
ImageBitLen;
CompressionRatio=Row*Col*8/ImageBitLen;
disp('DCTJPEG压缩编码比特率(bpp)')
AverageBit=ImageBitLen/Row/Col

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%************************* Encoding is finished ********************************
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Huffman解码程序省略

%% 反量化：把矩阵CoefAfterQDecode反量化得矩阵CoefInverseQ
CoefInverseQ=blkproc(CoefAfterQ,[8,8],'x.*P1',L);

%% 反dct2变换：把CoefInverseQ分成8*8像素块，分别进行反dct2变换重建图像ImageSubRecon，并显示
ImageSubRecon=blkproc(CoefInverseQ,[8,8],'idct2(x)');
ReconImage=round(ImageSubRecon)+128;%%向靠近的整数取圆整，反向电平平移128
% figure,imshow(ReconImage,[]);%%title('DCTJPEG压缩重建图像');

%% 求峰值信噪比PSNR：
disp('DCTJPEG压缩前后图像峰值信噪比(dB)')
PSNR0=PSNR(OriginalImage,ReconImage)