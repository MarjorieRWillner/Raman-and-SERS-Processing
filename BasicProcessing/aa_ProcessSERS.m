% Author: Marjorie R. Willner
% Version: MATLAB R2016a
% Last modified: 8/2/17
% Copyright 2017 by Marjorie R. Willner
%--------------------------------------------------------------------------





dirName = uigetdir('C:\Users\Marjorie\Desktop\PBAT50-try2');


mp = ''; %'3. Peak of Interest (Amended to file Title)'
nOrmval = 1; %'4.Value to Normalize with'
equiSize = 0; %'5.Should the map be a certain size ? 0 = no, 1 =yes'
padView = 50; %'6.Minmium number of pixels in a square map. Maps bigger than this value will not be trimmed'
reTakw = 'G3'; % '7.Additional Term for File name'
peakOF =1; % how should we find max? 1= pick out mp and 0 = let program find max y

TyWin ={1593,1640,1611;2800,3000,2924}; %list the peaks to look at i {ROI1;ROI2;...}
                            % with ROI in the order lower bound, upperbound, peak of interst 
HW_ratip = 1;  %'15.Do we want to find a ratio between two peaks (ROI 1/ROI2)? 0 = no; 1 = yes'



mapJuman = '6,70'; %'8.Upper bound of map Scale Bar must be text
mapJuman25 = '10'; %'8.Upper bound of map Scale Bar for ratio
savRR =1; %'9.Should the maps be saved? 0 = no; 1 = yes'
HW = 0 ; %'10.Do you want to use predefined XY values? 0 = no; 1 = yes'
HW_x = 1; % '11.Dimenstions of X?'
HW_y = 1; % '12.Dimenstions of Y?'
HWC = 0;  %'13.Map coloring: 0=hot color with scale, 1= jet no scale, 2 = jet scale with scale'
HWC_mean  =1; % '14.Should the scale be based on 2X the mean 0 = no and 1 = yes'
baseMas = 1; %'18.Should the data be baseline corrected?:'
baseStart = 0; %'19.Where should the baselinecorrection start:'
baseBaseANdNP = 0; %Do we want to compare a baseline corrected peak and a non baselined peak?
lowBJump = '0';
lowBJump = (regexp(lowBJump,',','split'));

A_Takes = [] ; %azeros(10,4);
cnt_A_Takes = 1;
B_Takes =[];
C_Takes =[];
cnt_D_Takes = 1;
D_Takes =cell(3,16);
hert=cell(1);
mainpathSUB2 = {};
ylab = ('Counts (abr.)');
xlab = 'Raman Shift (1/cm)';
viAble = 0; %Should the maps pop up on the screen? 0 = no and 1 = yes
ratTransform = 1; %are we transforming the ratio - i.e. pH? 0 =no and 1 = yes
ratRangTop{1,1} = '14';
ratRangBot{1,1} = '0';
makemaps = 1; %should we make maps 1= yes and 0 = no
fwhmAsh = 0; %should we calculate fwhm 1=yes and 0 = no
subLet = 0;
mapJuman = regexp(mapJuman,',','split')

%Processing Data for First Time
tt= flashlight(dirName,'FileFilter', '\.spc$');
tt_file=flashlight(dirName, 'FileFilter', '\.spc$', ...
    'PrependPath', false);





