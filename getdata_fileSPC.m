% Searches a given path name for a specfic term, searchterm, and returns the x
% and y data for that term (typically the name of a given spectra). The
% code also modifies the name of the data file so that matlab can deal
% with; a '.' is changed in to a '_'
%this only gets text files
% searchterm = searchphrase;
% path = mainpath;
function [yvals,xvals, savstring,map,txtrr_IMG, mapX, mapY,mapZ,  mapXS , mapYS , mapZS , heroDance, mapES ] = getdata_fileSPC(searchphrase,mainpathSUB)

allFiles23 = dir(mainpathSUB);
allNames23 = {allFiles23.name };
onlyTXT23 = strfind(allNames23, '.spc');
% onlyIMG23 = strfind(allNames23, '.bmp');
g_txt23 = onlyTXT23(~cellfun('isempty',onlyTXT23)); %gives only cell array
% g_IMG23 = onlyIMG23(~cellfun('isempty',onlyIMG23)); %gives only cell array

% outImg = cell(1,1);
% outImg{1,1} = 'de'
map =1;
txtrr_IMG =1;
txtr = cell(length(g_txt23),1);

ctr = 1;

for n = 1: length(onlyTXT23)
    if (cellfun('isempty',onlyTXT23(:,n)) == 0)
        txtr(ctr,1) = allNames23(:,n);
        txtr(ctr,2) = num2cell(n);
        ctr = ctr+1;
    end
end

rname = strfind(txtr(:,1),searchphrase);
rctr = 1;

[xtxtr, ~] = size(txtr);

txtrr{xtxtr,1} = []; %preallocate array

for nn = 1: xtxtr
    if (cellfun('isempty',rname(nn,1)) == 0)
        txtrr(rctr,1) = txtr(nn,1); %matrix that holds the file names that contain the string of interst
        
%         nn
%         loc23 = cell2mat(txtr(nn,2));
%         locName = allNames23(:,loc23);
        rctr = rctr+1;
    else
        5;
    end
end



%%get data

if rctr > 1
    savstring1 = txtrr{1:1};
    savstring = savstring1(1:end-4);
    fSPC = strcat(mainpathSUB,'\',savstring1);
%     si23 =dir(fSPC);
%     sizFie = si23.bytes;
    
%     clearvars -except sizFie fSPC yvals xvals savstring map jump txtrr_IMG
    
    
    out = tgspcread(fSPC);
    
    xvals = double(out.X);
    yvals = double(out.Y);
    heroDance  = out.Header.Comment;
    
    [~, yStar] = size(yvals);
    
    varargin1  = {'x=';'y=';'z=';'xs=';'ys=';'zs=';';';'#';'/';'es=';yStar };
     [varargout1] =   dimNameFinderSPC(heroDance,savstring,varargin1);
   
    
    mapX = cell2mat(varargout1(1,8));
    mapY = cell2mat(varargout1(2,8));
    mapZ =  cell2mat(varargout1(3,8));
    
%     isempty(mapX)
%     isempty(varargout1(1,8))
    
    if isempty(mapX) == 1
        mapX = cell2mat(varargout1(1,6));
        mapY = cell2mat(varargout1(2,6));
        mapZ =  cell2mat(varargout1(3,6));
   end
    
 
    
    mapXS =cell2mat( varargout1(4,6));
    mapYS = cell2mat(varargout1(5,6));
    mapZS = cell2mat(varargout1(6,6));
    
    mapES = cell2mat(varargout1(10,6));
    
end

%
%
%
%
% yaxis = strfind(txtrr,'(Y-Axis)');
% yctr = 1;
%
% for yn = 1: length(txtrr)
%     if (cellfun('isempty',yaxis(yn,1)) == 0)
%         txtry(yctr,1) = txtrr(yn,1);
%         yctr = yctr+1;
%     end
% end
% %%%get X axis data
%
% xvals = strfind(txtrr,'(2colX)');
% xctr = 1;
%
% for xn = 1: length(txtrr)
%     if (cellfun('isempty',xvals(xn,1)) == 0)
%         txtrx(xctr,1) = txtrr(xn,1);
%         xctr = xctr+1;
%     end
% end
%
% cname = txtrx{1:1};
% modstring = strrep(cname, '(2colX).txt', '');
% savstring = strrep(modstring, '.', '_');
%
% %%%get map data
%
% map_axis = strfind(txtrr,'(map)');
% map_ctr = 1;
%
% for map_n = 1: length(txtrr)
%     if (cellfun('isempty',map_axis(map_n,1)) == 0)
%         txtr_map(map_ctr,1) = txtrr(map_n,1);
%         map_ctr = map_ctr+1;
%     end
% end
%
% % map_name = txtr_map{1:1};
% % mod_map_string = strrep(map_name, '(map).txt', '');
% % savstring_map = strrep(mod_map_string, '.', '_');
%
%
%
%
%
% % map_name = txtr_map{1:1};
% % mod_map_string = strrep(map_name, '(map).txt', '');
% % savstring_map = strrep(mod_map_string, '.', '_');
%
% %%%final
%
% yvals = load(strcat(jump,'\',txtry{1:1}),'-ascii');
% xaxis2 = load(strcat(jump,'\',txtrx{1:1}),'-ascii');
% xvals = xaxis2(:,1);
%
% map = (strcat(jump,'\',txtr_map{1:1}));

end