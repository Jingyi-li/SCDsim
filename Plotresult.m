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



%% Plot the result figure
clear all
x = 14:26;
currentPath=pwd;
load(fullfile(currentPath,'DeepsigFAMAmp100saveresult4.mat'))
result.input1.FAM = result_save.resultcell2;
load(fullfile(currentPath,'DeepsigSSCAAmp100saveresult4.mat'))
result.input1.SSCA = result_save.resultcell2;
load(fullfile(currentPath,'SineFAMAmp100saveresult4.mat'))
result.input2.FAM = result_save.resultcell2;
load(fullfile(currentPath,'SineSSCAAmp100saveresult4.mat'))
result.input2.SSCA = result_save.resultcell2;
load(fullfile(currentPath,'SquareFAMAmp100saveresult4.mat'))
result.input3.FAM = result_save.resultcell2;
load(fullfile(currentPath,'SquareSSCAAmp100saveresult4.mat'))
result.input3.SSCA = result_save.resultcell2;

%% Compute the Average
result.input1 = computeAvg(result.input1);
result.input2 = computeAvg(result.input2);
result.input3 = computeAvg(result.input3);
%% plot errors
figure;
hold on
p1=plot(x, result.input1.FAMavg(:,2),'ro','DisplayName','DeepSigFAM');
p2=plot(x, result.input1.SSCAavg(:,2),'rs','DisplayName','DeepSigSSCA');


p3=plot(x, result.input2.FAMavg(:,2),'bo','DisplayName','SineWaveFAM');
p4=plot(x,result.input2.SSCAavg(:,2),'bs','DisplayName','SineWaveSSCA');%,'DisplayName','SineWaveSSCASimu'


p5=plot(x,result.input3.FAMavg(:,2),'go','DisplayName','SquareWaveFAM');
p6=plot(x, result.input3.SSCAavg(:,2),'gs','DisplayName','SquareWaveSSCA');%,'DisplayName','SquareWaveSSCAError'

% title('The SQNR result of FAM & SSCA method for three input signal');
legend([p1,p2,p3,p4,p5,p6],'Location','best');
% legend([p1,p2,p5,p6],'Location','best');
% legend([p2,p4,p6],'Location','best');
xlabel('Average bits Avg');
ylabel('SQNR errors (dB)');
ylim([-9 0.5])
yline(0);

%% Required functions

function output = computeAvg(input)
    temp = input.SSCA(2:end,1:6);
    temp_avg = cell2mat({(cell2mat(temp(:,1))+cell2mat(temp(:,2))+cell2mat(temp(:,3))+cell2mat(temp(:,4)))/4,-(double(cell2mat(temp(:,5)))-double(cell2mat(temp(:,6))))});
    x = unique(temp_avg(:,1));
    avg = zeros(length(x),2);
    avg(:,1) = x;
    for i=x'
        idx = find(temp_avg(:,1)==i);
        avg(find(avg(:,1)==i),2) = sum(temp_avg(idx,2))/length(idx);
    end
    input.SSCAavg = avg;
    
    temp = input.FAM(2:end,1:6);
    temp_avg = cell2mat({(cell2mat(temp(:,1))+cell2mat(temp(:,2))+cell2mat(temp(:,3))+cell2mat(temp(:,4)))/4,-(double(cell2mat(temp(:,5)))-double(cell2mat(temp(:,6))))});
    x = unique(temp_avg(:,1));
    avg = zeros(length(x),2);
    avg(:,1) = x;
    for i=x'
        idx = find(temp_avg(:,1)==i);
        avg(find(avg(:,1)==i),2) = sum(temp_avg(idx,2))/length(idx);
    end
    input.FAMavg = avg;
    output = input;
end 