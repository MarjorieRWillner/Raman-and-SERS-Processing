function [nameStep,nameBase,nameXval] = g_EsubTxt(txtr)

onlySteps = strfind(txtr,'step')
onlyxVal = strfind(txtr,'xval.txt')
onlybase = strfind(txtr,'_baselined')

ncy = 1;
ncx3 =1;
ncx4 =1;
nameStep = cell(1);
nameBase = cell(1);
nameXval = cell(1);

    for n=1:length(txtr)
        if (cellfun('isempty',onlySteps(n,:)) == 0)
            nameStep(ncy,1) = txtr(n)
            ncy = ncy+1;
        end
        if (cellfun('isempty',onlybase(n,:)) == 0)
            nameBase(ncx3,1) = txtr(n)
            ncx3 = ncx3+1;
        end

        if (cellfun('isempty',onlyxVal(n,:)) == 0)
            nameXval(ncx4,1) = txtr(n)
            ncx4 = ncx4+1;
        end

    end


end

