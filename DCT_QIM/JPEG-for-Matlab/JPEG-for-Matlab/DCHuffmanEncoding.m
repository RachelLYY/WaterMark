function [bit_seq,len]=DCHuffmanEncoding(x) 

%%**************************************************************** 
%% ��ɨ���ÿ���DCϵ����ֵ����Huffman����,Revised in Jun,2006
%% xΪDCϵ���Ĳ�ֵ
%%****************************************************************

%%*********************************** DC Huffman Code Look up *********************************%%
%% valΪx�ľ���ֵ�������ȴ�С
%% dccodeΪ��ʮ��������ʾ�ı�������codelenΪ�������볤
%% ��x > 0�������������ԭ���ʾ����x < 0������������Ʒ����ʾ��amplenΪ��ʾ���������bit��
%%*********************************************************************************************%%
v0=x;
val=abs(x);
if (val==0);amplen=1;codelen=2;dccode=0;%% dccode=00
elseif(val==1);amplen=1;codelen=3;dccode=2;%% dccode=010 
elseif(val >=    2 & val <=    3);amplen= 2;codelen = 3;dccode=  3;  %% dccode=011;
elseif(val >=    4 & val <=    7);amplen= 3;codelen = 3;dccode=  4;  %% dccode=100;
elseif(val >=    8 & val <=   15);amplen= 4;codelen = 3;dccode=  5;  %% dccode=101; 
elseif(val >=   16 & val <=   31);amplen= 5;codelen = 3;dccode=  6;  %% dccode=110;
elseif(val >=   32 & val <=   63);amplen= 6;codelen = 4;dccode= 14;  %% dccode=1110;
elseif(val >=   64 & val <=  127);amplen= 7;codelen = 5;dccode= 30;  %% dccode=1 1110;
elseif(val >=  128 & val <=  255);amplen= 8;codelen = 6;dccode= 62;  %% dccode=11 1110;
elseif(val >=  256 & val <=  511);amplen= 9;codelen = 7;dccode=126;  %% dccode=111 1110;
elseif(val >=  512 & val <= 1023);amplen=10;codelen = 8;dccode=254;  %% dccode=1111 1110;
elseif(val >= 1024 & val <= 2047);amplen=11;codelen = 9;dccode=510;  %% dccode=1 1111 1110;
end
if v0>0 ;bit_seq=[dec2bin(dccode,codelen),dec2bin(val,amplen)];
else  bit_seq=[dec2bin(dccode,codelen),dec2bin(bitcmp(val,amplen),amplen)];
end
len = numel(bit_seq);

%% dec2bin()Ϊʮ������������������ת������һ��������Ҫת����ʮ��������
%% �ڶ�������Ϊת������������λ�������Ҫ���λ������ֱ��ת�����λ�����Զ���ǰ�油0��
%% bitcmp()ȡ���룬��һ��������Ҫȡ���Ķ�������ʮ��������ʾ��
%% �ڶ�������ָ���Զ���λ�Ķ�������ȡ�������Ҫ���λ������ֱ�ӱ�ʾ�Ķ���������λ�����Զ���ǰ�油0��
%% bitcmp()�Ľ��Ϊȡ�����ʮ��������ʾ








%% ����һ�����

% v0=x;
% val=abs(x);
% if(val == 0);amplen=1;codelen=1;dccode=0;  %% dccode=0;
% elseif (val == 1);amplen=1;codelen=2;dccode=2;  %% dccode=10;
% elseif(val >=    2 & val <=    3);amplen= 2;codelen =  3;dccode=   6;  %% dccode=110;
% elseif(val >=    4 & val <=    7);amplen= 3;codelen =  4;dccode=  14;  %% dccode=1110;
% elseif(val >=    8 & val <=   15);amplen= 4;codelen =  5;dccode=  30;  %% dccode=1 1110;
% elseif(val >=   16 & val <=   31);amplen= 5;codelen =  6;dccode=  62;  %% dccode=11 1110;
% elseif(val >=   32 & val <=   63);amplen= 6;codelen =  7;dccode= 126;  %% dccode=111 1110;
% elseif(val >=   64 & val <=  127);amplen= 7;codelen =  8;dccode= 254;  %% dccode=1111 1110;
% elseif(val >=  128 & val <=  255);amplen= 8;codelen =  9;dccode= 510;  %% dccode=1 1111 1110;
% elseif(val >=  256 & val <=  511);amplen= 9;codelen = 10;dccode=1022;  %% dccode=11 1111 1110;
% elseif(val >=  512 & val <= 1023);amplen=10;codelen = 11;dccode=2046;  %% dccode=111 1111 1110;
% elseif(val >= 1024 & val <= 2047);amplen=11;codelen = 12;dccode=4094;  %% dccode=1111 1111 1110;
% end
% if v0>0 ;bit_seq=[dec2bin(dccode),dec2bin(val,codelen)];
% else  bit_seq=[dec2bin(dccode),dec2bin(bitcmp(val,codelen),codelen)];
% end
% len=numel(bit_seq);