for gunit =1: length(tt) %20
    
    mp = '';
    searchphrase = tt_file{gunit,1};
    mainpathSUB= tt{gunit,1}(1:end-length(searchphrase));
    
    if isempty(mainpathSUB2) == 1
        mainpathSUB2 = mainpathSUB;
        movFold  = 1;
        gez=gunit;
    end
    
    if isempty(mainpathSUB2) == 0  && (strcmp(mainpathSUB,mainpathSUB2) == 0)
        yetty = strcat('all_', searchphrase);
        g_Star_dTakesE(mainpathSUB2,reTakw,mp,D_Takes(gez:(gunit-1),:), yetty);
        
        mainpathSUB2 = mainpathSUB;
        gez = gunit;
    end
    
    
    heroDance = {}; %#ok<*NASGU>
    
    jump = dirName;
    [yvals,xvals,savstring,map,txtrr_IMG,mapX, mapY,mapZ,mapXS , mapYS , mapZS, heroDance, mapES ] = getdata_fileSPC(searchphrase,mainpathSUB); %gets the data that corresponds to the spectra of interest
    xvalsWale = xvals;
    if HW ==1
        mapX = HW_x;
        mapY = HW_y ;
        mapZ = 1 ;
    end
    
    if isnan(mapZ) == 1 || mapZ > 5
        mapZ =1;
    end
    
    
    [xResh, yResh]= size(yvals);
    pnts = (mapY*mapX*mapZ);
    cntp =1;
    
    if isempty(pnts) == 1
        
        
        vaHert= {dirName,searchphrase,mainpathSUB,yResh,heroDance,savstring};
        
        for iHe=1:length (vaHert)
            hert{cntp,iHe} = vaHert{iHe};
        end
        
        newDimo = g_handDimen(savstring,heroDance, yResh);
        
        mapX = str2double(newDimo{1});
        mapY = str2double(newDimo{2});
        mapZ = str2double(newDimo{3});
        pnts = (mapY*mapX*mapZ);
        
    end
    
    
    if yResh/(mapY*mapX*mapZ) > 1
        newCh = g_handDimen(savstring,heroDance, yResh);
        mapX = str2double(newCh{1});
        mapY = str2double(newCh{2});
        mapZ = str2double(newCh{3});
        pnts = (mapY*mapX*mapZ);
    end
    
    
    if mod(yResh,pnts) <= 1
        
        break_Raw = reshape(yvals,xResh,mapY,mapX,mapZ); %reshape data into map fromat.
        
        if length(savstring) > 25
            savstring = savstring(1:25);
            
        end
        
        %make sub folder for results
        newfolder_name = strcat(savstring,'_Processed Data_');
        mkdir(mainpathSUB,newfolder_name)
        subLe = strcat(mainpathSUB,newfolder_name);
        
        %savstring = strcat (savstring ,'_', (mp));
        
        %define if the map is in the XY or XZ direction
        if mapY == 1
            mapLayerZ = 1;
        else
            mapLayerZ = mapZ;
        end
        
        for ijp=1:mapLayerZ %step through every XY layer in the map
            
            levelNam = num2str(ijp);
            
            bSTEP = strcat(subLe,'\',savstring,'_',levelNam,'_step.txt');
            steppers = strcat(mat2str(mapX),';',mat2str(mapY),';',mat2str(mapZ),';',mat2str(mapXS),';',mat2str(mapYS),';',mat2str(mapZS),';',mat2str(mapES));
            heroDance13 = cell2table(cellstr(steppers));
            writetable(heroDance13,bSTEP)
            
            
            if mapY ~= 1
                break1 = break_Raw(:,:,:,ijp);
                break2 = reshape(break1,xResh,mapX*mapY);
                de2 = mapY;
            else
                break4 = break_Raw(:,1,:,:);
                break2 = reshape(break4,xResh,mapX*mapZ);
                de2 = mapZ;
            end
            
            mp = '';
            %%%%Raw Data
            xbot = min(xvals);
            xtop = max(xvals);
            g_makeFig(xvals,break2,'Raw',[xbot, xtop], [], xlab,ylab,viAble, savRR,mp, subLe,savstring,reTakw,levelNam,'__A_Raw2.bmp')
            
            [spec, numofSpec] = size(break2);
            
            nJz= numofSpec;
            dataSPC2 = break2';
            
            
            
            vargin = {};
            
            
            xvals333333=xvals;
            if baseMas == 1 %should everything be baseline corrected
                baseStartPlace= correct_axisSPC(baseStart, xvals);
                [xbc, ybc] = size(dataSPC2);
                baseRange = dataSPC2(:,baseStartPlace:ybc); %new matrix of data
                xvalsBase = xvals(baseStartPlace:ybc);
                
                g_makeFig(xvalsBase,baseRange','Region to be Baselined',[baseStart, xtop], [], xlab,ylab,viAble, savRR,mp, subLe,savstring,reTakw,levelNam,'__BA_RegionToBAseline.bmp')
                
                [xbc2, ybc2] = size(baseRange); % size of new matrix - x is number of spectra collected, y is the length of each spectra
                
                data_bc46(xbc2,ybc2) = zeros; %#ok<*SAGROW>
                for i=1:nJz %go through all spectra and baseline correct
                    data_bc46(i,:)=asysm(baseRange(i,:)',1e6,1e-2,2)';
                end
                data_bc2=baseRange-data_bc46; %create new array with baseline corrected values
                
                
                %%Graph of BaselineCorrected
                g_makeFig(xvalsBase,data_bc2','Baseline Corrected',[baseStart, xtop], [], xlab,ylab,viAble, savRR,mp, subLe,savstring,reTakw,levelNam,'__BB_BaselineCorrected.bmp')
                
%                 jMarjorie = [jMarjorie, data_bc2'];
                
                
                
                %save the x values of the spectra
                xVALData = strcat(subLe,'\',savstring,'_',reTakw,'_',levelNam,'_ xVAL.txt');
                data_xVAL = array2table(xvalsBase);
                writetable(data_xVAL,xVALData);
                
                %save the baseline data so dont have recalculate every time
                baseLINEData = strcat(subLe,'\',savstring,'_',reTakw,'_',levelNam,'_baselIned_start_',num2str(baseStart),'.txt');
                data_bc2T = array2table(data_bc2);
                writetable(data_bc2T,baseLINEData)
                
                if baseBaseANdNP ==1
                    baseNoRange = dataSPC2(:,1:(baseStartPlace-1)); %new matrix of data
                    xvalsNo = xvals(1:(baseStartPlace-1));
                    g_makeFig(xvalsNo,baseNoRange','Region Not Baselined',[0, 4000], [], xlab,ylab,viAble, savRR,mp, subLe,savstring,reTakw,levelNam,'__BZ_RegionNotBAseline.bmp')
                    
                    %save the x values of the spectra
                    xVALDataNO = strcat(subLe,'\',savstring,'_',reTakw,'_',levelNam,'_ x_NoBAse.txt');
                    data_xVALNO = array2table(xvalsNo);
                    writetable(data_xVALNO,xVALDataNO);
                    
                    %save the baseline data so dont have recalculate every time
                    baseLINEDataNO = strcat(subLe,'\',savstring,'_',reTakw,'_',levelNam,'_NoBase_end_',num2str(baseStart),'.txt');
                    data_bc2TNO = array2table(baseNoRange);
                    writetable(data_bc2TNO,baseLINEDataNO)
                    
                    xvals = [xvalsNo;xvalsBase];
                    data_bc2 = [baseNoRange,data_bc2];
                else
                    xvals = xvalsBase;
                end
                
            end
            
            
            
            %                 %%Graph of Orginal Spectra and Baseline Subtraction
            %                 figure;
            %                 plot(xvalsRange,baseRange',xvalsRange,data_bc46');
            %
            %                 %             AA_B = [xvals,baseRange',data_bc'];
            %                 %             baHW = strcat(dirName,'\dataForBaseFIgure.csv');
            %                 %             daHW = array2table(AA_B);
            %                 %             writetable(daHW,baHW)
            %                  % g_makeFig(xvalsRange,[baseRange',data_bc46'],'Baseline Corrected',[0, 4000], [], xlab,ylab,viAble, savRR,mp, subLe,savstring,reTakw,levelNam,'__BC_OrgwithSub.bmp')
            %
            %
            
            
            mainpath = dirName;
            
            [D_Takes,cnt_D_Takes,rf]= g_DrawMap(subLe,xvals,data_bc2,mapX, mapY,mapZ,mapXS , mapYS , mapZS, mapES,TyWin,num2str(mapLayerZ)...
                ,viAble,nOrmval, xlab,ylab,savRR,savstring,reTakw,cnt_A_Takes, cnt_D_Takes,HW_ratip, HWC,equiSize,HWC_mean...
                ,mapJuman,mapJuman25,lowBJump,mainpathSUB,D_Takes,ratTransform,ratRangTop,ratRangBot,peakOF,makemaps,mainpath,fwhmAsh);
            %                 cnt_D_Takes = cnt_D_Takes+1
            %             end
            
            
        end
        
        
        
        
        
        
        [draGon, Targer]  = size(D_Takes);
        
        if gunit > 1
            frontEire = draGon/gunit;
        else
            frontEire =1;
        end
        
        
        g_Star_dTakesE(subLe,reTakw,mp,D_Takes(frontEire:draGon,:), savstring);
        
        
        
        
        if gunit == length(tt)
            g_Star_dTakesE(mainpathSUB,reTakw,'',D_Takes(gez:gunit,:), 'all');
        end
        
        
        
        close all
        clearvars -except baseBaseANdNP fwhmAsh peakOF jMarjorie makemaps ratTransform ratRangBot ratRangTop xlab ylab D_Takes baseMas mapJuman25 viAble baseStart lowBJump TyWin HW_x HW_y mainpath gez hert mainpathSUB2 cntp answer dirName he tt tt_file s1 HW_ratip f1 s2 othGro HWC_mean f2 HW HWC padView mapJuman nOrmval probes1 fileList equiSize savRR reTakw mainpathSUB txtr onlyTXT23 B_Takes D_Takes C_Takes  cnt_D_Takes cnt_A_Takes A_Takes allFilesSub n_name nameFolds demensions20160503 allFiles denDeM
        'clearing 1';
        
        
    end
end


g_Star_dTakesE(dirName,reTakw,'',D_Takes,'Final');

clear
close all

