function [VLF,LF,HF,TA]=ASD_Function(data,fs)

    N=length(data);                     %%�źų���N
    RR=data*1000;                       %תΪΪ����
    
    y=fft(RR,N);                      %fftΪMATLAB�������ƣ�fft(tempdata,n)�Ǻ������÷�������Ҫ������ʱ�����У�ʱ�����еĲ����������ȣ�
    Y=2*abs(y)/N;                     %fft������ֵy��ģʹ�þ���ֵabs����
    f=fs*(0:N/2)/N;  %�������е�ʵ�ʲ���Ƶ�ʣ�����Ƶ����
                                        %Ƶ�ν����Ĺ������¶���
                                    
% avf=f(find(f>0.0&f<=0.04));         %������ͬ���ķ�������TP
ASD_VLF=Y(find(f>0.0033&f<=0.04));
VLF=sum(ASD_VLF)/length(ASD_VLF);
%     
% alf=f(find(f>0.04&f<0.15));         %������ͬ���ķ�������LF
ASD_LF=Y(find(f>0.04&f<0.15));
LF=sum(ASD_LF)/length(ASD_LF);

ASD_HF=Y(find(f>=0.15&f<=0.4)); 
HF=sum(ASD_HF)/length(ASD_HF);                  %����ֵΪHF

% atf=f(find(f>0.0&f<=0.4));          %������ͬ���ķ�������TP
ASD_TA=Y(find(f>0.0033&f<=0.4));
TA=sum(ASD_TA)/length(ASD_TA);

% Ratio=LF/HF;                        %LF/HF �ı�ֵ
% LFnu=LF/(TA-VLF);                    %��һ����LF
% HFnu=HF/(TA-VLF);                    %��һ����HF

end