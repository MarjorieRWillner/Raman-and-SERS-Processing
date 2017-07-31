function g_makeFig(xvals,yvals,northName,Ax_lim, Ay_lim, xlab,ylab,viAble, savRR,mp,  subLe,savstring,reTakw,levelNam,refMar)


h(1) = figure;
plot(xvals,yvals); %plot
title(northName);

if isempty(Ax_lim) == 0
    xlim(Ax_lim);
end

if isempty(Ay_lim) == 0
    ylim(Ay_lim);
end

set(gcf,'color','w')
xlabel(xlab);
ylabel(ylab);

x1 = xlim;

% gg = x1(2)-x1(1);
% if gg/10 > 100;
%     ct = gg/10;
% else
%     ct =10;
% end
% 
% 
%  set(gca,'XTick',(x1(1):ct:x1(2)));


if viAble == 0
    set(gcf, 'Visible', 'off');
end


if savRR == 1
    savfile123 = strcat(subLe, '\',savstring,'_',mp,'_',levelNam,'_',reTakw,refMar);
    saveas(h(1), savfile123 ,'bmp');
end
end

