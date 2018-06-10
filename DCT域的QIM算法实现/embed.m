function watermarked_image = embed(A,Key_image,deta,d)
% ������ԭͼ��Ƕ���ˮӡͼ��Ƕ��Ĳ���
% �ֿ�
%�ֿ�
Mc=size(A,1);	%Height
Nc=size(A,2);	%Width
B=mat2cell(A,ones(Mc/8,1)*8,ones(Nc/8,1)*8);
% �������齻��
M=size(B,1);
N=size(B,2);
for i=1:M;
    for j=1:2:N-1
        % �����н���
        for a=1:2:8
           
                tmp = B{i,j+1}(a,:);
                B{i,j+1}(a,:) = B{i,j}(a,:);
                B{i,j}(a,:)=tmp;
           
        end
        % ������ ���н���
        for b=1:2:8
          
                tmp = B{i,j+1}(:,b);
                B{i,j+1}(:,b)=B{i,j}(:,b);
                B{i,j}(:,b) = tmp;
           
        end
    end       
end
% �ϲ�:C=cell2mat(B)
% ��ÿһ��һ��8*8�Ŀ鶼���ж�άdct�任
dct_of_everyone = cellfun(@(x) dct2(x) , B,'UniformOutput',false);
% ȡ��DCϵ��
dct_cell = cellfun(@(y) y(1,1),dct_of_everyone,'UniformOutput',false);
% cellת��1ά����
dct_c_ori = cell2mat(dct_cell);
dct_c=zeros(1,4500);
lc=size(dct_cell,1);	%Height
wc=size(dct_cell,2);	%Width
c = 1;
for a = 1:lc
    for b=1:wc
        dct_c(1,c)=dct_c_ori(a,b);
        c = c+1;
    end
end
% ��ֵͼ��
Mk=size(Key_image,1);	%Height
Nk=size(Key_image,2);	%Width
count=1;
for i=1:Mk
    for j=1:Nk
            cur = Key_image(i,j);
            if(cur==0)
                k1 = floor((dct_c(1,count)-d)./(2*deta));
                dct_c(1,count) = k1*2*deta+d;
            end
            if(cur==1)
                k2 = floor((dct_c(1,count)-d-deta)./(2*deta));
                dct_c(1,count) = k2*2*deta+d+deta;
            end
            count = count+1;
    end
end
% ϵ���޸���� ����
x = floor(Mc/8);
y = floor(Nc/8);
count2 = 1;
for i=1:x
    for j=1:y
        dct_of_everyone{i,j}(1,1) = dct_c(1,count2);
        count2 = count2+1;
    end
end
idct_c = cellfun(@(y) idct2(y),dct_of_everyone,'UniformOutput',false);
for i=1:M;
    for j=1:2:N-1
        % ������ ���н���
        for b=1:2:8
                tmp = idct_c{i,j}(:,b);
                idct_c{i,j}(:,b)=idct_c{i,j+1}(:,b);
                idct_c{i,j+1}(:,b) = tmp;        
        end
        for a=1:2:8
                tmp = idct_c{i,j}(a,:);
                idct_c{i,j}(a,:) = idct_c{i,j+1}(a,:);
                idct_c{i,j+1}(a,:) = tmp;
        end
    end
end
watermarked_image1=cell2mat(idct_c);
watermarked_image1 = fix(watermarked_image1);
watermarked_image = uint8(watermarked_image1);
imshow(watermarked_image);
imwrite(watermarked_image,'watermarked_image.jpg','jpg');
end



