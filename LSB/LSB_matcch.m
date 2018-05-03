%LSB匹配算法
%分块：5*5
P1=imread('lena512.bmp');
message='liuyanyan';
x=dec2bin(int16(message));
count=1;
%分块
P=zeros(50,50);
P(1:50,1:50)=P1(1:50,1:50);
[l,w]=size(P);
[xl,xc]=size(x);
curposl=1;
curposc=1;
for i=1:xl
    for j=1:xc
        CUR=P(curposl:curposl+5,curposc:curposc+5);
        [cl,cw]=size(CUR);
        xc=0;
        for m=1:cl
            for n=1:cc
                curpix=CUR(m,n);
                bin=dec2base(curpix,2,8);
                xc=xc+bin(1,8);
            end
        end
        pi=mod(xc,2);
        if pi~=P(i,j)
            %翻转
            for m=1:cl
                for n=1:cc
                    curpix=CUR(m,n);
                    bin=dec2base(curpix,2,8);
                    bin(1,8)=~bin(1,8);
                    pixnew=bin2dec(bin);   
                    %赋值回图像
                    P(curposl+m,curposc+n)=pixnew;
                end
            end
        end
        curposc=mod(curposc,i)+1;
        curposl=(curposl+fix((curposc+1)/j));
    end
end

        
    