function bit_seq=ACHuffmanEncoding(x,y) 

%%******************************************************************* 
%% ��ɨ���ÿ���ACϵ������Huffman����,Revised in Jun,2006
%% xΪzigzagɨ����0����0�ĸ���;yΪ��0�����0ֵ�ķ���
%% ���ֱ�Ϊ(run,level)�е�run,level
%%*******************************************************************

%%************************************* AC Huffman Code Look up ************************************%%
%% ZΪ��0����0�ĸ�����RΪ���ȵľ���ֵ
%% ��һ�����ŵı��룺accodeΪ�Զ�ά�¼�(run,level)�ı�������codelenΪ������볤
%% �Եڶ������ŵı��룺
%% ��level > 0�������������ԭ���ʾ����level < 0������������Ʒ����ʾ��amplenΪ��ʾ���������bit��
%%**************************************************************************************************%%

Z=x;
v0=y;
R=abs(y);
if R==1;amplen=1;
elseif(R >=   2 & R <=    3);amplen = 2;
elseif(R >=   4 & R <=    7);amplen = 3;
elseif(R >=   8 & R <=   15);amplen = 4;
elseif(R >=  16 & R <=   31);amplen = 5;
elseif(R >=  32 & R <=   63);amplen = 6;
elseif(R >=  64 & R <=  127);amplen = 7;
elseif(R >= 128 & R <=  255);amplen = 8;
elseif(R >= 256 & R <=  511);amplen = 9;
elseif(R >= 512 & R <= 1023);amplen = 10;
end 
 %%(Z==0 & amplen==0);codelen=4;accode=10;%%accode=0xA;%%accode=1010;(EOB)
if (Z==0 & amplen==1); codelen=2;accode=0;%%accode=0x0;%%accode=00;
elseif  (Z==0 & amplen==2);codelen=2;accode=1;%%accode=0x1;%%accode=01;
elseif  (Z==0 & amplen==3);codelen=3;accode=4;%%accode=0x4;%%accode=100;
elseif  (Z==0 & amplen==4);codelen=4;accode=11;%%accode=0xB;%%accode=1011;
elseif  (Z==0 & amplen==5);codelen=5;accode=26;%%accode=0x1A;%%accode=1 1010;
elseif  (Z==0 & amplen==6);codelen=7;accode=120;%%accode=0x78;%%accode=111 1000;
elseif  (Z==0 & amplen==7);codelen=8;accode=248;%%accode=0xF8;%%accode=1111 1000;
elseif  (Z==0 & amplen==8);codelen=10;accode=1014;%%accode=0x3F6;%%accode=11 1111 0110;  
elseif  (Z==0 & amplen==9);codelen=16;accode=65410;%%accode=0xFF82;%%accode=1111 1111 1000 0010;
elseif (Z==0 & amplen==10);codelen=16;accode=65411;%%accode=0xFF83;%%accode=1111 1111 1000 0011;
    
elseif  (Z==1 & amplen==1); codelen=4;accode=12;   %%accode=1100;
elseif  (Z==1 & amplen==2); codelen=5;accode=27;   %%accode=1 1011;
elseif  (Z==1 & amplen==3); codelen=7;accode=121;  %%accode=1111 001;
elseif  (Z==1 & amplen==4); codelen=9;accode=502;  %%accode=1 1111 0110;
elseif  (Z==1 & amplen==5);codelen=11;accode=2038; %%accode=111 1111 0110;
elseif  (Z==1 & amplen==6);codelen=16;accode=65412;%%accode=1111 1111 1000 0100;
elseif  (Z==1 & amplen==7);codelen=16;accode=65413;%%accode=1111 1111 1000 0101;
elseif  (Z==1 & amplen==8);codelen=16;accode=65414;%%accode=1111 1111 1000 0110;  
elseif  (Z==1 & amplen==9);codelen=16;accode=65415;%%accode=1111 1111 1000 0111;
elseif (Z==1 & amplen==10);codelen=16;accode=65416;%%accode=1111 1111 1000 1000;
    
