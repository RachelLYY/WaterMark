function cr = createtext (txt)

close all 
text(0,0,txt,'fontweight','bold','fontsize',25,'fontname','helvatica')
% set(gca,'xlim',[-1 1])
% set(gca,'ylim',[-1 1])
set(gca,'visible','off');
saveas(1,'test.im.png')
close 

a=imread('test.im.png');
delete ('test.im.png')
a=sum(a,3);
va = var(a');
vat = var(a);
f1=find(va>0,1,'first');
ft1=find(vat>0,1,'first');
f2=find(va>0,1,'last');
ft2=find(vat>0,1,'last');
a=a(f1:f2,ft1:ft2);
% imagesc(a)
cr=a==0;
% pause(.4);
% close