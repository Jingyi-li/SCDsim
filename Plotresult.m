% Plot the result figure

x = 14:24;

load('DeepSigFAMsaveresult.mat')
result.input1.FAM = result_save.resultcell2;
load('DeepSigSSCAsaveresult.mat')
result.input1.SSCA = result_save.resultcell2;
load('SineFAMsaveresult.mat')
result.input2.FAM = result_save.resultcell2;
load('SineSSCAsaveresult.mat')
result.input2.SSCA = result_save.resultcell2;
load('SquareFAMsaveresult.mat')
result.input3.FAM = result_save.resultcell2;
load('SquareSSCAsaveresult.mat')
result.input3.SSCA = result_save.resultcell2;

%% plot errors
figure;
hold on
p1=plot(x, cell2mat(result.input1.FAM(2:end,5))-cell2mat( result.input1.FAM(2:end,6)),'ro','DisplayName','DeepSigFAM');
p2=plot(x, cell2mat(result.input1.SSCA(2:end,5))-cell2mat(result.input1.SSCA(2:end,6)),'rs','DisplayName','DeepSigSSCA');


p3=plot(x, cell2mat(result.input2.FAM(2:end,5))-cell2mat( result.input2.FAM(2:end,6)),'bo','DisplayName','SineWaveFAM');
p4=plot(x,cell2mat(result.input2.SSCA(2:end,5))-cell2mat( result.input2.SSCA(2:end,6)),'bs','DisplayName','SineWaveSSCA');%,'DisplayName','SineWaveSSCASimu'


p5=plot(x,cell2mat(result.input3.FAM(2:end,5))-cell2mat(result.input3.FAM(2:end,6)),'go','DisplayName','SquareWaveFAM');
p6=plot(x, cell2mat(result.input3.SSCA(2:end,5))-cell2mat(result.input3.SSCA(2:end,6)),'gs','DisplayName','SquareWaveSSCA');%,'DisplayName','SquareWaveSSCAError'

% title('The SQNR result of FAM & SSCA method for three input signal');
legend([p1,p2,p3,p4,p5,p6],'Location','best');
xlabel('Bits B for each block');
ylabel('Errors of SQNR (dB)');



%% plot fig
figure;
hold on
plot(x, cell2mat(result.input1.FAM(2:end,5)),'ro','DisplayName','FAMSimu');
plot(x, cell2mat(result.input1.FAM(2:end,6)),'r*','DisplayName','FAMTheory');
plot(x, cell2mat(result.input1.SSCA(2:end,5)),'rs','DisplayName','SSCASimu');
plot(x, cell2mat(result.input1.SSCA(2:end,6)),'r.','DisplayName','SSCATheory');

plot(x, cell2mat(result.input2.FAM(2:end,5)),'bo');%,'DisplayName','SineWaveFAMSimu'
plot(x,cell2mat( result.input2.FAM(2:end,6)),'b*');%,'DisplayName','SineWaveFAMTheory'
plot(x,cell2mat(result.input2.SSCA(2:end,5)),'bs');%,'DisplayName','SineWaveSSCASimu'
plot(x,cell2mat( result.input2.SSCA(2:end,6)),'b.');%,'DisplayName','SineWaveSSCATheory'

plot(x,cell2mat(result.input3.FAM(2:end,5)),'go','DisplayName','SquareWaveFAMSimu');
plot(x, cell2mat(result.input3.FAM(2:end,6)),'g*');%,'DisplayName','SquareWaveFAMTheory'
plot(x, cell2mat(result.input3.SSCA(2:end,5)),'gs');%,'DisplayName','SquareWaveSSCASimu'
plot(x, cell2mat(result.input3.SSCA(2:end,6)),'g.');%,'DisplayName','SquareWaveSSCATheory'

p1=plot(nan, nan,'ko','DisplayName','FAMSimu');
p2=plot(nan, nan,'k*','DisplayName','FAMTheory');
p3=plot(nan, nan,'ks','DisplayName','SSCASimu');
p4=plot(nan, nan,'k.','DisplayName','SSCATheory');

% title('The SQNR result of FAM & SSCA method for three input signal');
legend([p1,p2,p3,p4],'Location','best');
xlabel('Bits B for each block');
ylabel('SQNR (dB)');