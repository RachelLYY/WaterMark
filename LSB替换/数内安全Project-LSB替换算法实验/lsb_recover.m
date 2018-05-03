%Name:		Chris Shoemaker
%Course:	EER-280 - Digital Watermarking
%Project: 	Least Significant Bit Substitution 
%           Watermark Recovery
clc
clear all
close all
% save start time
start_time=cputime;
% read in watermarked image
file_name='lsb_watermarked.bmp';
%file_name='_lena_std_bw.bmp';
watermarked_image=imread(file_name);
figure,imshow(watermarked_image),title('Watermarked Image')
%% %%%%%%%%%%%%%%%%%% distortion %%%%%%%%%%%%
% imwrite(watermarked_image,'temp.jpg','Quality',10);
% watermarked_image2=imread('temp.jpg');
% psnr_Dist=psnr(watermarked_image2,watermarked_image,size(watermarked_image,1),size(watermarked_image,2));
% figure,imshow(watermarked_image2),title(strcat('distorted wked image, PSNR=',num2str(psnr_Dist)))
% watermarked_image=watermarked_image2;

% watermarked_image2 = imnoise(watermarked_image,'gaussian',0,2*10^(-1)); %1~7*10^(-6)
% psnr_Dist=psnr(watermarked_image2,watermarked_image,size(watermarked_image,1),size(watermarked_image,2));
% figure,imshow(watermarked_image2),title(strcat('distorted wked image, PSNR=',num2str(psnr_Dist)))
% watermarked_image=watermarked_image2;

watermarked_image2 = imnoise(watermarked_image,'salt & pepper',0.01); % 0~100%
psnr_Dist=psnr(watermarked_image2,watermarked_image,size(watermarked_image,1),size(watermarked_image,2));
figure,imshow(watermarked_image2),title(strcat('distorted wked image, PSNR=',num2str(psnr_Dist)))
watermarked_image=watermarked_image2;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% determine size of watermarked image
Mw=size(watermarked_image,1);	%Height
Nw=size(watermarked_image,2);	%Width
% use lsb of watermarked image to recover watermark
watermark = uint8(zeros(Mw,Nw));
for i = 1:Mw
    for j = 1:Nw
        watermark(i,j)=bitget(watermarked_image(i,j),1);
    end
end
% scale the recovered watermark
% watermark=2*double(watermark);
% display processing time
elapsed_time=cputime-start_time
% read in original watermark
file_name='key.bmp';
message=imread(file_name);
message1=message;  % pixel values: 1, 2
% convert to double for normalization, then back again
message=double(message);
message=fix(message./2);  % % pixel values: 1, 2 ==> 0, 1
message=uint8(message);
% determine size of message object
Mm=size(message,1);	        %Height
Nm=size(message,2);	        %Width
% title the message object out to cover object size to generate watermark
watermarkOrig = uint8(zeros(Mw,Nw));
for i = 1:Mw 
    for j = 1:Nw 
%         watermark(i,j)=message(mod(i,Mm)+1,mod(j,Nm)+1);
        watermarkOrig(i,j)=message(mod(i-1,Mm)+1,mod(j-1,Nm)+1);  % 从（2,2）位置开始复制-平铺 ==》从（1,1）位置开始复制-平铺
    end
end
% display wked image
figure,
subplot(2,2,1),imshow(watermarked_image),title('(Distored) Watermarked Image'),colorbar
% display recovered watermark
subplot(2,2,2),imshow(watermark,[]),title('Recovered Watermark'),colorbar
% display original watermark
subplot(2,2,3),imshow(watermarkOrig,[]),title('Original Watermark'),colorbar
% display difference between recovered watermark and original watermark
Wk_Diff_sum = 1-sum(sum(abs(double(double(watermark)-double(watermarkOrig)))))/Mw/Nw; 
subplot(2,2,4),imshow(abs(double(double(watermark)-double(watermarkOrig))),[0,1]),title(strcat('正确检出率=',num2str(Wk_Diff_sum))),colorbar
% figure,imshow(watermark-watermarkOrig,[-1,1]),title(strcat('Watermark Difference=',num2str(Wk_Diff_sum))),colorbar,colormap('jet')
figure,imshow(watermark,[]),title('Recovered Watermark'),colorbar