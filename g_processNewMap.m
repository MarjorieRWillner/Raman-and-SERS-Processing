function [subLe,xvals,data_bc2,mapX, mapY,mapZ,mapXS , mapYS , mapZS, mapES,mapLayerZ] = g_processNewMap(txtr,mainpathSUB)

[nameStep,nameBase,nameXval] = g_EsubTxt(txtr);

mapX = 0;
mapY = 0;
mapZ = 0;
mapXS = 0;
mapYS = 0;
mapZS = 0;
mapES = 0;
subLe = [];
xvals = 0;
mapLayerZ = 0;
data_bc2 = 0; 


if isempty(nameStep{1,1}) == 0
    for mapLayerZ  = 1:length(nameStep)  %cycles through each level of the map
         %this opens the data file
        nameSou = cell2mat(strcat(mainpathSUB,'\',nameBase(mapLayerZ,1)))
        T = readtable(nameSou);
        data_bc2= table2array(T);
        
        %this opens the dimension files
        nameSteper = cell2mat(strcat(mainpathSUB,'\',nameStep(mapLayerZ,1)));
        TStep = readtable(nameSteper);
        mapX = TStep{1,1};
        mapY = TStep{1,2};
        mapZ = TStep{1,3};
        mapXS = TStep{1,4};
        mapYS = TStep{1,5};
        mapZS = TStep{1,6};
        mapES = TStep{1,7};
        
        %this opens the data file
        nameXV = cell2mat(strcat(mainpathSUB,'\',nameXval(mapLayerZ,1)));
        Ts = readtable(nameXV);
        xvals= table2array(Ts);
        
        subLe = mainpathSUB;
        mapLayerZ = '1';
    end
    
    
    
    
end
% [narargout] = {subLe,xvals,data_bc2,mapX, mapY,mapZ,mapXS , mapYS , mapZS, mapES}



end

