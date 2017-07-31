function   [grouplet2] = g_mapDets(scaDrak, iHon, iTer,HWC,mainpathSUB,varargin352,ratTransform);


scnProc =1;
[drakX, drakY] = size(scaDrak);

for iNight=1: drakX
    if iHon > iTer % if we are looking at a ratio, this will always have a top value
        if iNight == drakX &&  ratTransform ==1
            grouplet2{scnProc,1} = strcat(mainpathSUB,'Maps\',num2str(varargin352{iHon,2}),'\',num2str(scaDrak{iNight,2}));
            grouplet2{scnProc,2} = ['Transformation of Peak: ',num2str(varargin352{iHon,2}),' Range:', num2str(scaDrak{iNight,2}), ' to ',num2str(scaDrak{iNight,1})];
            
        elseif iNight ==1
            grouplet2{scnProc,1} = strcat(mainpathSUB,'Maps\',num2str(varargin352{iHon,2}),'\2Xmean');
            grouplet2{scnProc,2} = ['Peak: ',num2str(varargin352{iHon,2}),' Range:', num2str(scaDrak{iNight,2}), ' to ',num2str(scaDrak{iNight,1})];
            
        else
            
            grouplet2{scnProc,1} = strcat(mainpathSUB,'Maps\',num2str(varargin352{iHon,2}),'\',num2str(scaDrak{iNight,2}));
            grouplet2{scnProc,2} = ['Peak: ',num2str(varargin352{iHon,2}),' Range:', num2str(scaDrak{iNight,2}), ' to ',num2str(scaDrak{iNight,1})];
            
        end
        
        grouplet2{scnProc,3} = scaDrak{iNight,1};
        grouplet2{scnProc,4} = scaDrak{iNight,2};
        grouplet2{scnProc,5} = HWC;
        scnProc = scnProc+1;
        
    elseif scaDrak{iNight,3} == 1 %if we have bounds for a peak
        grouplet2{scnProc,1} = strcat(mainpathSUB,'Maps\',num2str(varargin352{iHon,2})); %,'\',num2str(lowB));
        grouplet2{scnProc,2} = ['Peak: ',num2str(varargin352{iHon,2}),' Range:', num2str(scaDrak{iNight,2}), ' to ',num2str(scaDrak{iNight,1})];
        grouplet2{scnProc,3} = scaDrak{iNight,1};
        grouplet2{scnProc,4} = scaDrak{iNight,2};
        grouplet2{scnProc,5} = HWC;
        scnProc = scnProc+1;
        
    else %if there are no upper bounds
        grouplet2{scnProc,1} = strcat(mainpathSUB,'Maps\',num2str(varargin352{iHon,2}));
        grouplet2{scnProc,2} = ['Peak: ',num2str(varargin352{iHon,2})];
        grouplet2{scnProc,5} = 1;
        scnProc = scnProc+1;
    end
    
end
end