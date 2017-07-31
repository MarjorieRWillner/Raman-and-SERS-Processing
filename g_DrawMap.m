function [D_Takes,cnt_D_Takes,rg] = g_DrawMap(subLe,xvals,data_bc2,mapX, mapY,mapZ,mapXS , mapYS , mapZS, mapES,TyWin,mapLayerZ...
    ,viAble,nOrmval, xlab,ylab,savRR,savstring,reTakw,cnt_A_Takes, cnt_D_Takes,HW_ratip, HWC,equiSize,HWC_mean...
    ,mapJuman,mapJuman25,lowBJump,mainpathSUB,D_Takes,ratTransform,ratRangTop,ratRangBot,peakOF,makemaps,mainpath,~)

if mapY ~= 1
    de2 = mapY;
else
    de2 = mapZ;
end

rg= []'

for ijp=1:str2double(mapLayerZ)
    levelNam = mapLayerZ;
    [xt , ~] =size(TyWin); %gets number of peaks to compare aganist
    
    for iTer=1:xt
        s1 = TyWin{iTer,1};
        f1 = TyWin{iTer,2};
        mp = num2str(TyWin{iTer,3});
        
        s1_in= correct_axisSPC(s1, xvals); %find index of starting wavenumber
        f1_in =correct_axisSPC(f1, xvals); %find index of ending wavenumber
        
        if s1_in < f1_in
            pk1=data_bc2(:,s1_in:f1_in); %matrix of all the data for the points that fall in the range
            xk1_hold = f1_in-s1_in+1;
            clear xk1
            xk1(xk1_hold,1)=zeros;
            
            cntr = 1; %place holding variable
            for hh=s1_in:f1_in
                xk1(cntr,1)=xvals(hh); %xk1 is new array of x-values
                cntr = cntr +1;
            end
        else
            pk1=data_bc2(:,f1_in:s1_in); %matrix of all the data for the points that fall in the range
            
            cntr = 1; %place holding variable
            for hh=f1_in:s1_in
                xk1(cntr,1)=xvals(hh); %xk1 is new array of x-values
                cntr = cntr +1;
            end
        end
        
        if makemaps  == 1
            %figure 3 - baseline corrected and normalized spectra in the roi
            titW3 =(strcat('Centered:',mp,'(1/cm) -- Baselined and Normalized with val : ',num2str(nOrmval)));
            g_makeFig(xk1,pk1',titW3,[], [], xlab,ylab,viAble, savRR,mp, subLe,savstring,reTakw,levelNam,'__D_ROI.bmp')
        end
        
        
        
        [pk_x,pk_y] = size(pk1);
        norminten=pk1./nOrmval;
        
        
        
        %loop to find the max counts from each spectra in the region of
        %interest
        top_pk1 = zeros(pk_x,1);
        
        %find position of peak of interest in xk1
        [~, indexVal2] = min(abs(xk1-str2double(mp)));
        closestValues = xk1(indexVal2);
        
        if peakOF == 1
            dra = 1;
            for hh_pk1=1:pk_x
                
                %                 %plot the region of interest that we are going to find the
                %                 %max of
                %                 figure;
                %                 plot(xk1,norminten(hh_pk1,:))
                %                 hold on; %plot the locations that we are going to take the value of
                %                 scatter(xk1((indexVal2-1):(indexVal2+1)), norminten(hh_pk1,(indexVal2-1):(indexVal2+1)))
                numTop = sum(norminten(hh_pk1,(indexVal2-1):(indexVal2+1)));
                %
                %lets say we want to set a cutoff
                %                 if numTop < 50
                %                     numTop = 0;
                %                 end
                closestValues13 = []
                top_pk1(dra,1) = numTop; %save the value of the max and used for making maps
                dra = dra +1;
            end
        else
            dra = 1;
            for hh_pk1=1:pk_x
                numTop = max(norminten(hh_pk1,:));
                
                [~, indexVal3] = min(abs(norminten(hh_pk1,:)-numTop));
                closestValues13 = xk1(indexVal3);
                %
                %                 %plot the region of interest that we are going to find the
                % %                 %max of
                %                 figure;
                %                 scatter(xk1,norminten(hh_pk1,:))
                %                 hold on;
                %                 scatter(closestValues13,numTop)
                
                
                top_pk1(dra,1) = numTop;
                rg(iTer,1) =closestValues13; %save location of peak
                
                dra = dra +1;
            end
        end
        
        
        %         A_Takes(:,iTer) =  rg(:,1); % accumulate all the  results
        
        A321_Takes(:,iTer) =  top_pk1(:,1);
        
        
        mp;
        %save the 1Dmap values of the spectra
        map1D345 = strcat(subLe,'\',savstring,'_',reTakw,'_',levelNam,'_',mp,'_1Dmap.txt');
        data_345 = array2table(top_pk1);
        writetable(data_345,map1D345);
        
        if peakOF == 0
            %save the peak location
            map1D3456 = strcat(subLe,'\',savstring,'_',reTakw,'_',levelNam,'_',mp,'_peakPosition.txt');
            data_3456 = array2table(rg);
            writetable(data_3456,map1D3456);
        end
        
        
        savWinter34 = strcat(savstring,'_', num2str(mp));
        savWinter38 = strcat(num2str(mp));
        
        varargin352(iTer,:) = {savWinter34,savWinter38,mapX,mapY,mapZ,mapXS,mapYS,mapZS,mapES,sum(top_pk1), mean(top_pk1),min(top_pk1),...
            max(top_pk1),std(top_pk1),(std(top_pk1)/abs(mean(top_pk1))),closestValues13};
        
        %end checking out single peaks
    end
    
    if HW_ratip ==1 % are we doing a ratio
        
        [~, jPeaksW] = size(A321_Takes);
        
        ctm = jPeaksW +1;
        
        for iTJ=1:jPeaksW
            if (jPeaksW)>= (iTJ+1)
                 
                unSa = [];
                
                for banZ=(iTJ+1):(jPeaksW)
                    A321_Takes(:,ctm) = A321_Takes(:,iTJ)./ A321_Takes(:,(banZ));
                    savWinter35 = strcat(savstring,'_',num2str(varargin352{iTJ,2}),'to', num2str(varargin352{(banZ),2}));
                    savWinter385 = strcat(num2str(varargin352{iTJ,2}),'to', num2str(varargin352{(banZ),2}));
                    
                    unSa = A321_Takes(:,ctm);
                    unSa(any(isnan(unSa),2),:) = [];
                    
                    varargin352(ctm,:) = {savWinter35,savWinter385,mapX,mapY,mapZ,mapXS,mapYS,mapZS,mapES,sum(unSa), mean(unSa),min(unSa),...
                        max(unSa),std(unSa),(std(unSa)/abs(mean(unSa))),(sum(unSa)/(mapX*mapXS*mapY*mapYS))};
                    
                    %save the 1Dmap values of the spectra
                    map1DLoq = strcat(subLe,'\',savstring,'_',reTakw,'_',levelNam,'_',varargin352{ctm,2},'_1Dmap.txt');
                    fgiOut = (regexp(subLe,'\','split'));
                    canT2 = fgiOut{end-1};
                    
                    
                    imaG = strcat(mainpath,'\MappingData\',reTakw,'_',varargin352{ctm,2});
                    mkdir(imaG);
                    map1DLoq2 = strcat(imaG,'\_',savstring,canT2,'_1Dmap.txt');
                    data_345 = array2table(unSa);
                    writetable(data_345,map1DLoq);
                    writetable(data_345,map1DLoq2);
                    
                    
                    if ratTransform ==1
                        [daRealpH, ~] = g_RatioTransform(A321_Takes(:,ctm));
                        map1DLoqpH = strcat(subLe,'\',savstring,'_',reTakw,'_',levelNam,'_',varargin352{ctm,2},'_transform_1Dmap.txt');
                        data_345pH = array2table(daRealpH);
                        writetable(data_345pH,map1DLoqpH);
                        ctm = ctm+1;
                        
                        A321_Takes(:,ctm) = daRealpH;
                        savWinter35 = strcat(savstring,'_transform_',num2str(varargin352{iTJ,2}),'to', num2str(varargin352{(banZ),2}));
                        savWinter385 = strcat('transform_',num2str(varargin352{iTJ,2}),'to', num2str(varargin352{(banZ),2}));
                        varargin352(ctm,:) = {savWinter35,savWinter385,mapX,mapY,mapZ,mapXS,mapYS,mapZS,mapES,sum(daRealpH), mean(daRealpH),min(daRealpH),...
                            max(daRealpH),std(daRealpH),(std(daRealpH)/abs(mean(daRealpH))),(sum(daRealpH)/(mapX*mapXS*mapY*mapYS))};
                    else
                        ctm = ctm+1;
                    end
                    
                    
                end
            end
        end
    end
    
    
    
    
    [xWa, ~] = size((varargin352));
    
    for iHon=1:xWa
        clear grouplet2
        sipDer = varargin352(iHon,:);
        D_Takes(cnt_D_Takes,:) = sipDer;
        
        top_pk1 = A321_Takes(:,iHon);
        
        if makemaps  == 1
            
            close all
            [~,~] = meshgrid(1:mapX:de2); %define grid area
            
            %reshape data into map fromat.
            crl_22 = reshape(top_pk1,mapX,de2);
            
            top_pk1(any(isnan(top_pk1),2),:) = [];
            sc_22 = mean(top_pk1)*2;
      
            
            
            
            %pads the map to make maps that are all the same size
            if equiSize == 1
                %                 if mapZ ==1
                spacerX = padView- mapX;
                spacerY = padView - de2;
                if (spacerX > 0 && spacerY > 0)
                    crl_pa22 = zeros(spacerX,de2);
                    crl_pa22(:,:) =2;
                    crl_223 = [crl_pa22;crl_22]; %this add rows
                    
                    crl_pa26 = zeros(padView,spacerY);
                    crl_pa26(:,:) =2;
                    crl_22_Fi = [crl_pa26,crl_223]; %this add columns
                else
                    crl_22_Fi = crl_22;
                end
                %                 end
            else
                crl_22_Fi = crl_22;
            end
            
            %         reRun = 0;
            
            
            if HWC_mean  == 1 && iHon > iTer && ratTransform == 1 && iHon ==xWa
                [scaDrak] = g_mapBOunds (ratRangBot,ratRangTop); %get bounds for the map
                %                     reRun =1;
            elseif HWC_mean  == 1 && iHon > iTer %this finds the means when we're looking at ratios
                mapJuman23 = {num2str(sc_22)};
                mapJuman2= [mapJuman23;mapJuman25]; %append 2X the mean
                [scaDrak] = g_mapBOunds (lowBJump,mapJuman2); %get bounds for the map
            else
                mapJuman2 = mapJuman;
                [scaDrak] = g_mapBOunds (lowBJump,mapJuman2); %get bounds for the map
            end
            
            
            [grouplet2] = g_mapDets(scaDrak, iHon, iTer,HWC,mainpathSUB,varargin352,ratTransform); %get sav locatin for maps
            [clubX, ~] = size(grouplet2); %number of maps we're saving
            grouplet2 =[grouplet2;grouplet2]; %doubling maps were saving
            
            %make sure maps sav in mainfolder
            for diams=1:clubX
                danDiam = grouplet2{diams,1};
                mkdir(danDiam)
                jId = clubX+diams;
                grouplet2{jId,1} = subLe;
            end
            
            
            get2DMapE3(crl_22_Fi,mapX,de2,levelNam,grouplet2,savstring,savRR,'_F',reTakw,num2str(varargin352{iHon,2}),viAble);
            
        end
        
        %generate maps of the data with different cut off values
        
        cnt_D_Takes = cnt_D_Takes+1;
    end
    
end

end