% 相邻两块交换 
A=imread('coverimg.bmp');
Mc=size(A,1);	%Height
Nc=size(A,2);	%Width
B=mat2cell(A,ones(Mc/8,1)*8,ones(Nc/8,1)*8);

% 相邻两块进行交换
M=size(B,1);
N=size(B,2);
for i=1:M
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
dct_why = cell2mat(B);
for i1=1:M
    for j1=1:2:N-1
        % 单数列 隔列交换
        for b1=1:2:8
                tmp = B{i1,j1+1}(:,b1);
                B{i1,j1+1}(:,b1)=B{i1,j1}(:,b1);
                B{i1,j1}(:,b1) = tmp;
        end
        for a1=1:2:8
                tmp = B{i1,j1+1}(a1,:);
                B{i1,j1+1}(a1,:) = B{i1,j1}(a1,:);
                B{i1,j1}(a1,:) = tmp;
        end
    end
a = endstd2(X);
a=a+x;
dct_c_ori = cell2mat(B);
imshow(dct_c_ori);
imwrite(dct_c_ori,'exchange.jpg','jpg');
% 换过之后DCT 然后对直流系数嵌入 然后idct 然后置换回来
