% 取分块的前n个dct系数成为一个数列 dct系数已经zigzag扫描结束 是一个一维数组
function z = data_array(n,a)
matrix = zeros(1,n);
for i=1:n
    matrix(1,i) = a(1,i);
end
% odd number array
odd_number_array=zeros(1,n/2);
odd = 1;
% even number array
even_number_array=zeros(1,n/2);
even = 1;
for j=1:n
    if(mod(j,2)==0)
        odd_number_array(1,odd) = matrix(1,j);
        odd = odd+1;
    end
    if(mod(j,2)==1)
        even_number_array(1,even)=matrix(1,j);
        even = even+1;
    end
end
% calculate lx and ly
x = 0;
y = 0;
for k=1:n/2
    x = x + odd_number_array(1,k)*odd_number_array(1,k);
    y = y + even_number_array(1,k)*even_number_array(1,k);
end
lx = sqrt(x*(n/2));
ly = sqrt(y*(n/2));
z = lx/ly;

end
