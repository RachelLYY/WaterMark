function watermark_img = extract(W,d,deta)
% 参数：原图，嵌入的水印图像，嵌入的参数
% 分块
watermark = zeros(1,32400);
watermark_img = zeros(42,93);
Mc=size(W,1);	%Height
Nc=size(W,2);	%Width
B=mat2cell(W,ones(Mc/8,1)*8,ones(Nc/8,1)*8);
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
% 合并:C=cell2mat(B)
% 对每一个一个8*8的块都进行二维dct变换
dct_of_everyone = cellfun(@(x) dct2(x) , B,'UniformOutput',false);
% 取出DC系数
dct_cell = cellfun(@(y) y(1,1),dct_of_everyone,'UniformOutput',false);
dct_c_ori = cell2mat(dct_cell);
dct_c=zeros(1,4500);
lc=size(dct_c_ori,1);	%Height
wc=size(dct_c_ori,2);	%Width
c = 1;
for a = 1:lc
    for b=1:wc
        dct_c(1,c)=dct_c_ori(a,b);
        c = c+1;
    end
end
x = length(dct_c);
for i=1:x
    x = dct_c(1,i);
    c = floor((x-d)/deta);
    if(mod(c,2)==1)
        watermark(1,i)=0;
    end
    if(mod(c,2)==0)
        watermark(1,i)=1;
    end
end
% 长宽
cc = 1;
len = length(watermark);
for a = 1:42
    for b = 1:93
        if(cc<len)
            watermark_img(a,b) = watermark(1,cc);
            cc = cc+1;
        else
            break;
        end
     end
end
end