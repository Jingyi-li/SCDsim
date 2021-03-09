% Test bench for the theory

% clear all;

result_save = {'sum','bit_W','bit_F1', 'bit_CM','bit_F2','Theory_result','TotalCost','UnitSQNR','UnitCost'};
for b = 14:24
    result = SQNR1CostFAM(b,b,b,b);
    result_save = [result_save; {result.sum,b,b,b,b,result.SQNR,result.cost,result.unitSQNR,result.unitcost}];
end
unitBit = result_save;

result_save = {'sum','bit_W','bit_F1', 'bit_CM','bit_F2','Theory_result','TotalCost','UnitSQNR','UnitCost'};
CRbest = {'sum','bit_W','bit_F1', 'bit_CM','bit_F2','Theory_result','TotalCost','UnitSQNR','UnitCost'};


aimSQNR = [60,70,80,90,100,110];
aimcost = 2*10^17.*[0.1,0.3,0.5,0.7,0.9,1,1.1,1.3,1.5,1.7,1.9];


% Rsum = 72;
Rcost = 0;
Rbest = {};

for a = aimSQNR
    Rcs = Inf;
    for bw=12:26
        for bf1=12:26
            for bcm=12:26
                for bf2=12:26
                    result = SQNR1CostFAM(bw,bf1,bcm,bf2);
                    if a< result.SQNR
                        if result.cost<Rcs
                            Rcs = result.cost;
                            Rbest = {result.sum,bw,bf1,bcm,bf2,result.SQNR,result.cost,result.unitSQNR,result.unitcost};
                        end
                    end
                end
            end
        end
    end
    CRbest = [CRbest; Rbest];
end
givenSQNR = CRbest;

CRbest = {'sum','bit_W','bit_F1', 'bit_CM','bit_F2','Theory_result','TotalCost','UnitSQNR','UnitCost'};
for b = aimcost
    Rexp = 0;
    for bw=12:26
        for bf1=12:26
            for bcm=12:26
                for bf2=12:26
                    result = SQNR1CostFAM(bw,bf1,bcm,bf2);
                    if result.cost < b
                        if result.SQNR>Rexp
                            Rexp = result.SQNR;
                            Rbest = {result.sum,bw,bf1,bcm,bf2,result.SQNR,result.cost,result.unitSQNR,result.unitcost};
                        end
                    end
                    
                end
            end
        end
    end
    CRbest = [CRbest; Rbest];
end
givenCost = CRbest;

for c = 60
    Rcs = Inf;
    for bw=12:26
        for bf1=12:26
            for bcm=12:26
                for bf2=12:26
                    result = SQNR1CostFAM(bw,bf1,bcm,bf2);
                    if c< result.SQNR
                        result_save = [result_save; {result.sum,bw,bf1,bcm,bf2,result.SQNR,result.cost,result.unitSQNR,result.unitcost}];
                    end
                end
            end
        end
    end
end


%% Plot figure

figure;
hold on
p1=plot(cell2mat(givenSQNR(2:end,6)),cell2mat(givenSQNR(2:end,7)),'ro','DisplayName','Lowest Cost for SQNR');
p2=plot(cell2mat(givenCost(2:end,6)),cell2mat(givenCost(2:end,7)),'b*','DisplayName','Highest SQNR for Cost');
p3=plot(cell2mat(unitBit(2:end,6)),cell2mat(unitBit(2:end,7)),'ks','DisplayName','uniform bits');
p4=plot(cell2mat(result_save(2:500:end,6)),cell2mat(result_save(2:500:end,7)),'gs','DisplayName','Non-uniform bits');
legend([p1,p2,p3,p4],'Location','best');
ylabel('Area (full adders)');
xlabel('1/SQNR (dB)');


%% function

function result = SQNR1CostFAM(bw,bf1,bcm,bf2)
q1 = 0.085670955;
q2 = 0.96274096;
q3 = 0.10699078;
Ps = 0.15800409;

sum = bw+bf1+bcm+bf2;
nFFT1 = 256;
nFFT2 = 32;
nFFT3 = 2048;
bits = bw-1;
bit_fft1 = bf1-1;
bit_multi = bcm-1;
bit_fft2 = bf2-1;

Psignal = ((Ps/1.59^2*nFFT1)*q1^2)^2*nFFT2*q2^2*q3^2;
Pnoise = (2*nFFT1^2*nFFT2*q1^4*q2^2*q3^2*Ps)/(1.59^2*6)*2^(-2*bits)+(2*nFFT1*nFFT2*q1^2*q3^2*q2^2*Ps)/(1.59^2)*(q1^2*(nFFT1/6-1)+1/2)/(3)*2^(-2*bit_fft1)...
    + q3^2*nFFT2/3*(q2^2+1/2)*2^(-2*bit_multi) + (q3^2*(nFFT2/6-1)/(3) +1/6)*2^(-2*bit_fft2);

expR = 10*log10(Psignal/Pnoise);

unit_bit = floor(sum/4);
bit = unit_bit-1;
Pnoise = (2*nFFT1^2*nFFT2*q1^4*q2^2*q3^2*Ps)/(1.59^2*6)*2^(-2*bit)+(2*nFFT1*nFFT2*q1^2*q3^2*q2^2*Ps)/(1.59^2)*(q1^2*(nFFT1/6-1)+1/2)/(3)*2^(-2*bit)...
    + q3^2*nFFT2/3*(q2^2+1/2)*2^(-2*bit) + (q3^2*(nFFT2/6-1)/(3) +1/6)*2^(-2*bit);

unit_SQNR = 10*log10(Psignal/Pnoise);



cm_bit = 2*nFFT1*nFFT2;
cm_firstFFT = 4*nFFT2*nFFT1/2*log2(nFFT1)+2*nFFT1*nFFT2+4*nFFT1*nFFT2;
cm_multi = 4*nFFT1^2*nFFT2+2*nFFT1^2*nFFT2;
cm_secondFFT = 4*nFFT1^2*nFFT2/2*log2(nFFT2)+2*nFFT1^2*nFFT2;

ca_firstFFT = 3*nFFT1*nFFT2*log2(nFFT1)+2*nFFT1*nFFT2;
ca_multi = 2*nFFT1^2*nFFT2;
ca_secondFFT = 3*nFFT1^2*nFFT2*log2(nFFT2);


cost = (cm_bit*bw)^2 ...
    + (cm_firstFFT*bf1)^2+ca_firstFFT*bf1 ...
    + (cm_multi*bcm)^2+ca_multi*bcm ...
    + (cm_secondFFT*bf2)^2+ca_secondFFT*bf2;
unit_cost = (cm_bit*unit_bit)^2 ...
    + (cm_firstFFT*unit_bit)^2+ca_firstFFT*unit_bit ...
    + (cm_multi*unit_bit)^2+ca_multi*unit_bit ...
    + (cm_secondFFT*unit_bit)^2+ca_secondFFT*unit_bit;


result.sum = sum;
result.SQNR = expR;
result.unitSQNR = unit_SQNR;
result.cost = cost;
result.unitcost = unit_cost;

end

