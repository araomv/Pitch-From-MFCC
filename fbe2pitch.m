function [ pitch_est1,pitch_est2 ] = fbe2pitch(fbe,H,window,fs,nfft,lamda,pr)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% fs=32000;
% nfft=2048;
rfft=(nfft/2)+1;
% Nw = length(window);
% window = hamming(Nw);
win_fft = abs(fft(window,nfft))/nfft;
W=toeplitz(win_fft);
W=W(1:rfft,1:rfft);
% lamda=.0001;
% H=H(:,4:237);
% W=W(4:237,4:237);
% prev_spec = ones(1025,1);
A=H*W;
M=A'*A;
opts = optimoptions('quadprog','Display','off');
Ns=240;
M=M(1:Ns,1:Ns);
A = A(:,1:Ns);
lamda = lamda*ones(1,Ns);
% N=size(FBE,2);
% FBE=double(FBE);
% spec=zeros(1025,N);


% fbe=fbe;
f=lamda-fbe'*A;
tmp=quadprog(M,f,[],[],[],[],zeros(size(M,2),1),[],[],opts);
tmp2=pinv(A)*fbe;
% pr=[90,150];
[~,pitch_est1]=shrp_spec2(tmp,fs,pr,40,10);
[~,pitch_est2]=shrp_spec2(tmp2,fs,pr,40,10);
end

