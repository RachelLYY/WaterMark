function [Matrix]=Dct_Quantize(I,Qua_Factor,Qua_Table)

%UNTITLED Summary of this function goes here

%   Detailed explanation goes here

I=double(I)-128;   %����ƶ�128���Ҷȼ�������鱾P401

 

% ?t2�任����ImageSub�ֳ�8*8���ؿ飬�ֱ����dct2�任���ñ任ϵ������Coef

I=blkproc(I,[8 8],'dct2(x)');

 

Qua_Matrix=Qua_Factor.*Qua_Table;              %��������

I=blkproc(I,[8 8],'round(x./P1)',Qua_Matrix);  %��������������

 

Matrix=I;          %�õ�������ľ���

end