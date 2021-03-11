function [PsignalN,PnoiseN,expN] = TheoryFAM(Ps,q1,q2,q3,nFFT1,nFFT2,bits,bit_fft1,bit_multi,bit_fft2)
%THEORYFAM Summary of this function goes here
%   Detailed explanation goes here
PsignalN = ((Ps/1.59^2*nFFT1)*q1^2)^2*nFFT2*q2^2*q3^2;
PnoiseN = (2*nFFT1^2*nFFT2*q1^4*q2^2*q3^2*Ps)/(1.59^2*6)*2^(-2*bits)+(2*nFFT1*nFFT2*q1^2*q3^2*q2^2*Ps)/(1.59^2)*(q1^2*(nFFT1/6-1)+1/2)/(3)*2^(-2*bit_fft1)...
    + q3^2*nFFT2/3*(q2^2+1/2)*2^(-2*bit_multi) + (q3^2*(nFFT2/6-1)/(3) +1/6)*2^(-2*bit_fft2);
expN = 10*log10(PsignalN/PnoiseN);
end