elseif (Z==2 & amplen==1);codelen=5;accode=28;%%accode=1 1100;
elseif (Z==2 & amplen==2);codelen=8;accode=249;%%accode=1111 1001;
elseif (Z==2 & amplen==3);codelen=10;accode=1015;%%accode=11 1111 0111;
elseif (Z==2 & amplen==4);codelen=12;accode=4084;%%accode=1111 1111 0100;
elseif (Z==2 & amplen==5);codelen=16;accode=65417;%%accode=1111 1111 1000 1001;
elseif (Z==2 & amplen==6);codelen=16;accode=65418;%%accode=1111 1111 1000 1010;
elseif (Z==2 & amplen==7);codelen=16;accode=65419;%%accode=1111 1111 1000 1011;
elseif (Z==2 & amplen==8);codelen=16;accode=65420;%%accode=1111 1111 1000 1100;  
elseif (Z==2 & amplen==9);codelen=16;accode=65421;%%accode=1111 1111 1000 1101;
elseif (Z==2 & amplen==10);codelen=16;accode=65422;%%accode=1111 1111 1000 1110;
    
    
elseif (Z==3 & amplen==1);codelen=6;accode=58;%%accode=1 11010;
elseif (Z==3 & amplen==2);codelen=9;accode=503;%%accode=1 1111 0111;
elseif (Z==3 & amplen==3);codelen=12;accode=4085;%%accode=1111 1111 0101;
elseif (Z==3 & amplen==4);codelen=16;accode=65423;%%accode=1111 1111 1000 1111;
elseif (Z==3 & amplen==5);codelen=16;accode=65424;%%accode=1111 1111 1001 0000;
elseif (Z==3 & amplen==6);codelen=16;accode=65425;%%accode=1111 1111 1001 0001;
elseif (Z==3 & amplen==7);codelen=16;accode=65426;%%accode=1111 1111 1001 0010;
elseif (Z==3 & amplen==8);codelen=16;accode=65427;%%accode=1111 1111 1001 0011;  
elseif (Z==3 & amplen==9);codelen=16;accode=65428;%%accode=1111 1111 1001 0100;
elseif (Z==3 & amplen==10);codelen=16;accode=65429;%%accode=1111 1111 1001 0101;
    
    
elseif (Z==4 & amplen==1);codelen=6;accode=59;%%accode=11 1011;
elseif (Z==4 & amplen==2);codelen=10;accode=1016;%%accode=11 1111 1000;
elseif (Z==4 & amplen==3);codelen=16;accode=65430;%%accode=1111 1111 1001 0110;
elseif (Z==4 & amplen==4);codelen=16;accode=65431;%%accode=1111 1111 1001 0111;
elseif (Z==4 & amplen==5);codelen=16;accode=65432;%%accode=1111 1111 1001 1000;
elseif (Z==4 & amplen==6);codelen=16;accode=65433;%%accode=1111 1111 1001 1001;
elseif (Z==4 & amplen==7);codelen=16;accode=65434;%%accode=1111 1111 1001 1010;
elseif (Z==4 & amplen==8);codelen=16;accode=65435;%%accode=1111 1111 1001 1011;  
elseif (Z==4 & amplen==9);codelen=16;accode=65436;%%accode=1111 1111 1001 1100;
elseif (Z==4 & amplen==10);codelen=16;accode=65437;%%accode=1111 1111 1001 1101;
    
elseif (Z==5 & amplen==1);codelen=7;accode=122;%%accode=111 1010;
elseif (Z==5 & amplen==2);codelen=11;accode=2039;%%accode=111 1111 0111;
elseif (Z==5 & amplen==3);codelen=16;accode=65438;%%accode=1111 1111 1001 1110;
elseif (Z==5 & amplen==4);codelen=16;accode=65439;%%accode=1111 1111 1001 1111;
elseif (Z==5 & amplen==5);codelen=16;accode=65440;%%accode=1111 1111 1010 0000;
elseif (Z==5 & amplen==6);codelen=16;accode=65441;%%accode=1111 1111 1010 0001;
elseif (Z==5 & amplen==7);codelen=16;accode=65442;%%accode=1111 1111 1010 0010;
elseif (Z==5 & amplen==8);codelen=16;accode=65443;%%accode=1111 1111 1010 0011;  
elseif (Z==5 & amplen==9);codelen=16;accode=65444;%%accode=1111 1111 1010 0100;
elseif (Z==5 & amplen==10);codelen=16;accode=65445;%%accode=1111 1111 1010 0101;

