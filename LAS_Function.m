function [VLF,LF,HF,TA,LFnu,HFnu,Ratio]=LAS_Function(data,fs)
    %%%%�������Բ�ֵ����
    for i=1:length(data)
        data_sum(i)=sum(data(1:i));
    end                        
    Interp1_x=data(1):1/fs:sum(data);                    %2Hz   
    data_Interp1=interp1(data_sum,data,Interp1_x);                     %�������Բ�ֵ�ķ����õ��ز�������   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Sample_Fre=fs;                               %����Ƶ��Sample_Frequency=2
    N=length(data_Interp1);                     %%�źų���N
    RR=data_Interp1*1000;                       %תΪΪ����
    
    y=fft(RR,N);                      %fftΪMATLAB�������ƣ�fft(tempdata,n)�Ǻ������÷�������Ҫ������ʱ�����У�ʱ�����еĲ����������ȣ�
    Y=2*abs(y)/N;                     %fft������ֵy��ģʹ�þ���ֵabs����
    f=Sample_Fre*(0:N/2)/N;  %�������е�ʵ�ʲ���Ƶ�ʣ�����Ƶ����
                                        %Ƶ�ν����Ĺ������¶���
                                    
% avf=f(find(f>0.0&f<=0.04));         %������ͬ���ķ�������TP
avp=Y(find(f>0.0&f<=0.04));
VLF=sum(avp);
%     
% alf=f(find(f>0.04&f<0.15));         %������ͬ���ķ�������LF
alp=Y(find(f>0.04&f<0.15));
LF=sum(alp);

ahp=Y(find(f>=0.15&f<=0.4)); 
HF=sum(ahp);                  %����ֵΪHF

% atf=f(find(f>0.0&f<=0.4));          %������ͬ���ķ�������TP
atp=Y(find(f>0.0&f<=0.4));
TA=sum(atp);

Ratio=LF/HF;                        %LF/HF �ı�ֵ
LFnu=LF/(TA-VLF);                    %��һ����LF
HFnu=HF/(TA-VLF);                    %��һ����HF

end