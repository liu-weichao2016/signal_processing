function [VLF,LF,HF,TP]=PSD_Function(data,fs)


    Sample_Fre=fs;                               
    N=length(data);                             
    data=data*1000;                      
    
    [Power,f]=periodogram(data,[],'onesided',N,Sample_Fre);   
    
%     y=fft(data_Interp1,N);                     
%     Y=2*abs(y)/N;                     
%     f=Sample_Fre*(0:N/2)/N;  
                                        
 
    VLF_fre = f(find(f>0.0033&f<=0.04));                                       
    VLF_Power= Power(find(f>0.0033&f<=0.04));   
    VLF = trapz(VLF_fre,VLF_Power);
    
    LF_fre = f(find(f>0.04&f<0.15));         
    LF_Power = Power(find(f>0.04&f<0.15));
    LF = trapz(LF_fre,LF_Power);
    
    HF_fre = f(find(f>=0.15&f<=0.4));
    HF_Power = Power(find(f>=0.15&f<=0.4)); 
    HF = trapz(HF_fre,HF_Power);                  
    
    TF_fre = f(find(f>0.0033&f<=0.4));
    TF_Power = Power(find(f>0.0033&f<=0.4));    
    TP = trapz(TF_fre,TF_Power);                


end
