%%%%pH calculation 1710 over 1084

function [daRealpH,pHpare] = g_RatioTransform(pH_ratio)

[pX pY] = size(pH_ratio);
daRealpH= zeros(pX,1);
pHpare= zeros(pX,1);


A2  = 0.387;
A3 = -0.385;
x0  = 11.024;
dx  = 2.407;

pH_Rcounter = 1;
    for phrc =1:pX
        term1_p = A3/(pH_ratio(phrc,1)-A2);
        term2_p = term1_p-1;
        if term2_p > 0
            term3_p = log10(term2_p);
            term4_p = term3_p*dx+x0;
            daRealpH(pH_Rcounter, 1) = term4_p;
            pHpare(pH_Rcounter, 1) = 1;
        else
            daRealpH(pH_Rcounter, 1) = 0;
            pHpare(pH_Rcounter, 1) = 0;
        end
        pH_Rcounter = pH_Rcounter+1;
    end
end