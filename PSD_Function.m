function [VLF,LF,HF,TP]=PSD_Function(data,fs)


    Sample_Fre=fs;                               %采样频率Sample_Frequency=2
    N=length(data);                               %%信号长度N
    data=data*1000;                       %转为为毫秒
    
    [Power,f]=periodogram(data,[],'onesided',N,Sample_Fre);%周期图法计算功率谱    
    
%     y=fft(data_Interp1,N);                      %fft为MATLAB函数名称，fft(tempdata,n)是函数的用法：（所要分析的时间序列，时间序列的采样点数长度）
%     Y=2*abs(y)/N;                     %fft后所得值y求模使用绝对值abs函数
%     f=Sample_Fre*(0:N/2)/N;  %利用序列的实际采样频率，计算频率轴
                                        %频段交界点的归属重新定了
 
    VLF_fre = f(find(f>0.0033&f<=0.04));                                       
    VLF_Power= Power(find(f>0.0033&f<=0.04));   
    VLF = trapz(VLF_fre,VLF_Power);
    
    LF_fre = f(find(f>0.04&f<0.15));         %与上述同样的方法计算LF
    LF_Power = Power(find(f>0.04&f<0.15));
    LF = trapz(LF_fre,LF_Power);
    
    HF_fre = f(find(f>=0.15&f<=0.4));
    HF_Power = Power(find(f>=0.15&f<=0.4)); 
    HF = trapz(HF_fre,HF_Power);                  %积分值为HF
    
    TF_fre = f(find(f>0.0033&f<=0.4));
    TF_Power = Power(find(f>0.0033&f<=0.4));    
    TP = trapz(TF_fre,TF_Power);                  %积分值为HF


end