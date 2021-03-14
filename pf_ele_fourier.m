clc;
clear all;

%%
% This code is for professional building only.

fil = xlsread('april17-march19.xlsx','Pf','D4:D733');
nil = xlsread('april19-sep20.xlsx','Pf','D4:D552');
 adell=xlsread('april17-march19.xlsx','Ad','D4:D733');
 adel=xlsread('april19-sep20.xlsx','Ad','D4:D552');
% auhel=xlsread('april17-march19.xlsx','Ah','D4:D733');
% auhel2=xlsread('april19-sep20.xlsx','Ah','D4:D552');
% ssel1=xlsread('april17-march19.xlsx','Ss','D4:D733');
% ssel2=xlsread('april19-sep20.xlsx','Ss','D4:D552');

t = datetime(2017,4,1) + caldays(0:1278);
%% weather data

Wd_T1=xlsread('april17-march19.xlsx','Wd','B4:B733');
Wd_T2=xlsread('april19-sep20.xlsx','Wd','B4:B552');
%combining both interval data
weather=[Wd_T1;Wd_T2]';

%weather = normalize(weather);

figure,
plot(t,weather), hold on

fftw = fft(weather);
power = fftw.*conj(fftw)/length(weather);
idx = power > 1000;
psdc = power.*idx;
fftw = idx.*fftw;
ifftw = ifft(fftw);
plot(t,ifftw,'Linewidth',2)

%% professional building Electrical Fourier Signal

club = [fil;nil];
club =abs(normalize(club'));

n= length(club);
f_hat = fft(club);

PSD = f_hat.*conj(f_hat)/n; % Power spectrum (power per freq)

indices = PSD > 10; % Find all freqs with large power
PSDclean = PSD.*indices; % Zero out all others
f_hat = indices.*f_hat; % Zero out small Fourier coeffs. in Y
ff_hat = abs(ifft(f_hat));

figure, plot(t,club,'-o',t,ff_hat)
legend('original','fourier')
figure, 
plot(t,ff_hat)
xlabel('time interval'),ylabel('fourier')
 figure,plot(t,PSD)

%% Administration Building Electricity Fourier 

adclub = [adell;adel];
adclub = normalize(adclub);

n =length(adclub);
adclub_hat = fft(adclub);

psd = adclub_hat.*conj(adclub_hat)/n;
ind = psd > 10;
psdc = psd.*ind;
adclub_hat = ind.*adclub_hat;
adclub_ihat = real(ifft(adclub_hat));

figure, plot(t,adclub,t,adclub_ihat)
legend('original','fourier')
figure, 
plot(t,adclub)
xlabel('time interval'),ylabel('fourier')