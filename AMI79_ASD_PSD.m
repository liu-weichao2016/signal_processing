clc,clear
close all
%------ SPECIFY DATA ------------------------------------------------------
Input_PATH= 'E:\Papers\Writing\LAS_HRV_MI\NewProcess\data\AMI79-3days\'; % path, where data are saved
SAMPLES2READ=600000;

Num=0;
fs=2;
tic
n = 30;
%%%%%%%%%%%%%%%%%%%%%  LOAD Format16 DATA   %%%%%%%%%%%%%%
signald= fullfile(Input_PATH,strcat(num2str(n),'.dat'));            
fid=fopen(signald,'r');
data= fread(fid, [15,SAMPLES2READ], 'int16')'; 
fclose(fid);
ECG_Rawdata = -1*data(2:end,5);            
clear signald fid data
%%%%%%%%%%%%%%%%%%%%%   Lowpass filtering and R-wave detection     %%%%%%%%%%%%%%
Hd=LP_FIR;
data_filter= filter(Hd,ECG_Rawdata);
figure(1)
plot(data_filter)
hold on

% Data_R=pan_tompkin(data_filter,1000);  %%R-wave detection by by a real-time QRS detection algorithm proposed by Pan Jiapu and W.J. Tompkins
[pks,Data_R]=findpeaks(data_filter,'MinPeakHeight',-1000,'MinPeakDistance',300,'MinPeakProminence',200 ,'MinPeakWidth',30);
% [pks,Data_R]=findpeaks(data_filter,'MinPeakHeight',40,'MinPeakDistance',500);
%,'MinPeakProminence',50  ,'MaxPeakWidth',30
for m=1:length(Data_R)-1
    Data1_RR(m)=Data_R(m+1)-Data_R(m);
end
Data_RR = Data1_RR'/1000;%% transfer RR to s 
scatter(Data_R,data_filter(Data_R));
            
clear Data_R Data1_RR
%%%%%%%%%%%%%%%%%%%%% sequence resampling  by linear interpolation   %%%%%%%%%%%%%% 
L_RR = length(Data_RR);     %%Non-zero length
Data_RR = Data_RR(1:L_RR);
for i=1:length(Data_RR)
    data_sum(i)=sum(Data_RR(1:i));
end                        
Interp=Data_RR(1):1/fs:sum(Data_RR);                    
RR_Interp=interp1(data_sum,Data_RR,Interp)'; % resampling sequence by linear interpolation
clear L_RR data_sum Interp
toc

% RR_InterpData(:,Deficiency)=[];
% RR_InterpData1 = RR_InterpData(:,104:155);
%%%%%%%%%%%%%%%%%%%%%  ASD and PSD   %%%%%%%%%%%%%%
% L = 181;    %% the same minimum length
% for n=1:79
%     RR = RR_InterpData1(1:L,n);
%     
%     [ASD_VLF,ASD_LF,ASD_HF,ASD_TA]=ASD_Function(RR,fs);
%     [PSD_VLF,PSD_LF,PSD_HF,PSD_TP]=PSD_Function(RR,fs);
%     
%     ASD_Para(n,1) = ASD_VLF; 
%     ASD_Para(n,2) = ASD_LF;     
%     ASD_Para(n,3) = ASD_HF; 
%     ASD_Para(n,4) = ASD_TA; 
%     
%     PSD_Para(n,1) = PSD_VLF; 
%     PSD_Para(n,2) = PSD_LF;     
%     PSD_Para(n,3) = PSD_HF; 
%     PSD_Para(n,4) = PSD_TP;     
%    
% end
% clear n RR ASD_VLF ASD_LF ASD_HF ASD_TA
% clear PSD_VLF PSD_LF PSD_HF PSD_TP
% toc

% Data_LAS(Deficiency,:)=[];
% Data_PSD(Deficiency,:)=[];

% xlswrite('C:\Users\Liu Weichao\Desktop\PTB database\Result\MI_Before\Data_LAS_MI_Before_Cath.xls', Data_LAS);
% xlswrite('C:\Users\Liu Weichao\Desktop\PTB database\Result\MI_Before\Data_PSD_MI_Before_Cath.xls', Data_PSD);
% xlswrite('C:\Users\Liu Weichao\Desktop\PTB database\Result\MI_Before\RR_Data_MI_Before_Cath.xls', RR_Data_MI_Before_Cath);
