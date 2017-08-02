
% Author: Marjorie R. Willner
% Version: MATLAB R2016a
% Last modified: 8/2/17
% Copyright 2017 by Marjorie R. Willner
%--------------------------------------------------------------------------




dirName = uigetdir('C:\Users\Marjorie');
dp = genpath(dirName)
folders = regexp(dp,'C:\','split')';
ctr = 0;
ctr2 =0;
mp = ''; %'3. Peak of Interest (Amended to file Title)'
nOrmval= 1; %'4.Value to Normalize with'
equiSize = 0; %'5.Should the map be a certain size ? 0 = no, 1 =yes'
padView = 50; %'6.Minmium number of pixels in a square map. Maps bigger than this value will not be trimmed'

peakOF =0; % how should we find max? 1= pick out mp and 0 = let program find max y
reTakw = 'Aug02'; % '7.Additional Term for File name'

mapJuman = '50'; %'8.Upper bound of map Scale Bar must be text
mapJuman25 = '2'; %'8.Upper bound of map Scale Bar for ratio
savRR =1; %'9.Should the maps be saved? 0 = no; 1 = yes'
HW = 1 ; %'10.Do you want to use predefined XY values? 0 = no; 1 = yes'
HW_x = 1; % '11.Dimenstions of X?'
HW_y = 1; % '12.Dimenstions of Y?'
HWC = 1;  %'13.Map coloring: 0=hot color with scale, 1= jet no scale, 2 = jet scale with scale'
HWC_mean  =0; % '14.Should the scale be based on 2X the mean 0 = no and 1 = yes'
HW_ratip = 1;  %'15.Do we want to find a ratio between two peaks (ROI 1/ROI2)? 0 = no; 1 = yes'
baseMas = 1; %'18.Should the data be baseline corrected?:'
baseStart = 0; %'19.Where should the baselinecorrection start:'
lowBJump = '0';
lowBJump = (regexp(lowBJump,',','split'));
% TyWin= {3046,3108,3072;2885,3000,2916;1690,1745,1726;1580,1630,1614;1400,1501,1442;1250,1326,1288;1060,1122,1093;830,883,861} %;   % ;49,204}
% TyWin= {1150,1190,1180;100,150,140}
% TyWin ={3046,3108,3080;1593,1640,1611;2885,3000,2924};
% TyWin = {1358,1434,1410;1036,1102,1077};
% TyWin ={3046,3108,3080;2885,3000,2924};
TyWin ={1690,1745,1726;2885,3000,2924};

mapJuman = (regexp(mapJuman,',','split'));
A_Takes = 1 ; %zeros(10,4);
cnt_A_Takes = 1;
B_Takes =[];
C_Takes =[];
cnt_D_Takes = 1; %Counter for summary matrix D_Takes
D_Takes =cell(1,16); %Summary Matrix
hert=cell(1);
mainpathSUB2 = {};
ylab = ('Counts (abr.)')
xlab = 'Raman Shift (1/cm)'
viAble = 0; %Should the maps pop up on the screen? 0 = no and 1 = yes
ncy = 1; %Counter for Summary Matrix
ratTransform = 0; %are we transforming the ratio - i.e. pH? 0 =no and 1 = yes
ratRangTop{1,1} = '14';
ratRangBot{1,1} = '0';
makemaps = 0; %should we make maps 1= yes and 0 = no
fwhmAsh = 0; %should we calculate fwhm 1=yes and 0 = no
jMarjorie = [];


for n_nameSub2 =1: length(folders)
    
    mainP=strcat('C:\',folders{n_nameSub2});
    mainpathSUB=mainP(1:end-1);
    allFiles = dir(mainpathSUB);
    isub = [allFiles(:).isdir]; %# returns logical vector
    nameFolds = {allFiles(isub).name}'; %checks if there are folders
    nameFolds(ismember(nameFolds,{'.','..'})) = []; %returns names of folders
    ctr= ctr+1;
    if isempty(nameFolds)==0
        ctr2 = ctr2 +1;
        continue;
    end
    iFileT = ~[allFiles(:).isdir];
    allNames = {allFiles(iFileT).name}';
    onlyTXT23 = strfind(allNames , '.txt');
    g_txt23 = onlyTXT23(~cellfun('isempty',onlyTXT23)); %gives only cell array
    
    if isempty(g_txt23) ==1
        continue;
    end
    
    txtr = cell(length(g_txt23),1);
    %this is get all SPC files in a folder
    ctr = 1;
    
    
    s = regexp(mainpathSUB, '\', 'split');
    savstring = cell2mat(s(length(s)));
    mainpath =s(1);
    
    for sI=2:length(s)-1
        mainpath= strcat(mainpath,'\',s(sI));
    end

    
    
    
    
    
    mainpath = strcat(mainpath{1},'\');
    
    for n = 1: length(onlyTXT23)
        if (cellfun('isempty',onlyTXT23(n,:)) == 0)
            txtr(ctr,1) = lower(allNames(n));
            %  txtr(ctr,2) = num2cell(n);
            ctr = ctr+1;
        end
    end
    
    if length(txtr) < 2
        continue;
    end
    
%       rs = regexp(mainpathSUB, '\',\6, 'split')
%       strjoin(s(1:6),'\')
%       
        
    %     ncx =1;
    if ~isempty(g_txt23) == 1
        subLe = strcat(mainpathSUB,'\'); %strcat(s(1:(length(s)-1))) ;
        
         [~,xvals,data_bc2,mapX, mapY,mapZ,mapXS , mapYS , mapZS, mapES,mapLayerZ] = g_processNewMap(txtr,mainpathSUB);
      
         
         
         
%          jMarjorie = [jMarjorie, data_bc2];

         
         if length(data_bc2)< 2
             continue; 
         end
         
         
         [D_Takes,cnt_D_Takes] =  g_DrawMap(subLe,xvals,data_bc2,mapX, mapY,mapZ,mapXS , mapYS , mapZS, mapES,TyWin,mapLayerZ...
              ,viAble,nOrmval, xlab,ylab,savRR,savstring,reTakw,cnt_A_Takes, cnt_D_Takes,HW_ratip, HWC,equiSize,HWC_mean...
              ,mapJuman,mapJuman25,lowBJump,mainpath,D_Takes,ratTransform,ratRangTop,ratRangBot,peakOF,makemaps,mainpath,fwhmAsh);

    
    
          [draGon, Targer]  = size(D_Takes);
          
          if ncy > 1 && draGon == ncy
              frontEire= ncy;
          elseif ncy > 1
              frontEire = draGon/ncy;
          else
              frontEire =1
          end
          
        g_Star_dTakesE(subLe,reTakw,mp,D_Takes(frontEire:draGon,:), savstring)

   
    
    
    
    
    
%         if gunit == length(tt)
%             g_Star_dTakesE(mainpathSUB,reTakw,'',D_Takes(gez:gunit,:), 'all')
%         end
    end
    ncy = ncy+1;
end 

g_Star_dTakesE(dirName,reTakw,'',D_Takes,'all')
