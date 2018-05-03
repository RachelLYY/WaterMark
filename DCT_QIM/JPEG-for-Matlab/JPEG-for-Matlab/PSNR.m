function PSNR = PSNR(A,B)

%计算输入两图像A,B的峰值信噪比PSNR(dB)

A = double(A);      %%图像数据类型转换
B = double(B);
[Row,Col] = size(A);%%输入图像的大小
% [Row,Col] = size(B);
MSE = sum(sum((A - B).^2)) / (Row * Col);   %%均方误差MSE
PSNR = 10 * log10(255^2/MSE);               %%峰值信噪比PSNR(dB)