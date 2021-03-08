function [ Sx, alphao,fo ,result] = autosscaSingleNormv3(x,fs,df,dalpha,bitInput,scale)
%       AUTOSSCA(X,FS,DF,DALPHA) COMPUTES THE SPECTRAL AUTO-
%       correlation density function estimate of the signal X,
%       by using the Strip Spectral Correlation Algorithm (SSCA).
%       Make sure that DF is much bigger than DALPHA in order to have a
%       reliable estimate.
%
%       INPUTS:
%       X      - INPUT COLUMN VECTOR;
%       FS     - sampling rate;
%       DF     - desired frequency resolution; and
%       DALPHA - desired cyclic frequency resolution.
%
%       OPTIONS:
%       SX     - spectral auto-correlation density function estimate;
%       ALPHAO - cyclic frequency; and
%       FO     - spectrum frequency.
%
%       Author: E.L.Da Costa, 9/28/95.

if nargin ~= 6
    error('Wrong number of arguments');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definition of Parameters %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Np=pow2(nextpow2(fs/df));      %Number of input channels, defined
                                %by the desired frequency
                                %resolution (df) as follows:
                                %Np=fs/df, where fs is the original
                                %data sampling rate. It must be a
                                %power of 2 to avoid truncation or
                                %zero-padding in the FFT routines;
                                
L = Np/4;                       %Offset between points in the same
                                %column at consecutive rows in the
                                %same channelization matrix. It
                                %should be chosen to be less than
                                %or equal to Np/4;
                                
P=pow2(nextpow2(fs/dalpha/L));  %Number of rows formed in the
                                %channelization matrix, defined by
                                %the desired cyclic frequency
                                %resolution (dalpha) as follows:
                                %P=fs/dalpha/L. It must be a power
                                %of 2;
                                
N=P*L;                          %Total number of points in the
                                %input data
bit = bitInput; 
%%%%%%%%%%%%%%%%%%%%%%%%
% Input Channelization %
%%%%%%%%%%%%%%%%%%%%%%%%
if length(x)<N
    x(N) = 0;
    disp('you will not get the desired resolution in cyclic frequncy');
    dalpha = fs/N;
    disp(['cyclic frequency resolution-', num2str(dalpha)]);
elseif length(x)>N
    x = x(1:N);
end
NN = (P-1)*L+Np;
xx=x;
xx(NN)=0;
xx=xx(:);
% X = zeros(Np,P);
X=fi(zeros(Np,P),1,bit.input,bit.input-1);
for k=0:P-1
    X(:,k+1) = xx(k*L+1:k*L+Np);
end
result.Input = X;
%%%%%%%%%%%%%
% Windowing %
%%%%%%%%%%%%%
a=hamming(Np);
XW=single(diag(a)*X);
result.Windowing = XW;
%%%%%%%%%%%%%
% FIrst FFT %
%%%%%%%%%%%%%
% XF1 = fft(XW);
XF1=FFTFloatv3(XW);
XF1 = fftshift(XF1);
XF1 = [XF1(:,P/2+1:P) XF1(:,1:P/2)];
result.FirstFFT = single(XF1);
XF1 = single(XF1);
result.FirstFFTnormal = XF1.*scale.FirstFFT;
XF1 = single(XF1.*scale.FirstFFT);
%%%%%%%%%%%%%%%%%%
% Downconversion %
%%%%%%%%%%%%%%%%%%
E = zeros(Np,P);
for k = -Np/2:Np/2-1
    for m = 0:P-1
        E(k+Np/2+1,m+1) = exp(-i*2*pi*k*m*L/Np);
    end
end
XD=XF1.*E;

%%%%%%%%%%%%%%%
% Replication %
%%%%%%%%%%%%%%%
XR = zeros(Np,P*L);
for k=1:P
    XR(:,(k-1)*L+1:k*L)= XD(:,k)*ones(1,L);
end

%%%%%%%%%%%%%%%%%%
% Multiplication %
%%%%%%%%%%%%%%%%%%
xc=ones(Np,1)*x;
XM=XR.*xc;
XM=conj(XM');

result.Multi = single(XM);
XM = single(XM);
result.Multinormal = XM.*scale.Multi;
XM = single(XM.*scale.Multi);
%%%%%%%%%%%%%%
% Second FFT %
%%%%%%%%%%%%%%
% XF2=fft(XM);
XF2=FFTFloatv3(XM);
XF2 = fftshift(XF2);
XF2 = [XF2(:,Np/2+1:Np) XF2(:,1:Np/2)];

result.SecondFFT = single(XF2);
XF2 = single(XF2);

result.SecondFFTnormal = XF2.*scale.SecondFFT;
XF2 = single(XF2.*scale.SecondFFT);
%%%%%%%%%%%%%%%%%%%
%% alpha profile %%
%%%%%%%%%%%%%%%%%%%
M = abs(XF2);
alphao=(-1:1/N:1)*fs;
fo=(-.5:1/Np:0.5)*fs;
Sx = zeros(Np+1,2*N+1);

for k1 = 1:N
    for k2 = 1:Np
        alpha = (k1-1)/N+(k2-1)/Np-1;
        f = ((k2-1)/Np-(k1-1)/N)/2;
%         k = 1+Np*(f+.5);
%         l = 1+N*(alpha+1);
        k = round(1+Np*(f+.5));
        l = round(1+N*(alpha+1));
        Sx(k,l) = M(k1,k2);
    end
end

end

