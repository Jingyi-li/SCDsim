function [PsignalN,PnoiseN,expN] = TheorySSCA(Ps,q1,q2,q3,nFFT1,nFFT3,bits,bit_fft1,bit_multi,bit_fft2)
%THEORYSSCA Summary of this function goes here
%   Detailed explanation goes here
PsignalN = Ps^2*q1^2*q2^2*q3^2/1.59^2*nFFT1*nFFT3;
PnoiseN = Ps*q3^2*q2^2*q1^2*nFFT1*nFFT3/6*2^(-2*bits) ...
    + q3^2*Ps*nFFT3*q2^2*(q1^2*(nFFT1/6-1)+1/2)/3*2^(-2*bit_fft1)...
    + (q2^2+1/2)*q3^2*nFFT3/3*2^(-2*bit_multi) ...
    + (q3^2*(nFFT3/6-1)+1/2)/3*2^(-2*bit_fft2);
expN = 10*log10(PsignalN/PnoiseN);
end

