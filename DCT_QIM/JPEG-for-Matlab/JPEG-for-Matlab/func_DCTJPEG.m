% function ReconImage=func_DCTJPEG(I,q)

%%**************************************************************************************%%
%% 1.This function tests the DCTJPEG codec 
%%   written by Chengyou WANG in Tianjin University,China in April 2006.
%%   Contact me: E-mail: chengyou_wang@yahoo.com.cn,wangchengyou@tju.edu.cn
%%   Address:Mailbox 23,School of Electronic Information Engineering,
%%           Tianjin University,Tianjin,P.R.China,300072
%%   ReconImage=DCTJPEG(I,q),IΪ��ѹ��ͼ��qΪ�������ӣ�ReconImageΪ��ѹ���ؽ�ͼ��
%% 2.This function calls: 
%%   blkproc.m,DCHuffmanEncoding.m,ACHuffmanEncoding.m,zigzag.m,PSNR.m,
%%   �ԻҶ�ͼ�����DCT�任,����,ZigZagɨ��,Huffman�����,������,��DCT�任���ؽ�ͼ��
%%   ���У�blkproc.mΪ�ֿ�DCT�任������
%%   DCHuffmanEncoding.m��ACHuffmanEncoding.m�ֱ�ΪDC��AC�任ϵ����Huffman�������
%%   zigzag.mΪZigZagɨ�躯����PSNR.mΪ��ͼ���ֵ����Ⱥ�����
%% Copyright 2008 Reserved @ Chengyou WANG @ Tianjin University,P.R.China. 
%%**************************************************************************************%%

%%Test
close all;clear all;clc;%�ر���������IMAGE����������ռ������ǳ�פϵͳ���������������Ļ
% fname=input('Please input the bmp image name:','s');%%��һ��bmp�Ҷ�ͼ��
% [I,map]=imread(fname,'bmp');
I=imread('lena.bmp');%%��bmp�Ҷ�ͼ��
q=1;%%�趨��������

OriginalImage=I;Q=q;
OriginalImage=double(OriginalImage);%%ͼ����������ת��
ImageSub=OriginalImage-128;%%��ƽƽ��128
[Row,Col]=size(OriginalImage);%%ͼ��Ĵ�С
BlockNumber=Row*Col/64;%%8*8�ֿ���

%% dct2�任����ImageSub�ֳ�8*8���ؿ飬�ֱ����dct2�任���ñ任ϵ������Coef
Coef=blkproc(ImageSub,[8 8],'dct2(x)');

%% ����������������L����Coef��CoefAfterQ
%% JPEG������������
L=Q*[16  11  10  16  24  40  51  61
     12  12  14  19  26  58  60  55
     14  13  16  24  40  57  69  56
     14  17  22  29  51  87  80  62
     18  22  37  56  68 109 103  77
     24  35  55  64  81 104 113  92
     49  64  78  87 103 121 120 101
     72  92  95  98 112 100 103  99]; 
CoefAfterQ=blkproc(Coef,[8 8],'round(x./P1)',L);%%�򿿽�������ȡԲ��

%% ��CoefAfterQ�ֳ�8*8�Ŀ�÷ֿ����CoefBlock
m=0;
for row=1:Row/8
    for col=1:Col/8
      m=m+1;
      CoefBlock(:,:,m)=CoefAfterQ(((row-1)*8+1):(row*8),((col-1)*8+1):(col*8));
    end
end
m;

%% ������������ֿ��DCϵ����ŵ��о���DC��
DC(m)=0;
for i=1:m
    DC(i)=CoefBlock(1,1,i);
end
DC;

%% ���ɸ���DCϵ���Ĳ�ֵ��ɵ��о���DCdif
DCdif(BlockNumber)=0;
DCdif(1)=DC(1);
for i=2:BlockNumber
    DCdif(i)=DC(i)-DC(i-1);
end
DCdif;

%% ���о���DCdif�еĲ�ֵ�滻ԭ��ϵ������CoefBlock�и����ֿ��DCϵ��
m=0;
for i=1:Row/8
    for j=1:Col/8
        m=m+1;
        CoefBlock(1,1,m)=DCdif(m);
    end
end
m;

%% �ѷֿ����CoefBlock�ŵ��任ϵ�������CoefDCchanged��
n=0;
for row=1:Row/8
    for col=1:Col/8
        n=n+1;
        CoefDCchanged(((row-1)*8+1):(row*8),((col-1)*8+1):(col*8))=CoefBlock(:,:,n);
   end
end
n;

