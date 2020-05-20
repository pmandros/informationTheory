function condFracInfo = conditionalFractionOfInformationPlugin( samplesX, samplesY, samplesZ )
%CONDITIONALMUTUALINFORMATIONPLUGIN plugin estimator for the conditional fraction of information
%   Given samples from discrete/categoric variables X, Y and Z, this
%   function calculates the conditional fraction
%   information of X and Y (target) given Z. X, Y, Z can be more than one variable, i.e., 
%   they can be multicariate. Therefore X,Y,Z can be matrices, where each of
%   their column represents one variable.


    
    samplesY=concatenateAndFixAttributes(samplesY);
    samplesX=concatenateAndFixAttributes(samplesX);
    samplesZ=concatenateAndFixAttributes(samplesZ);
    
    assert(length(samplesX)==length(samplesY) && length(samplesY)==length(samplesZ),'Samples should have the same length');

    
    entropyXZ=entropyPlugin([samplesX samplesZ]);
    entropyYZ=entropyPlugin([samplesY samplesZ]);
    entropyXYZ=entropyPlugin([samplesY samplesZ samplesX]);
    entropyZ=entropyPlugin(samplesZ);
    
    condFracInfo=(entropyXZ+entropyYZ-entropyXYZ-entropyZ)/conditionalEntropyPlugin(samplesZ,samplesY);  
end

