aaa = imread('c.jpg');
M=size(aaa,1);	%Height
N=size(aaa,2);	%Width
x = zeros(42,93);
for i=1:M
    for j=1:N
        if(aaa(i,j)>1)
            x(i,j)=1;
        else
            x(i,j)=0;
        end
    end
end
% imshow(x);
imwrite(x,'cc.jpg','jpg');