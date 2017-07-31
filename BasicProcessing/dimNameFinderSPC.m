function [narargout] =   dimNameFinderSPC(heroDance,savstring,varargin1)

locA =cell(10,8);
vet1 = [];
avag = varargin1;
[ccc , ~] = size(avag);

for nnb=1:(ccc-1)
    
    abb = avag(nnb,1);
    c = abb;
    
    locA(nnb,1) = abb;
    locA{nnb,2} = strfind(heroDance, c); %position of varaible in heroDance string
    locA{nnb,4} = strfind(savstring, c); %position of varaible in savstring string
end
%
%     mapXH = 0;
%     mapYH = 0;
%     mapZH = 0;
%     mapXS = 0;
%     mapYS = 0;
%     mapZS = 0;
%
g3= 1;

[~, HcolINs] = size(locA{7,2});
[~, ScolINs] = size(locA{7,4});

for aabb3=1:2
    
    %get value from file metaData
    if ~isempty(locA{aabb3,2})&& (g3<=HcolINs) && ~isempty(locA{7,2}(1,g3))
        locA{aabb3,3} = str2double(heroDance((locA{aabb3,2}+2):((locA{7,2}(1,g3))-1)));
    else
        locA{aabb3,3} = 1;
    end
    
    %get value from file name
    if ~isempty(locA{aabb3,4}) && (g3<=ScolINs)&& ~isempty(locA{7,4})
        locA{aabb3,5} = str2double(savstring((locA{aabb3,4}+2):((locA{7,4}(1,g3))-1)));
    else
        locA{aabb3,5} = 1;
    end
   
    %now compare the two values that were found
    if(locA{aabb3,3} == locA{aabb3,5}); %if the two values are equal
        locA{aabb3,6} = locA{aabb3,3};
        locA{aabb3,7} = 1;
    elseif locA{aabb3,3} == 1 %if metadata had no value
        locA{aabb3,6} = locA{aabb3,5};
        locA{aabb3,7} = 1;
    elseif locA{aabb3,5} == 1 %if file name had no value
        locA{aabb3,6} = locA{aabb3,3};
        locA{aabb3,7} = 1;
    else
        locA{aabb3,7} = 0;
   end
    
    g3 = g3+1;
end


%get z values


if ~isempty(locA{3,2}) && ~isempty((locA{8,2}))
    
    if isnan(str2double(heroDance((locA{3,2}(1,1)+2):((locA{8,2}(1,1))-1)))) == 0
        locA{3,3} = str2double(heroDance((locA{3,2}(1,1)+2):((locA{8,2}(1,1))-1)));
    else
        locA{3,3} = 1;
    end
elseif ~isempty(locA{3,2})
    if ((locA{3,2}(1,1)+3) <= length(heroDance))
        locA{3,3} = str2double(heroDance((locA{3,2}(1,1)+2):(locA{3,2}(1,1)+3)));
    else
        locA{3,3} = str2double(heroDance((locA{3,2}(1,1)+2)));
    end
else
    locA{3,3} =1;
end

if ~isempty(locA{3,4}) && ~isempty((locA{8,4}))
    locA{3,5} = str2double(savstring((locA{3,4}+2):((locA{8,4}(1,1))-1)));
else
    locA{3,5} =1;
end


if(locA{3,3} == locA{3,5}) %if the two values are equal
    locA{3,6} = locA{3,3};
    locA{3,7} = 1;
else %if the two values are not equal
    if locA{3,3} == 1
        locA{3,6} = locA{3,5};
        locA{3,7} = 0;
    else  %if locA{aabb3,5} == 0
        locA{3,6} = locA{3,3};
        locA{3,7} = 0;
    end
end


%otherthings
g4= 2;

[~, HPounds] = size(locA{8,2});
% [~, SPounds] = size(locA{8,4});


for aabb4=[4,5,6,10]
    
