function condMutualInfo = conditionalMutualInformationPlugin( samplesX, samplesY, samplesZ )
%CONDITIONALMUTUALINFORMATIONPLUGIN plugin estimator for the conditional mutual information
%   Given samples from discrete/categoric variables X, Y and Z, this function calculates the conditional mutual
%   information of X and Y given Z. X, Y, Z can be more than one variable, i.e., 
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
    
    condMutualInfo=entropyXZ+entropyYZ-entropyXYZ-entropyZ;  
%     assert(condMutualInfo>=0,'Conditional mutual information should be greater or equal to 0');
end

