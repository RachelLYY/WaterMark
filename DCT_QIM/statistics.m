function sta = statistics(cover_object)
c1=1;
statistics_origin=zeros(1,4500);
statistics_replace=zeros(1,4500);
for k=1:2:255
    x1=sum(sum(cover_object==k));
    x2=sum(sum(cover_object==k-1));
    %×ö²î
    x=abs(x1-x2);
%     y1=sum(sum(watermarked_image==k));
%     y2=sum(sum(watermarked_image==k-1));
%     y=abs(y1-y2);
    % »æÍ¼
    statistics_origin(1,c1)=x;
    % statistics_replace(1,c1)=y;
    c1=c1+1;
end
plot(statistics_origin)
end