elseif (Z==6 & amplen==1);codelen=7;accode=123;%%accode=11 11011;
elseif (Z==6 & amplen==2);codelen=12;accode=4086;%%accode=1111 1111 0110;
elseif (Z==6 & amplen==3);codelen=16;accode=65446;%%accode=1111 1111 1010 0110;
elseif (Z==6 & amplen==4);codelen=16;accode=65447;%%accode=1111 1111 1010 0111;
elseif (Z==6 & amplen==5);codelen=16;accode=65448;%%accode=1111 1111 1010 1000;
elseif (Z==6 & amplen==6);codelen=16;accode=65449;%%accode=1111 1111 1010 1001;
elseif (Z==6 & amplen==7);codelen=16;accode=65450;%%accode=1111 1111 1010 1010;
elseif (Z==6 & amplen==8);codelen=16;accode=65451;%%accode=1111 1111 1010 1011;  
elseif (Z==6 & amplen==9);codelen=16;accode=65452;%%accode=1111 1111 1010 1100;
elseif (Z==6 & amplen==10);codelen=16;accode=65453;%%accode=1111 1111 1010 1101;
    
    
elseif (Z==7 & amplen==1);codelen=8;accode=250;%%accode=1111 1010;
elseif (Z==7 & amplen==2);codelen=12;accode=4087;%%accode=1111 1111 0111;
elseif (Z==7 & amplen==3);codelen=16;accode=65454;%%accode=1111 1111 1010 1110;
elseif (Z==7 & amplen==4);codelen=16;accode=65455;%%accode=1111 1111 1010 1111;
elseif (Z==7 & amplen==5);codelen=16;accode=65456;%%accode=1111 1111 1011 0000;
elseif (Z==7 & amplen==6);codelen=16;accode=65457;%%accode=1111 1111 1011 0001;
elseif (Z==7 & amplen==7);codelen=16;accode=65458;%%accode=1111 1111 1011 0010;
elseif (Z==7 & amplen==8);codelen=16;accode=65459;%%accode=1111 1111 1011 0011;  
elseif (Z==7 & amplen==9);codelen=16;accode=65460;%%accode=1111 1111 1011 0100;
elseif (Z==7 & amplen==10);codelen=16;accode=65461;%%accode=1111 1111 1011 0101;
    
elseif (Z==8 & amplen==1);codelen=9;accode=504;%%accode=1 1111 1000;
elseif (Z==8 & amplen==2);codelen=15;accode=32704;%%accode=111 1111 1100 0000;
elseif (Z==8 & amplen==3);codelen=16;accode=65462;%%accode=1111 1111 1011 0110;
elseif (Z==8 & amplen==4);codelen=16;accode=65463;%%accode=1111 1111 1011 0111;
elseif (Z==8 & amplen==5);codelen=16;accode=65464;%%accode=1111 1111 1011 1000;
elseif (Z==8 & amplen==6);codelen=16;accode=65465;%%accode=1111 1111 1011 1001;
elseif (Z==8 & amplen==7);codelen=16;accode=65466;%%accode=1111 1111 0011 1010;
elseif (Z==8 & amplen==8);codelen=16;accode=65467;%%accode=1111 1111 1011 1011;  
elseif (Z==8 & amplen==9);codelen=16;accode=65468;%%accode=1111 1111 1011 1100;
elseif (Z==8 & amplen==10);codelen=16;accode=65469;%%accode=1111 1111 1011 1101;
    
elseif (Z==9 & amplen==1);codelen=9;accode=505;%%accode=1 1111 1001;
elseif (Z==9 & amplen==2);codelen=16;accode=65470;%%accode=1111 1111 1011 1110;
elseif (Z==9 & amplen==3);codelen=16;accode=65471;%%accode=1111 1111 1011 1111;
elseif (Z==9 & amplen==4);codelen=16;accode=65472;%%accode=1111 1111 1100 0000;
elseif (Z==9 & amplen==5);codelen=16;accode=65473;%%accode=1111 1111 1100 0001;
elseif (Z==9 & amplen==6);codelen=16;accode=65474;%%accode=1111 1111 1100 0010;
elseif (Z==9 & amplen==7);codelen=16;accode=65475;%%accode=1111 1111 1100 0011;
elseif (Z==9 & amplen==8);codelen=16;accode=65476;%%accode=1111 1111 1100 0100;  
elseif (Z==9 & amplen==9);codelen=16;accode=65477;%%accode=1111 1111 1100 0101;
elseif (Z==9 & amplen==10);codelen=16;accode=65478;%%accode=1111 1111 1100 0110;

