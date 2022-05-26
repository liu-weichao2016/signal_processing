function [VLF,LF,HF,TA]=ASD_Function(data,fs)

    N=length(data);                     
    RR=data*1000;                       
    
    y=fft(RR,N);                      
    Y=2*abs(y)/N;                     
    f=fs*(0:N/2)/N;  
                                       
                                    
% avf=f(find(f>0.0&f<=0.04));         
ASD_VLF=Y(find(f>0.0033&f<=0.04));
VLF=sum(ASD_VLF)/length(ASD_VLF);
%     
% alf=f(find(f>0.04&f<0.15));         
ASD_LF=Y(find(f>0.04&f<0.15));
LF=sum(ASD_LF)/length(ASD_LF);

ASD_HF=Y(find(f>=0.15&f<=0.4)); 
HF=sum(ASD_HF)/length(ASD_HF);                  

% atf=f(find(f>0.0&f<=0.4));          
ASD_TA=Y(find(f>0.0033&f<=0.4));
TA=sum(ASD_TA)/length(ASD_TA);

% Ratio=LF/HF;                        
% LFnu=LF/(TA-VLF);                    
% HFnu=HF/(TA-VLF);                    

end
