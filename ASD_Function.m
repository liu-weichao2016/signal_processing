function [VLF,LF,HF,TA]=ASD_Function(data,fs)

    N=length(data);                     %%信号长度N
    RR=data*1000;                       %转为为毫秒
    
    y=fft(RR,N);                      %fft为MATLAB函数名称，fft(tempdata,n)是函数的用法：（所要分析的时间序列，时间序列的采样点数长度）
    Y=2*abs(y)/N;                     %fft后所得值y求模使用绝对值abs函数
    f=fs*(0:N/2)/N;  %利用序列的实际采样频率，计算频率轴
                                        %频段交界点的归属重新定了
                                    
% avf=f(find(f>0.0&f<=0.04));         %与上述同样的方法计算TP
ASD_VLF=Y(find(f>0.0033&f<=0.04));
VLF=sum(ASD_VLF)/length(ASD_VLF);
%     
% alf=f(find(f>0.04&f<0.15));         %与上述同样的方法计算LF
ASD_LF=Y(find(f>0.04&f<0.15));
LF=sum(ASD_LF)/length(ASD_LF);

ASD_HF=Y(find(f>=0.15&f<=0.4)); 
HF=sum(ASD_HF)/length(ASD_HF);                  %积分值为HF

% atf=f(find(f>0.0&f<=0.4));          %与上述同样的方法计算TP
ASD_TA=Y(find(f>0.0033&f<=0.4));
TA=sum(ASD_TA)/length(ASD_TA);

% Ratio=LF/HF;                        %LF/HF 的比值
% LFnu=LF/(TA-VLF);                    %归一化的LF
% HFnu=HF/(TA-VLF);                    %归一化的HF

end