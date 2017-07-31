function answer1 = g_handDimen(savstring,heroDance, yResh)

wrd = strcat('Fixed the dimensions the provided data:\n','1)Total Pnts=', num2str(yResh),'\n2)' ,savstring, '\n3)',  heroDance,'\n\nx=');
f= sprintf(wrd); 

prompt1 = {f, 'y=', 'z='
    };
dlg_title1 = 'Fixed the dimensions the provided data:';
num_lines1 = 1;
defaultans1 = {'1','2','3'}
answer1 = inputdlg(prompt1,dlg_title1,num_lines1,defaultans1,'on');

end



