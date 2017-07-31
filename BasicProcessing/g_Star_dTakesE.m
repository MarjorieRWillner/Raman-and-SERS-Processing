function [] = g_Star_dTakesE(mainpathSUB,reTakw,mp,D_Takes,savstring)
bDtakes = strcat(mainpathSUB,'\Z_SummaryofMaps_',savstring,'_',reTakw,'_',(mp) ,'_.csv');
bDtakesTxT = strcat(mainpathSUB,'\Z_SummaryofMaps_',savstring,'_',reTakw,'_',(mp) ,'_.txt');
hDtakes= cell2table(D_Takes);
hDtakes.Properties.VariableNames{'D_Takes1'} = 'Name';
hDtakes.Properties.VariableNames{'D_Takes2'} = 'PeakOfInterest';
hDtakes.Properties.VariableNames{'D_Takes3'} = 'X_Points';
hDtakes.Properties.VariableNames{'D_Takes4'} = 'Y_Points';
hDtakes.Properties.VariableNames{'D_Takes5'} = 'Z_Points';
hDtakes.Properties.VariableNames{'D_Takes6'} = 'X_StepSize';
hDtakes.Properties.VariableNames{'D_Takes7'} = 'Y_StepSize';
hDtakes.Properties.VariableNames{'D_Takes8'} = 'Z_StepSize';
hDtakes.Properties.VariableNames{'D_Takes9'} = 'CollectionTime';
hDtakes.Properties.VariableNames{'D_Takes10'} = 'TotalMapIntensity';
hDtakes.Properties.VariableNames{'D_Takes11'} = 'Mean_Intensity';
hDtakes.Properties.VariableNames{'D_Takes12'} = 'Min_Intensity';
hDtakes.Properties.VariableNames{'D_Takes13'} = 'Max_Intensity';
hDtakes.Properties.VariableNames{'D_Takes14'} = 'StdDev';
hDtakes.Properties.VariableNames{'D_Takes15'} = 'CoeffVar';
hDtakes.Properties.VariableNames{'D_Takes16'} = 'IntDensity';
% hDtakes.Properties.VariableNames{'C_Takes117'} = 'folder';
writetable(hDtakes,bDtakes,'Delimiter',',');
writetable(hDtakes,bDtakesTxT);
end
