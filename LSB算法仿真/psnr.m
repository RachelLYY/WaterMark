%Name:		Chris Shoemaker
%Course:	EER-280 - Digital Watermarking
%Project: 	Calculates the PSNR (Peak Signal to Noise Ratio)
%            of images A and A', both of size MxN

function [A] = psnr(image,image_prime,M,N)

    % convert to doubles
    image=double(image);
    image_prime=double(image_prime);

    psnr_num=M*N*255^2; % 输入图像数据类型内的最大取值，如对于8bit图像应为255
    psnr_den=sum(sum((image-image_prime).^2));      % calculate denominator   
    A=psnr_num/psnr_den;                            % calculate PSNRSNR = 20 log10(Vs/Vn),
   A=10*log10(A);
                                              
return

