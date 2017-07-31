%This fuction situates the data on the proper axis
%function to search for the index of a given wavelength
function ind = correct_axisSPC(mrw, xvals)

% returns the index of a given peak point
[msp,~]=size(xvals); 

AA = zeros(msp-3,0);

for i=3:msp-1
        diff =  abs(xvals(i+1)-mrw);
        AA(i-2,1) = abs(diff); % Matrix listing the distance from the point of interest 
end
    
    [M,I] = min(AA);
    
    ind = I +3;
    
end
