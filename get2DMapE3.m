%crl_22 is the 2D map data %savRR defines if the map should be saved
%map A is dimension1  %map B is dimenstion 2
%subLe is the path to save the file



function [] = get2DMapE3(crl_22,mapA,mapB,levelNam,grouplet2,savstring,savRR,letMe,reTakw,mp,viAble)


[starX, ~] = size(grouplet2);



for iJclips =1:(starX/2)
    subLe= grouplet2{iJclips,1};
    lowB = grouplet2{iJclips,3};
    
    HW = grouplet2{iJclips,5};
    highB = (grouplet2{iJclips,4});
    
    if highB < lowB
        continue;
    end
    
    if HW == 0
        figure;
        imagesc(flip(rot90(rot90(rot90(crl_22))),2),[lowB highB]);
        pbaspect([mapA mapB 1]);
        colormap hot;
        set(gcf,'color','w')
        
        wholTha = strcat('_Cutoff_',num2str(highB),'_Bottom_',num2str(lowB),'.bmp');
        
    elseif HW == 2
        figure;
        imagesc(flip(rot90(rot90(rot90(crl_22))),2),[lowB highB]);
        pbaspect([mapA mapB 1]);
        colormap jet;
        set(gcf,'color','w')
        wholTha = strcat('_Cutoff_',num2str(highB),'_Bottom_',num2str(lowB),'.bmp');
    else
        figure;
        imagesc(flip(rot90(rot90(rot90(crl_22))),2));
        pbaspect([mapA mapB 1]);
        colormap jet;
        set(gcf,'color','w')
        wholTha = strcat('.bmp');
        
    end
    
    
    if viAble== 0
        set(gcf, 'Visible', 'off');
    end
    
    locLarg = starX/2 +iJclips;
    colorbar;
    title(grouplet2{iJclips,2});
    size(get(gcf,'Colormap'),1);
    if savRR == 0
    else
        savfile7 = strcat(subLe, '\',savstring,'_',mp,'_',levelNam,'_',letMe,'_',reTakw,wholTha);
        savfile78 = strcat(grouplet2{locLarg,1}, '\',savstring,'_',mp,'_',levelNam,'_',letMe,'_',reTakw,wholTha);
        Imr = getframe(gcf);
        imwrite(Imr.cdata, savfile7);
%         Imr = getframe(gcf);
        imwrite(Imr.cdata, savfile78);
    end
end

end

