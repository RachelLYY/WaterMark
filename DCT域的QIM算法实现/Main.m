% �ֿ�
cover_object=imread('coverimg.bmp');
K = imread('c.jpg');
Key = im2double(im2bw(K));
imshow(key);

M=size(cover_object,1);	%Height
N=size(cover_object,2);	%Width
% ps = zeros(1,20);
% deta=zeros(1,20);
rand('state',012);
d = randi(10,1,1);
% statistics(cover_object); 
%-----------------------�����κδ۸ĵ�Ƕ�����ȡ------------------
wa = embed(cover_object,Key,20,d);
% statistics(wa);
re = extract(wa,d,20);
imshow(re);
%----------------------psnr~deta--------------------------------
% count = 1;
% for i=10:10:150
%     watermarked_image = embed(cover_object,Key,i,d);
%     ps(1,count)=psnr(cover_object,watermarked_image,M,N);
%     deta(1,count)=i;
%     count = count+1;
% end
% plot(deta,ps);

% -------------------3*3��ֵ�˲�------------------------
% k=medfilt2(wa); 
% re = extract(k,d,20);
% imshow(re);
% imwrite(re,'mdefilt.jpg','jpg');
% ---------------------��˹������-----------------------
% gau=imnoise(wa,'gaussian',0,0.0001);
% re = extract(gau,d,20);
% imshow(re);
% ga = psnr(gau,cover_object,M,N);
% imwrite(re,'gaussian.jpg','jpg');
% ----------------------��������-----------------------
% salt=imnoise(wa,'salt & pepper',0.01);
% re = extract(salt,d,20);
% imshow(re);
% gau = psnr(salt,cover_object,M,N);
% imwrite(re,'salt.jpg','jpg');
% ----------------------����60%------------------------
% % imshow(resha);
% resha=imresize(wa);
% re = extract(resha,d,20);
% imshow(re);
% imwrite(re,'reshape.jpg','jpg');