clear all; close all;clc
%% Initialization
Check_result = 0;
Type = 'FAM';
% path = '/home/jingyi/Documents/Projects/FFT/Code/sandboxResult/SCAsim';
path = '/mnt/drsftps/DataResult/SCDsim';
% path = pwd;
Amp = 1;
ifdisp = 0;
idxfile = 'idx4_result.mat';
load(idxfile);
%% DeepSig

fname = 'Deepsig'
result_save = {};
for index = 2:2
    disp(['---------------going to print DataSet' num2str(index) '----------------------------'])
    
    %---------------------Deepsig---------------------------------
    temp = load('/home/jingyi/Documents/Projects/FFT/Code/SCDsim/DeepSig.mat').a(index,:,:);
    temp=fi(Amp*(single(temp)./single(max(abs(temp)))),1,16,15);
    x = temp(:,:,1)+temp(:,:,2)*1i;
    x = [x x];
    %---------------------Sine or Square---------------------------------
    %     t = (0:1/2240:1);
    %     x = fi(0.98*square(2*pi*200*t),1,16,15)';
    %     x = fi(0.98*sin(2*pi*200*t),1,16,15)';
    
    fs = 1000; df = 5; dalpha = 0.5; %df 5 10 2.5 dalpha 0.5 1 0.25
    
    %----------------------UnitBits from 8 to 20----------------------------------------
    result_save.(['resultcell',num2str(index)]) = {'bits_w','bits_F1','bits_CM','bits_F2', 'normsimulation', 'normcalculation','q1','q2','q3'};
    
    
    for i = 1:length(idx_result)
        
        bit.input = idx_result(i,1);
        bit.windowing = idx_result(i,1);
        bit.firstFFT = idx_result(i,2);
        bit.ConjMulti = idx_result(i,3);
        bit.secondFFT = idx_result(i,4);

        
        if 0<=index && index<10
            filename = [fname Type num2str(bit.windowing) num2str(bit.firstFFT) num2str(bit.ConjMulti) num2str(bit.secondFFT) 'Amp' num2str(100*Amp) 'Norm0' num2str(index) 'v3'];
        else
            filename = [fname Type num2str(bit.windowing) num2str(bit.firstFFT) num2str(bit.ConjMulti) num2str(bit.secondFFT) 'Amp' num2str(100*Amp) 'Norm' num2str(index) 'v3'];
        end
        
        
        listing = dir(path);
        exist = 0;
        for l = 3:length(listing)
            if strfind(listing(l).name, [filename '.mat'])
                load([path '/' listing(l).name]);
                result_temp = printResult(result,resultF,bit,Type,ifdisp);
                exist = 1;
            end
        end
        
        if exist == 0
            switch Type
                case 'FAM'
                    % normalization:
                    % FFT and CM has increaseing integer bit to avoid
                    % overflow
                    [SxF,alphaoF,foF,resultF]=autofamFixedv3(x,fs,df,dalpha,bit);
                    [Sx,alphao,fo,result]=autofamv3(x,fs,df,dalpha,bit,resultF.Scale);
                case 'SSCA'
                    [SxF,alphaoF,foF,resultF]=autosscaFixedNormv3(x,fs,df,dalpha,bit);
                    [Sx,alphao,fo,result]=autosscaSingleNormv3(x,fs,df,dalpha,bit,resultF.Scale);
            end
            save([path '/' filename '.mat'],'bit','result','resultF');
            disp(['-----------' 'save' filename '-----------']);
            result_temp = printResult(result,resultF,bit,Type,ifdisp);
        end
        
        result_save.(['resultcell',num2str(index)]) = [result_save.(['resultcell',num2str(index)]);result_temp];
    end
end

save([path '/' fname Type 'Amp' num2str(Amp*100) 'saveresult' idxfile(4) '.mat'],'result_save');


%% Sine

