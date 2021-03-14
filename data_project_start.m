clc;
clear all;
close all;

pf_Wc1=xlsread('april17-march19.xlsx','Pf','B4:B733');
pf_Hw1=xlsread('april17-march19.xlsx','Pf','C4:C733');
pf_El1=xlsread('april17-march19.xlsx','Pf','D4:D733');
pf_Dc1=xlsread('april17-march19.xlsx','Pf','E4:E733');

pf_Wc2=xlsread('april19-sep20.xlsx','Pf','B4:B552');
pf_Hw2=xlsread('april19-sep20.xlsx','Pf','C4:C552');
pf_El2=xlsread('april19-sep20.xlsx','Pf','D4:D552');
pf_Dc2=xlsread('april19-sep20.xlsx','Pf','E4:E552');

% date conversion.
e2 = datetime(2017,4,1):days(1):datetime(2020,9,30);

pf_Wc=[pf_Wc1;pf_Wc2];
pf_Hw=[pf_Hw1;pf_Hw2];
pf_El=[pf_El1;pf_El2];
pf_Dc=[pf_Dc1;pf_Dc2];

%club data

comb = [pf_Wc';pf_Hw';pf_El';pf_Dc'];
comb = normalize(comb);

%[U,S,V] = svd(comb,'econ');
[coeff,score,latent,Tsquared,explained,mu] = pca(comb);

  figure,
   plot(e2,pf_Wc)   % this helps plotting based date
   xlabel('date'), ylabel('cold water value')
   title('cold water');
   figure,
   plot(e2,pf_Hw)
   title('hotwater');
    figure,
    plot(e2,pf_El)
    title('electricity');
    figure,
    plot(e2,pf_Dc)
   title('domestic cold water');