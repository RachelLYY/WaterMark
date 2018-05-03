function PSNR = PSNR(A,B)

%����������ͼ��A,B�ķ�ֵ�����PSNR(dB)

A = double(A);      %%ͼ����������ת��
B = double(B);
[Row,Col] = size(A);%%����ͼ��Ĵ�С
% [Row,Col] = size(B);
MSE = sum(sum((A - B).^2)) / (Row * Col);   %%�������MSE
PSNR = 10 * log10(255^2/MSE);               %%��ֵ�����PSNR(dB)