elseif (Z==10 & amplen==1);codelen=9;accode=506;%%accode=1 1111 1010;
elseif (Z==10 & amplen==2);codelen=16;accode=65479;%%accode=1111 1111 1100 0111;
elseif (Z==10 & amplen==3);codelen=16;accode=65480;%%accode=1111 1111 1100 1000;
elseif (Z==10 & amplen==4);codelen=16;accode=65481;%%accode=1111 1111 1100 1001;
elseif (Z==10 & amplen==5);codelen=16;accode=65482;%%accode=1111 1111 1100 1010;
elseif (Z==10 & amplen==6);codelen=16;accode=65483;%%accode=1111 1111 1100 1011;
elseif (Z==10 & amplen==7);codelen=16;accode=65484;%%accode=1111 1111 1100 1100;
elseif (Z==10 & amplen==8);codelen=16;accode=65485;%%accode=1111 1111 1100 1101;  
elseif (Z==10 & amplen==9);codelen=16;accode=65486;%%accode=1111 1111 1100 1110;
elseif (Z==10 & amplen==10);codelen=16;accode=65487;%%accode=1111 1111 1100 1111;

elseif (Z==11 & amplen==1);codelen=10;accode=1017;%%accode=11 1111 1001;
elseif (Z==11 & amplen==2);codelen=16;accode=65488;%%accode=1111 1111 1101 0000;
elseif (Z==11 & amplen==3);codelen=16;accode=65489;%%accode=1111 1111 1101 0001;
elseif (Z==11 & amplen==4);codelen=16;accode=65490;%%accode=1111 1111 1101 0010;
elseif (Z==11 & amplen==5);codelen=16;accode=65491;%%accode=1111 1111 1101 0011;
elseif (Z==11 & amplen==6);codelen=16;accode=65492;%%accode=1111 1111 1101 0100;
elseif (Z==11 & amplen==7);codelen=16;accode=65493;%%accode=1111 1111 1101 0101;
elseif (Z==11 & amplen==8);codelen=16;accode=65494;%%accode=1111 1111 1101 0110;  
elseif (Z==11 & amplen==9);codelen=16;accode=65495;%%accode=1111 1111 1101 0111;
elseif (Z==11 & amplen==10);codelen=16;accode=65496;%%accode=1111 1111 1101 1000;
 
elseif  (Z==12 & amplen==1);codelen=10;accode=1018; %%accode=11 1111 1010;
elseif  (Z==12 & amplen==2);codelen=16;accode=65497;%%accode=1111 1111 1101 1001;
elseif  (Z==12 & amplen==3);codelen=16;accode=65498;%%accode=1111 1111 1101 1010;
elseif  (Z==12 & amplen==4);codelen=16;accode=65499;%%accode=1111 1111 1101 1011;
elseif  (Z==12 & amplen==5);codelen=16;accode=65500;%%accode=1111 1111 1101 1100;
elseif  (Z==12 & amplen==6);codelen=16;accode=65501;%%accode=1111 1111 1101 1101;
elseif  (Z==12 & amplen==7);codelen=16;accode=65502;%%accode=1111 1111 1101 1110;
elseif  (Z==12 & amplen==8);codelen=16;accode=65503;%%accode=1111 1111 1101 1111;  
elseif  (Z==12 & amplen==9);codelen=16;accode=65504;%%accode=1111 1111 1110 0000;
elseif (Z==12 & amplen==10);codelen=16;accode=65505;%%accode=1111 1111 1110 0001;
    
