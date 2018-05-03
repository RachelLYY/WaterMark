function [Matrix]=Dct_Quantize(I,Qua_Factor,Qua_Table)

%UNTITLED Summary of this function goes here

%   Detailed explanation goes here

I=double(I)-128;   %层次移动128个灰度级，详见书本P401

 

% ?t2变换：把ImageSub分成8*8像素块，分别进行dct2变换，得变换系数矩阵Coef

I=blkproc(I,[8 8],'dct2(x)');

 

Qua_Matrix=Qua_Factor.*Qua_Table;              %量化矩阵

I=blkproc(I,[8 8],'round(x./P1)',Qua_Matrix);  %量化，四舍五入

 

Matrix=I;          %得到量化后的矩阵

end