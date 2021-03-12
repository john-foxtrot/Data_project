%% Administration building


% Importing data from excel  
Ad_Wc1=xlsread('april17-march19.xlsx','Ad','B4:B733');
Ad_Hw1=xlsread('april17-march19.xlsx','Ad','C4:C733');
Ad_El1=xlsread('april17-march19.xlsx','Ad','D4:D733');
Ad_Ng1=xlsread('april17-march19.xlsx','Ad','E4:E733');
Ad_Dc1=xlsread('april17-march19.xlsx','Ad','F4:F733');
Ad_Wc2=xlsread('april19-sep20.xlsx','Ad','B4:B552');
Ad_Hw2=xlsread('april19-sep20.xlsx','Ad','C4:C552');
Ad_El2=xlsread('april19-sep20.xlsx','Ad','D4:D552');
Ad_Ng2=xlsread('april19-sep20.xlsx','Ad','E4:E552');
Ad_Dc2=xlsread('april19-sep20.xlsx','Ad','F4:F552');
%combining both interval data
Ad_Wc=[Ad_Wc1;Ad_Wc2];
Ad_Hw=[Ad_Hw1;Ad_Hw2];
Ad_El=[Ad_El1;Ad_El2];
Ad_Ng=[Ad_Ng1;Ad_Ng2];
Ad_Dc=[Ad_Dc1;Ad_Dc2];
%
%% Aurora Hall

% Importing data from excel
Ah_Wc1=xlsread('april17-march19.xlsx','Ah','B4:B733');
Ah_Hw1=xlsread('april17-march19.xlsx','Ah','C4:C733');
Ah_El1=xlsread('april17-march19.xlsx','Ah','D4:D733');
Ah_Dc1=xlsread('april17-march19.xlsx','Ah','E4:E733');
Ah_Wc2=xlsread('april19-sep20.xlsx','Ah','B4:B552');
Ah_Hw2=xlsread('april19-sep20.xlsx','Ah','C4:C552');
Ah_El2=xlsread('april19-sep20.xlsx','Ah','D4:D552');
Ah_Dc2=xlsread('april19-sep20.xlsx','Ah','E4:E552');
%combining both interval data
Ah_Wc=[Ah_Wc1;Ah_Wc2];
Ah_Hw=[Ah_Hw1;Ah_Hw2];
Ah_El=[Ah_El1;Ah_El2];
Ah_Dc=[Ah_Dc1;Ah_Dc2];
%% Professional studies



% Importing data from excel
Pf_Wc1=xlsread('april17-march19.xlsx','Pf','B4:B733');
Pf_Hw1=xlsread('april17-march19.xlsx','Pf','C4:C733');
Pf_El1=xlsread('april17-march19.xlsx','Pf','D4:D733');
Pf_Dc1=xlsread('april17-march19.xlsx','Pf','E4:E733');
Pf_Wc2=xlsread('april19-sep20.xlsx','Pf','B4:B552');
Pf_Hw2=xlsread('april19-sep20.xlsx','Pf','C4:C552');
Pf_El2=xlsread('april19-sep20.xlsx','Pf','D4:D552');
Pf_Dc2=xlsread('april19-sep20.xlsx','Pf','E4:E552');
%combining both interval data
Pf_Wc=[Pf_Wc1;Pf_Wc2];
Pf_Hw=[Pf_Hw1;Pf_Hw2];
Pf_El=[Pf_El1;Pf_El2];
Pf_Dc=[Pf_Dc1;Pf_Dc2];
%% Social Studies

% Importing data from excel
Ss_Wc1=xlsread('april17-march19.xlsx','Ss','B4:B733');
Ss_Hw1=xlsread('april17-march19.xlsx','Ss','C4:C733');
Ss_El1=xlsread('april17-march19.xlsx','Ss','D4:D733');
Ss_Dc1=xlsread('april17-march19.xlsx','Ss','E4:E733');
Ss_Wc2=xlsread('april19-sep20.xlsx','Ss','B4:B552');
Ss_Hw2=xlsread('april19-sep20.xlsx','Ss','C4:C552');
Ss_El2=xlsread('april19-sep20.xlsx','Ss','D4:D552');
Ss_Dc2=xlsread('april19-sep20.xlsx','Ss','E4:E552');
%combining both interval data
Ss_Wc=[Ss_Wc1;Ss_Wc2]; 
Ss_Hw=[Ss_Hw1;Ss_Hw2];
Ss_El=[Ss_El1;Ss_El2];
Ss_Dc=[Ss_Dc1;Ss_Dc2];
%% Weather Data

% Importing data from excel
Wd_T1=xlsread('april17-march19.xlsx','Wd','B4:B733');
Wd_T2=xlsread('april19-sep20.xlsx','Wd','B4:B552');
%combining both interval data
Wd_T=[Wd_T1;Wd_T2];
%% Days

% defining the time vector using matlab function
t = datetime(2017,4,1):days(1):datetime(2020,9,30);

%% PCA

% grouping the data of each building as a matrix
MAd=[Ad_Wc';Ad_Hw';Ad_El';Ad_Ng';Ad_Dc'];
MAh=[Ah_Wc';Ah_Hw';Ah_El';Ah_Dc'];
MPf=[Pf_Wc';Pf_Hw';Pf_El';Pf_Dc'];
MSs=[Ss_Wc';Ss_Hw';Ss_El';Ss_Dc'];
Wd_T=[Wd_T1;Wd_T2]';

% clubbing all data of all buildings and weather data.
M=[MAd;MAh;MPf;MSs;Wd_T];

%normalizing data so that co-variation can be studied irrespective of the
%magnitude difference.
M=normalize(M');
[coeff,score,latent,tsquared,explained,mu]=pca(M);

%Visualizing clustering if any
figure(1)
scatter(score(:,1),score(:,2)), score(:,3);
axis equal
xlabel('PC 1')
ylabel('PC 2')
zlabel('PC 3')
saveas(gcf,'cluster.png')

% Visualizing contribution of each variable to first three PCs.
figure(2)
v={'Ad_Wc','Ad_Hw','Ad_El','Ad_Ng','Ad_Dc','Ah_Wc','Ah_Hw','Ah_El','Ah_Dc','Pf_Wc','Pf_Hw','Pf_El','Pf_Dc','Ss_Wc','Ss_Hw','Ss_El','Ss_Dc','Wd_T'}
biplot(coeff(:,1:3),'VarLabels',v);
saveas(gcf,'cluster.png')

% biplot for PC1 and PC2.
figure(3)
v={'Ad_Wc','Ad_Hw','Ad_El','Ad_Ng','Ad_Dc','Ah_Wc','Ah_Hw','Ah_El','Ah_Dc','Pf_Wc','Pf_Hw','Pf_El','Pf_Dc','Ss_Wc','Ss_Hw','Ss_El','Ss_Dc','Wd_T'}
biplot(coeff(:,1:2),'VarLabels',v);
saveas(gcf,'biplot.png')

%plot explained for energy of the PCs.
figure(4)
plot(cumsum(explained),'o-')
xlabel('nth PC'), ylabel('relative energy (%)')
saveas(gcf,'relative energy.png')