%%**************************************************************************************************
%% ���ˣ���������п���DCϵ�����滻������һ���ֿ����⣩��Ϊ�Ժ��DCϵ����ֱ���������׼��
%%**************************************************************************************************

%%*********************** the first--end blocks ************************
%% ���¶�ÿ���ֿ����������ZigZagɨ��ͱ��루�ֱ��DCϵ����ACϵ����
%%**********************************************************************

%% ����ͼ�������bit�����Լ�bit���еĳ���
ImageBitSeq=[];
ImageBitLen=[];

%% �����ã�������ѭ���Ĵ���
rowloop=0;
for row=1:Row/8
    colloop=0;
    for col=1:Col/8
       m(1:8,1:8)=CoefDCchanged((row-1)*8+1:(row-1)*8+8,(col-1)*8+1:(col-1)*8+8);
       k= round(m); %% �ͽ�ȡ��
       %k;
       %% kΪ�任ϵ�������������ͽ�ȡ����ľ���

       %% ZigZag Scaning
       %%*********************************************************
       t=zigzag(k);
       %t;
       %% tΪzigzagɨ����

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
       
       %% �ֿ��к����63��ϵ��ȫΪ0���������Ϊ����ĳ���Ҫ��e����ֵ����������±겻��Ϊ0��������w=1
       if w==0 
          w=1;
       end
       
       %% wΪ���һ����Ϊ0��ϵ�����±꣨��1��ʼ������
       e(w)=0;
       for i=1:w
           e(i)=t(i);
       end
       %e;
       %% eΪzigzagɨ����tȥ��ĩβ��0��õ���һά������
        
       %%*********************************************************
       %%  ENCODING TO BINARY BITS
       %%  Encoded Values Generation
       %%*********************************************************

       %%*********************************************************
       %% ��DCϵ������Huffman����
       %e(1);
       [blockDCbit_seq,blockDCcode_len]=DCHuffmanEncoding(e(1));
       blockDCbit_seq;
       blockDCcode_len;

       %%********************** VLE code **************************
       %% zerolenΪ��0����0�ĸ�����amplitudeΪ��0�����0ֵ�ķ��ȣ�
       %% ��ACϵ���γ̶�ά�¼�����Huffman���룺
       %% bit_seqΪ��ÿ����ά�¼��ı�������
       %% blockACbit_seqΪ����ACϵ���ı�������
       %% *********************************************************
       eob_seq=dec2bin(10,4);%%eob=1010(�������EOB��)
       blockACbit_seq=[];
       blockbit_seq=[];
       zrl_seq=[];
       trt_seq=[];
       zerolen=0;
       zeronumber=0;
       
       %% �ֿ���ֻ�е�һ��DCϵ��Ϊ0��Ϊ0��ACϵ��ȫΪ0�����
       if numel(e)==1
          blockACbit_seq=[];%%20080413�������Ķ���ԭ����ԭ�������������󱶳�3����ʱDC�����д�
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

       %% blockbit_seqΪ������ı������У�blockbit_lenΪ������ı��볤��
       blockbit_seq;
       blockbit_len;
       ImageBitSeq=[ImageBitSeq,blockbit_seq];
       ImageBitLen=numel(ImageBitSeq);       
       colloop=colloop+1;
   end
   rowloop=rowloop+1;
end

%% ����ͼ�������bit����ImageBitSeq�Լ�bit���еĳ���ImageBitLen
ImageBitSeq;
ImageBitLen;
CompressionRatio=Row*Col*8/ImageBitLen;
disp('DCTJPEGѹ�����������(bpp)')
AverageBit=ImageBitLen/Row/Col

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%************************* Encoding is finished ********************************
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Huffman�������ʡ��

%% ���������Ѿ���CoefAfterQDecode�������þ���CoefInverseQ
CoefInverseQ=blkproc(CoefAfterQ,[8,8],'x.*P1',L);

%% ��dct2�任����CoefInverseQ�ֳ�8*8���ؿ飬�ֱ���з�dct2�任�ؽ�ͼ��ImageSubRecon������ʾ
ImageSubRecon=blkproc(CoefInverseQ,[8,8],'idct2(x)');
ReconImage=round(ImageSubRecon)+128;%%�򿿽�������ȡԲ���������ƽƽ��128
% figure,imshow(ReconImage,[]);%%title('DCTJPEGѹ���ؽ�ͼ��');

%% ���ֵ�����PSNR��
disp('DCTJPEGѹ��ǰ��ͼ���ֵ�����(dB)')
PSNR0=PSNR(OriginalImage,ReconImage)