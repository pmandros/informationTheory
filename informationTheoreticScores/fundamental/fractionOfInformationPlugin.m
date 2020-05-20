function F = fractionOfInformationPlugin( samplesX, samplesY,mi )
%FRACTIONOFINFORMATIONPLUGIN plugin estimator for the fraction of information 
%   Given samples from X and Y this function calculates F(X;Y)=I(X;Y)/H(Y), i.e., 
%   the normalized mutual information of X and Y w.r.t. Y. X and Y can be more than one variable, i.e., they can be 
%   multivariate. Therefore X and Y can be matrices, where each column
%   represents one variable. Argument mi is the precomputed mutual information,
%   and is optional.
    samplesX=concatenateAndFixAttributes(samplesX);
    samplesY=concatenateAndFixAttributes(samplesY);

    assert(size(samplesX,1)==size(samplesY,1),'Sample vectors should have the same length');
    
    entropyY=entropyPlugin(samplesY);

    
    if(entropyY==0)
       F=0;
       return;
    end
    
    if(nargin==2)
        mi=mutualInformationPlugin(samplesX,samplesY);
        F=mi/entropyY;
    else
        F=mi/entropyY;
    end
end

