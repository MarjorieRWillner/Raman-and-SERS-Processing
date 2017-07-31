function [scaDrak] = g_mapBOunds (lowBJump,mapJuman2)
    ct4301 =1;

    for ijumpmaB =1: length(lowBJump)

        for ijumpma =1: length(mapJuman2)
            scaDrak{ct4301,1} = str2double(lowBJump{ijumpmaB})
            scaDrak{ct4301,2} = str2double(mapJuman2{ijumpma})

            if isempty(mapJuman2{ijumpma}) == 1 %see if there is an assigned upper bound
                scaDrak{ct4301,3} = 0; %if no upper bound assign 0
%             elseif lowBJump{ijumpmaB} == (mapJuman2{ijumpma}) || lowBJump{ijumpmaB} > (mapJuman2{ijumpma})
%                 scaDrak{ct4301,3} = 0; %if no upper bound assign 0
            else 
               scaDrak{ct4301,3} = 1; %if upper bound assign
            end
            ct4301 = ct4301+1;
        end
    end
end