%     g4
    
    %get other values first from HeroDance
    if ~isempty(locA{aabb4,2}) && ~isempty((locA{8,2})) && HPounds > g4
        heroDance((locA{aabb4,2}+3):((locA{8,2}(1,g4))-1))
        locA{aabb4,3} = str2double(heroDance((locA{aabb4,2}+3):((locA{8,2}(1,g4))-1)));
    else
        locA{aabb4,3} = 0; %sets value as 0 if the term isnt in the Scandetails
    end
    
    %getvalues from File name
    if ~isempty(locA{aabb4,4}) && ~isempty((locA{8,4})) && length(savstring) > (locA{aabb4,4}+3)
        savstring((locA{aabb4,4}+3):((locA{8,4}(1,g4))-1))
        locA{aabb4,5} = str2double(savstring((locA{aabb4,4}+3):((locA{8,4}(1,g4))-1)));
    elseif ~isempty(locA{aabb4,5})
        %locA{aabb4,5} = 0;
        locA{aabb4,5} = str2double(savstring((locA{aabb4,4}+3):((locA{8,4}(1,g4))-1)));
    else
        locA{aabb4,5} = 0;
    end
    
    if(locA{aabb4,3} == locA{aabb4,5}) %if the values are equal
        locA{aabb4,6} = locA{aabb4,3};
        locA{aabb4,7} =1;
        locA{aabb4,8} = locA{aabb4,5} ;
    elseif (locA{aabb4,3} == 0 && locA{aabb4,5} > 0 ) %if the value is only in file
        locA{aabb4,6} = locA{aabb4,5};
        locA{aabb4,7} =1;
        locA{aabb4,8} = locA{aabb4,5} ;
    elseif (locA{aabb4,3} > 0 && locA{aabb4,5} == 0 ) %if the value is only in Scan
        locA{aabb4,6} = locA{aabb4,5};
        locA{aabb4,7} =1;
        locA{aabb4,8} = locA{aabb4,5} ;
    else %if the value is only in the fileName
        locA{aabb4,6} = locA{aabb4,3};
        locA{aabb4,7} =1;
        locA{aabb4,8} = locA{aabb4,3} ;
    end
    g4 = g4+1;
end

pTotes = cell2mat(varargin1(ccc));

    %estimate pixels from scan name
    mapXTH = cell2mat(locA(1,3));
    mapYTH= cell2mat(locA(2,3));
    mapZTH = cell2mat (locA(3,3));
    
    %estimated pixels from file name
    mapXTS = cell2mat(locA(1,5));
    mapYTS= cell2mat(locA(2,5));
    mapZTS = cell2mat (locA(3,5));

    %estimated pixels based on comparing the scan name and file name
    mapXTZ = cell2mat(locA(1,6));
    mapYTZ= cell2mat(locA(2,6));
    mapZTZ = cell2mat (locA(3,6));
    
    %total number of points
    pntTTH=(mapXTH*mapYTH*mapZTH);
    pntTTS=(mapXTS*mapYTS*mapZTS);
    pntTTZ=(mapXTZ*mapYTZ*mapZTZ);

    ontTT = pTotes;
    
    if mod(pTotes,pntTTZ) == 0 %check if the estimated map dimensions were correct
        locA{1,8} = locA{1,6};
        locA{2,8} = locA{2,6};
        locA{3,8} = locA{3,6};
    elseif mod(pTotes,pntTTS) == 0 && pntTTS >1 %check if the filename map dimensions were correct
        locA{1,8} = locA{1,5};
        locA{2,8} = locA{2,5};
        locA{3,8} = locA{3,5};
    elseif mod(pTotes,pntTTH) == 0 && pntTTH >1 %check if the scan title map dimensions were correct
        locA{1,8} = locA{1,3};
        locA{2,8} = locA{2,3};
        locA{3,8} = locA{3,3};
          
    elseif cell2mat(locA(1,7)) == 1  && cell2mat(locA(2,7)) == 1
%         locA{3,8} = pTotes/(locA{1,6}*locA{2,6})
   else
       flexT =1;
        flex2 = 1;
        for nT =1 : 3
            if cell2mat(locA(nT,7)) == 0
                vet1(flexT) = nT;
                flexT = flexT+1;
            else
                locA(nT,8) = locA(nT,5);
%                 vet2(flex2) =ontTT/cell2mat(locA(nT,5));
                flex2 =flex2+1;
                %locA(nT,8) = ontTT;
            end
        end
        
%         vet2
         locA{vet1,8} = ontTT;
        
%         if length(vet1) > 1
%             for nTT=1:length(vet1)
%                 if cell2mat(locA(vet1(nTT),3)) == ontTT
%                     locA{vet1,8} = ontTT
%                 elseif cell2mat(locA(vet1(nTT),5)) == ontTT
%                     locA{vet1,8} = ontTT
%                 end
%                 
%             end
%         end
    end
    
    
    

%      %get y values
%     locA{2,3} = str2double(heroDance((locA{2,2}+2):((locA{7,2}(1,2))-1)))
%     locA{2,5} = str2double(savstring((locA{2,4}+2):((locA{7,4}(1,2))-1)))
%
%     if(locA{2,3} == locA{2,5})
%         locA{2,6} = locA{2,3}
%     elseif (isempty(locA{2,3}) == 1)
%         locA{2,6} = locA{2,5}
%     else
%         locA{2,6} = locA{2,3}
%     end
%


%      %get z values
%
%     locA{3,3} = str2double(heroDance((locA{3,2}(1,1)+2):((locA{8,2}(1,1))-1)))
%     locA{3,5} = str2double(savstring((locA{3,4}+2):((locA{8,4}(1,1))-1)))
%
%     if(locA{3,3} == locA{3,5})
%         locA{3,6} = locA{3,3}
%     elseif (isempty(locA{3,3}) == 1)
%         locA{3,6} = locA{3,5}
%     else
%         locA{3,6} = locA{3,3}
%     end

locB = locA;

iscell(locB);
narargout = locB;



end