fname = 'Sine'
result_save = {};
for index = 2:2
    disp(['---------------going to print DataSet' num2str(index) '----------------------------'])
    
    %---------------------Deepsig---------------------------------
    %     temp = load('/home/jingyi/Documents/Projects/FFT/Code/SCDsim/DeepSig.mat').a(index,:,:);
    %     temp=fi(single(temp)./single(max(temp)),1,16,15);
    %     x = temp(:,:,1)+temp(:,:,2)*1i;
    %     x = [x x];
    %---------------------Sine or Square---------------------------------
    t = (0:1/2240:1);
    %     x = fi(0.98*square(2*pi*200*t),1,16,15)';
    x = fi(Amp*sin(2*pi*200*t),1,16,15)';
    
    fs = 1000; df = 5; dalpha = 0.5; %df 5 10 2.5 dalpha 0.5 1 0.25
    
    %----------------------UnitBits from 8 to 20----------------------------------------
    result_save.(['resultcell',num2str(index)]) = {'bits_w','bits_F1','bits_CM','bits_F2', 'normsimulation', 'normcalculation','q1','q2','q3'};
    
    for i = 1:length(idx_result)
        
        bit.input = idx_result(i,1);
        bit.windowing = idx_result(i,1);
        bit.firstFFT = idx_result(i,2);
        bit.ConjMulti = idx_result(i,3);
        bit.secondFFT = idx_result(i,4);
        
        if 0<=index && index<10
            filename = [fname Type num2str(bit.windowing) num2str(bit.firstFFT) num2str(bit.ConjMulti) num2str(bit.secondFFT) 'Amp' num2str(100*Amp) 'Norm0' num2str(index) 'v3'];
        else
            filename = [fname Type num2str(bit.windowing) num2str(bit.firstFFT) num2str(bit.ConjMulti) num2str(bit.secondFFT) 'Amp' num2str(100*Amp) 'Norm' num2str(index) 'v3'];
        end
        
        
        listing = dir(path);
        exist = 0;
        for l = 3:length(listing)
            if strfind(listing(l).name, [filename '.mat'])
                load([path '/' listing(l).name]);
                result_temp = printResult(result,resultF,bit,Type,ifdisp);
                exist = 1;
            end
        end
        
        if exist == 0
            switch Type
                case 'FAM'
                    % normalization:
                    % FFT and CM has increaseing integer bit to avoid
                    % overflow
                    [SxF,alphaoF,foF,resultF]=autofamFixedv3(x,fs,df,dalpha,bit);
                    [Sx,alphao,fo,result]=autofamv3(x,fs,df,dalpha,bit,resultF.Scale);
                case 'SSCA'
                    [SxF,alphaoF,foF,resultF]=autosscaFixedNormv3(x',fs,df,dalpha,bit);
                    [Sx,alphao,fo,result]=autosscaSingleNormv3(x',fs,df,dalpha,bit,resultF.Scale);
            end
            save([path '/' filename '.mat'],'bit','result','resultF');
            disp(['-----------' 'save' filename '-----------']);
            result_temp = printResult(result,resultF,bit,Type,ifdisp);
        end
        
        result_save.(['resultcell',num2str(index)]) = [result_save.(['resultcell',num2str(index)]);result_temp];
    end
end


save([path '/' fname Type 'Amp' num2str(Amp*100) 'saveresult' idxfile(4) '.mat'],'result_save');

%% Square

fname = 'Square'
result_save = {};
for index = 2:2
    disp(['---------------going to print DataSet' num2str(index) '----------------------------'])
    
    %---------------------Deepsig---------------------------------
    %     temp = load('/home/jingyi/Documents/Projects/FFT/Code/SCDsim/DeepSig.mat').a(index,:,:);
    %     temp=fi(single(temp)./single(max(temp)),1,16,15);
    %     x = temp(:,:,1)+temp(:,:,2)*1i;
    %     x = [x x];
    %---------------------Sine or Square---------------------------------
    t = (0:1/2240:1);
    x = fi(Amp*square(2*pi*200*t),1,16,15)';
    %         x = fi(0.98*sin(2*pi*200*t),1,16,15)';
    
    fs = 1000; df = 5; dalpha = 0.5; %df 5 10 2.5 dalpha 0.5 1 0.25
    
    %----------------------UnitBits from 8 to 20----------------------------------------
    result_save.(['resultcell',num2str(index)]) = {'bits_w','bits_F1','bits_CM','bits_F2', 'normsimulation', 'normcalculation','q1','q2','q3'};
    
    for i = 1:length(idx_result)
        
        bit.input = idx_result(i,1);
        bit.windowing = idx_result(i,1);
        bit.firstFFT = idx_result(i,2);
        bit.ConjMulti = idx_result(i,3);
        bit.secondFFT = idx_result(i,4);
        
        if 0<=index && index<10
            filename = [fname Type num2str(bit.windowing) num2str(bit.firstFFT) num2str(bit.ConjMulti) num2str(bit.secondFFT) 'Amp' num2str(100*Amp) 'Norm0' num2str(index) 'v3'];
        else
            filename = [fname Type num2str(bit.windowing) num2str(bit.firstFFT) num2str(bit.ConjMulti) num2str(bit.secondFFT) 'Amp' num2str(100*Amp) 'Norm' num2str(index) 'v3'];
        end
        
        
        listing = dir(path);
        exist = 0;
        for l = 3:length(listing)
            if strfind(listing(l).name, [filename '.mat'])
                load([path '/' listing(l).name]);
                result_temp = printResult(result,resultF,bit,Type,ifdisp);
                exist = 1;
            end
        end
        
        if exist == 0
            switch Type
                case 'FAM'
                    % normalization:
                    % FFT and CM has increaseing integer bit to avoid
                    % overflow
                    [SxF,alphaoF,foF,resultF]=autofamFixedv3(x,fs,df,dalpha,bit);
                    [Sx,alphao,fo,result]=autofamv3(x,fs,df,dalpha,bit,resultF.Scale);
                case 'SSCA'
                    [SxF,alphaoF,foF,resultF]=autosscaFixedNormv3(x',fs,df,dalpha,bit);
                    [Sx,alphao,fo,result]=autosscaSingleNormv3(x',fs,df,dalpha,bit,resultF.Scale);
            end
            save([path '/' filename '.mat'],'bit','result','resultF');
            disp(['-----------' 'save' filename '-----------']);
            result_temp = printResult(result,resultF,bit,Type,ifdisp);
        end
        
        result_save.(['resultcell',num2str(index)]) = [result_save.(['resultcell',num2str(index)]);result_temp];
    end
end

save([path '/' fname Type 'Amp' num2str(Amp*100) 'saveresult' idxfile(4) '.mat'],'result_save');

%% Triangle

fname = 'Triangle'
result_save = {};
for index = 2:2
    disp(['---------------going to print DataSet' num2str(index) '----------------------------'])
    
    %---------------------Deepsig---------------------------------
    %     temp = load('/home/jingyi/Documents/Projects/FFT/Code/SCDsim/DeepSig.mat').a(index,:,:);
    %     temp=fi(single(temp)./single(max(temp)),1,16,15);
    %     x = temp(:,:,1)+temp(:,:,2)*1i;
    %     x = [x x];
    %---------------------Sine or Square---------------------------------
    t = (0:1/2240:1);
    x = fi(Amp*sawtooth(2*pi*200*t,1/2),1,16,15)';
    %         x = fi(0.98*sin(2*pi*200*t),1,16,15)';
    
    fs = 1000; df = 5; dalpha = 0.5; %df 5 10 2.5 dalpha 0.5 1 0.25
    
    %----------------------UnitBits from 8 to 20----------------------------------------
    result_save.(['resultcell',num2str(index)]) = {'bits_w','bits_F1','bits_CM','bits_F2', 'normsimulation', 'normcalculation','q1','q2','q3'};
    
    for i = 1:length(idx_result)
        
        bit.input = idx_result(i,1);
        bit.windowing = idx_result(i,1);
        bit.firstFFT = idx_result(i,2);
        bit.ConjMulti = idx_result(i,3);
        bit.secondFFT = idx_result(i,4);
        
        if 0<=index && index<10
            filename = [fname Type num2str(bit.windowing) num2str(bit.firstFFT) num2str(bit.ConjMulti) num2str(bit.secondFFT) 'Amp' num2str(100*Amp) 'Norm0' num2str(index) 'v3'];
        else
            filename = [fname Type num2str(bit.windowing) num2str(bit.firstFFT) num2str(bit.ConjMulti) num2str(bit.secondFFT) 'Amp' num2str(100*Amp) 'Norm' num2str(index) 'v3'];
        end
        
        
        listing = dir(path);
        exist = 0;
        for l = 3:length(listing)
            if strfind(listing(l).name, [filename '.mat'])
                load([path '/' listing(l).name]);
                result_temp = printResult(result,resultF,bit,Type,ifdisp);
                exist = 1;
            end
        end
        
        if exist == 0
            switch Type
                case 'FAM'
                    % normalization:
                    % FFT and CM has increaseing integer bit to avoid
                    % overflow
                    [SxF,alphaoF,foF,resultF]=autofamFixedv3(x,fs,df,dalpha,bit);
                    [Sx,alphao,fo,result]=autofamv3(x,fs,df,dalpha,bit,resultF.Scale);
                case 'SSCA'
                    [SxF,alphaoF,foF,resultF]=autosscaFixedNormv3(x',fs,df,dalpha,bit);
                    [Sx,alphao,fo,result]=autosscaSingleNormv3(x',fs,df,dalpha,bit,resultF.Scale);
            end
            save([path '/' filename '.mat'],'bit','result','resultF');
            disp(['-----------' 'save' filename '-----------']);
            result_temp = printResult(result,resultF,bit,Type,ifdisp);
        end
        
        result_save.(['resultcell',num2str(index)]) = [result_save.(['resultcell',num2str(index)]);result_temp];
    end
end

save([path '/' fname Type 'Amp' num2str(Amp*100) 'saveresult' idxfile(4) '.mat'],'result_save');

