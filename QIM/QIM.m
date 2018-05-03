% 分块
A=imread('lena.bmp');
key=imread('key.bmp');
M = size(key,1);
N = size(key,2);
%分块
Mc=size(A,1);	%Height
Nc=size(A,2);	%Width
B=mat2cell(A,ones(Mc/16,1)*16,ones(Nc/16,1)*16);
Mk=size(B,1);
Nk=size(B,2);

% 合并:C=cell2mat(B)
% 对每一个一个8*8的块都进行二维dct变换
dct_of_everyone = cellfun(@(x) dct2(x) , B,'UniformOutput',false);
% zigzag扫描读取dct系数
zigzag_of_everyone = cellfun(@(x) zigzag(16,x),dct_of_everyone,'UniformOutput',false);
% 计算所得每块的量化因子
dataArray_of_everyone = cellfun(@(x) data_array(80,x),zigzag_of_everyone,'UniformOutput',false);

len_factor1 = size(dataArray_of_everyone,1);
len_factor2 = size(dataArray_of_everyone,2);

% factor_z = zeros(32,32);
% % cell to double matrix
% for i =1:len_factor1
%     for j = 1:len_factor2
%         factor_z(i,j) = cell2mat(dataArray_of_everyone(i,j));
%         factor_z(i,j) = factor_z(i,j,1);
%         % count=count+1;
%     end
% end
% 进行量化 把水印图像转成一维数组
watermark=zeros(1,4500);
c=1;
for i=1:M
    for j=1:N
        watermark(1,c)=key(i,j);
        c=c+1;
    end
end
c=1;
% 根据量化系数嵌入水印
for i=1:len_factor1
    for j=1:len_factor2
        deta = dataArray_of_everyone(i,j);
        for a=1:80
            cur = watermark(1,c);
            if(cur==0)
                % 写入
                dct_of_everyone{i,j}(
            end
            if(cur==1)
               
            end
        end
            
    end
end
