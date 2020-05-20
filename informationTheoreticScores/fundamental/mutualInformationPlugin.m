function mutualInfo = mutualInformationPlugin( samplesX, samplesY )
%MUTUALINFORMATIONPLUGIN plugin estimator for mutual information 
%   Given samples from variables X and Y, this function calculates their mutual
%   information. X and Y can be more than one variable, i.e., they can be 
%   multivariate. Therefore X and Y can be matrices, where each column
%   represents one variable.

    assert(size(samplesX,1)==size(samplesY,1),'Sample vectors should have the same length');

    samplesX=concatenateAndFixAttributes(samplesX);
    samplesY=concatenateAndFixAttributes(samplesY);
        
    [px,py,pxy] = empiricalJointAndMarginals( samplesX, samplesY );
    
    entropyX=entropy(px);
    entropyY=entropy(py);
    entropyXY=entropy(pxy);
        
    mutualInfo=entropyX+entropyY-entropyXY;
end

