function [rg] = fwhmThing(pk1,hh_pk1,numTop,xk1)

y =pk1(hh_pk1,:);
h = numTop/2;
idx1=find(y>h,1) +[-1 0];
idx2=find(y>h,1,'last') +[0 1];

if idx1(1,1) == 0
    idx1 = [1,2];
end

x1 = interp1(y(idx1),xk1(idx1),h);

if isnan(x1) == 0
    if idx2(1,2) < length(y)
        x2 = interp1(y(idx2),xk1(idx2),h);
        w3 = x2 - x1;
    else
        w3 =0;
    end
else
    w3 =0;
end

rg(dra,iTer) =w3;
end
