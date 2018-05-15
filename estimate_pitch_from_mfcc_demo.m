clear;
load('arctic_a0008.mat');
fs=32000;
nfft=2048;
rfft=(nfft/2)+1;
Nw = round(.04*fs);
window = hamming(Nw);
pr=[150,250];

for j=1:size(FBE,2)
fbe=FBE(:,j);
[ pitch_est1(j),pitch_est2(j)] = fbe2pitch(fbe,H,hamming(Nw),fs,nfft,.001,pr);
clc;
disp([num2str(j) '/' num2str(size(FBE,2))]);
end
plot(medfilt1(pitch_est2,5));hold on;plot(pitch,'r');hold off;