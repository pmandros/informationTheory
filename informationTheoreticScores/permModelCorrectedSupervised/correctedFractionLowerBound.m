function rfi = correctedFractionLowerBound( samplesX, samplesY,mi )
%CORRECTEDFRACTIONLOWERBOUND Corrected fraction of information
%using an upper bound of the expected value under the permutation model
%
%   Calculates the empirical fraction of information from samples of X and
%   Y, corrected by the upper-bound of Nguyen et al. 2010 for the expected
%   mutual information under the permutation model. Argument mi is the pre
%   computed mutual information, and is optional.
    
    samplesY=concatenateAndFixAttributes(samplesY);
    samplesX=concatenateAndFixAttributes(samplesX);

    
    assert(size(samplesX,1)==size(samplesY,1),'Sample vectors should have the same length');

    entropyY=entropyPlugin(samplesY);   
    if(entropyY==0)
       rfi=0;
       return
    end 
    
    if(nargin==2)    
        mi=mutualInformationPlugin(samplesX,samplesY);
    end
    boundMo=permutationModelExpectedMutualInformationBound(samplesX,samplesY);

    rfi=(mi-boundMo)/entropyY;
end

