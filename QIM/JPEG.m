% JPEG压缩
rgb_image = imread('lenaRGB.bmp');
% 颜色模式转化
ycbcr_image = rgb2ycbcr(rgb_image);
% 采样 Y:Cb:Cr=4:1:1
% 存放
stream = zeros(1,512*512*3);
% 映射
for i=1:1:512
    for j=1:1:512
        
    end
end

% 分块
% 离散余弦变换
% zigzag扫描
% 量化
% 基于量化后的DCT系数 进行QIM