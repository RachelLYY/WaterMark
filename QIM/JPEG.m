% JPEGѹ��
rgb_image = imread('lenaRGB.bmp');
% ��ɫģʽת��
ycbcr_image = rgb2ycbcr(rgb_image);
% ���� Y:Cb:Cr=4:1:1
% ���
stream = zeros(1,512*512*3);
% ӳ��
for i=1:1:512
    for j=1:1:512
        
    end
end

% �ֿ�
% ��ɢ���ұ任
% zigzagɨ��
% ����
% �����������DCTϵ�� ����QIM