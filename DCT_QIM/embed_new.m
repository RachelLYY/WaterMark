function [watermarked_image,S] = embed_new(A,Key_image,d)
% 参数：原图，嵌入的水印图像，嵌入的参数
% 分块
%分块
beta = 40;
lamda = 20;
Mc=size(A,1);	%Height
Nc=size(A,2);	%Width
B=mat2cell(A,ones(Mc/8,1)*8,ones(Nc/8,1)*8);
% 相邻两块交换
M=size(B,1);
N=size(B,2);
for i=1:M;
    for j=1:2:N-1
        % x = B(i,j);
        % y = B(i,j+1);
        % 隔行交换
        % 单数行交换
        for a=1:2:8
           
                tmp = B{i,j+1}(a,:);
                B{i,j+1}(a,:) = B{i,j}(a,:);
                B{i,j}(a,:)=tmp;
           
        end
        % 单数列 隔列交换
        for b=1:2:8
          
                tmp = B{i,j+1}(:,b);
                B{i,j+1}(:,b)=B{i,j}(:,b);
                B{i,j}(:,b) = tmp;
           
        end
    end       
end
% 合并:C=cell2mat(B)
% 对每一个一个8*8的块都进行二维dct变换
dct_of_everyone = cellfun(@(x) dct2(x) , B,'UniformOutput',false);
% 取出DC系数
dct_cell = cellfun(@(y) y(1,1),dct_of_everyone,'UniformOutput',false);
% cell转成1维数组
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
% 块：B DC系数一维矩阵：dct_c
% 二值图像
Mk=size(Key_image,1);	%Height
Nk=size(Key_image,2);	%Width
count=1;
% 计算 块数
aaa = 0;
a=0;
% 计算均方差
for i=1:M
    for j=1:N
        if(aaa <= Mk*Nk)
            x = B{i,j};
            a = a+std2(x);
            aaa=aaa+1;
            
        else
            break;
        end
    end
end
u=a./(Mk*Nk);
S = zeros(1,4500);
k=1;
for i=1:M
    for j=1:N
        % 求出量化系数（自适应）
        t = double(cell2mat(B(i,j)));
        tmp = var(t(:));
        S(1,k)=(tmp/u)*beta+lamda;
        k=k+1;
    end
end

% 水印变一维
wat=zeros(1,4500);
c=1;
for i=1:Mk
    for j=1:Nk
        wat(1,c)=Key_image(i,j);
        c = c+1;
    end
end
c=1;
% 水印和块的数量不同
% 每个块有一个量化系数
% 水印一维化之后 每一个水印对应一个块B 对应一个量化系数
for i=1:M
    for j=1:N
        if (mod(j,2)==1)
            if wat(1,c)==1
                dct_c(1,c) = dct_c(1,c)-S(1,c);
            else
                dct_c(1,c) = dct_c(1,c)+S(1,c);
            end
        end
        if (mod(j,2)==0)
            if wat(1,c)==1
                dct_c(1,c) = dct_c(1,c)+S(1,c);
            else
                dct_c(1,c) = dct_c(1,c)-S(1,c);
            end
        end
    end
end
% 系数修改完毕 填入
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
        % 单数列 隔列交换
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