elseif  (Z==13 & amplen==1);codelen=11;accode=2040; %%accode=111 1111 1000;
elseif  (Z==13 & amplen==2);codelen=16;accode=65506;%%accode=1111 1111 1110 0010;
elseif  (Z==13 & amplen==3);codelen=16;accode=65507;%%accode=1111 1111 1110 0011;
elseif  (Z==13 & amplen==4);codelen=16;accode=65508;%%accode=1111 1111 1110 0100;
elseif  (Z==13 & amplen==5);codelen=16;accode=65509;%%accode=1111 1111 1110 0101;
elseif  (Z==13 & amplen==6);codelen=16;accode=65510;%%accode=1111 1111 1110 0110;
elseif  (Z==13 & amplen==7);codelen=16;accode=65511;%%accode=1111 1111 1110 0111;
elseif  (Z==13 & amplen==8);codelen=16;accode=65512;%%accode=1111 1111 1110 1000;  
elseif  (Z==13 & amplen==9);codelen=16;accode=65513;%%accode=1111 1111 1110 1001;
elseif (Z==13 & amplen==10);codelen=16;accode=65514;%%accode=1111 1111 1110 1010;    
    
elseif  (Z==14 & amplen==1);codelen=16;accode=65515;%%accode=1111 1111 1110 1011;
elseif  (Z==14 & amplen==2);codelen=16;accode=65516;%%accode=1111 1111 1110 1100;
elseif  (Z==14 & amplen==3);codelen=16;accode=65517;%%accode=1111 1111 1110 1101;
elseif  (Z==14 & amplen==4);codelen=16;accode=65518;%%accode=1111 1111 1110 1110;
elseif  (Z==14 & amplen==5);codelen=16;accode=65519;%%accode=1111 1111 1110 1111;
elseif  (Z==14 & amplen==6);codelen=16;accode=65520;%%accode=1111 1111 1111 0000;
elseif  (Z==14 & amplen==7);codelen=16;accode=65521;%%accode=1111 1111 1111 0001;
elseif  (Z==14 & amplen==8);codelen=16;accode=65522;%%accode=1111 1111 1111 0010;  
elseif  (Z==14 & amplen==9);codelen=16;accode=65523;%%accode=1111 1111 1111 0011;
elseif (Z==14 & amplen==10);codelen=16;accode=65524;%%accode=1111 1111 1111 0100;      
    
      %%(Z==15 & amplen==0);codelen=11;accode=2041;%%accode=111 1111 1001;(ZRL)
elseif  (Z==15 & amplen==1);codelen=16;accode=65525;%%accode=1111 1111 1111 0101;
elseif  (Z==15 & amplen==2);codelen=16;accode=65526;%%accode=1111 1111 1111 0110;
elseif  (Z==15 & amplen==3);codelen=16;accode=65527;%%accode=1111 1111 1111 0111;
elseif  (Z==15 & amplen==4);codelen=16;accode=65528;%%accode=1111 1111 1111 1000;
elseif  (Z==15 & amplen==5);codelen=16;accode=65529;%%accode=1111 1111 1111 1001;
elseif  (Z==15 & amplen==6);codelen=16;accode=65530;%%accode=1111 1111 1111 1010;
elseif  (Z==15 & amplen==7);codelen=16;accode=65531;%%accode=1111 1111 1111 1011; 
elseif  (Z==15 & amplen==8);codelen=16;accode=65532;%%accode=1111 1111 1111 1100; 
elseif  (Z==15 & amplen==9);codelen=16;accode=65533;%%accode=1111 1111 1111 1101;
elseif (Z==15 & amplen==10);codelen=16;accode=65534;%%accode=1111 1111 1111 1110;      
end
if v0>0;
     bit_seq=[dec2bin(accode,codelen),dec2bin(R,amplen)];
else bit_seq=[dec2bin(accode,codelen),dec2bin(bitcmp(R,amplen),amplen)];
end

%% dec2bin()Ϊʮ������������������ת������һ��������Ҫת����ʮ��������
%% �ڶ�������Ϊת������������λ�������Ҫ���λ������ֱ��ת�����λ�����Զ���ǰ�油0��
%% bitcmp()ȡ���룬��һ��������Ҫȡ���Ķ�������ʮ��������ʾ��
%% �ڶ�������ָ���Զ���λ�Ķ�������ȡ�������Ҫ���λ������ֱ�ӱ�ʾ�Ķ���������λ�����Զ���ǰ�油0��
%% bitcmp()�Ľ��Ϊȡ�����ʮ��������ʾ