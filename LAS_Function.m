function [VLF,LF,HF,TA,LFnu,HFnu,Ratio]=LAS_Function(data,fs)
    %%%%加入线性插值部分
    for i=1:length(data)
        data_sum(i)=sum(data(1:i));
    end                        
    Interp1_x=data(1):1/fs:sum(data);                    %2Hz   
    data_Interp1=interp1(data_sum,data,Interp1_x);                     %采用线性插值的方法得到重采样序列   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Sample_Fre=fs;                               %采样频率Sample_Frequency=2
    N=length(data_Interp1);                     %%信号长度N
    RR=data_Interp1*1000;                       %转为为毫秒
    
    y=fft(RR,N);                      %fft为MATLAB函数名称，fft(tempdata,n)是函数的用法：（所要分析的时间序列，时间序列的采样点数长度）
    Y=2*abs(y)/N;                     %fft后所得值y求模使用绝对值abs函数
    f=Sample_Fre*(0:N/2)/N;  %利用序列的实际采样频率，计算频率轴
                                        %频段交界点的归属重新定了
                                    
% avf=f(find(f>0.0&f<=0.04));         %与上述同样的方法计算TP
avp=Y(find(f>0.0&f<=0.04));
VLF=sum(avp);
%     
% alf=f(find(f>0.04&f<0.15));         %与上述同样的方法计算LF
alp=Y(find(f>0.04&f<0.15));
LF=sum(alp);

ahp=Y(find(f>=0.15&f<=0.4)); 
HF=sum(ahp);                  %积分值为HF

% atf=f(find(f>0.0&f<=0.4));          %与上述同样的方法计算TP
atp=Y(find(f>0.0&f<=0.4));
TA=sum(atp);

Ratio=LF/HF;                        %LF/HF 的比值
LFnu=LF/(TA-VLF);                    %归一化的LF
HFnu=HF/(TA-VLF);                    %归一化的HF

end