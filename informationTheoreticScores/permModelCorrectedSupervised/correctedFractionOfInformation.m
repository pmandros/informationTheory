function rfi = correctedFractionOfInformation( samplesX, samplesY,mi,mo )
%CORRECTEDFRACTIONINFORMATION Corrected empirical fraction of information
%using the expected value under the permutation model
%   Calculates the empirical fraction of information from samples of X and
%   Y, corrected by the the expected mutual information under the permutation 
%   model. Argument mi is the precomputed mutual information, mo is the 
%   precomputed expected mutual information, and are optional.
    
    samplesY=concatenateAndFixAttributes(samplesY);
    samplesX=concatenateAndFixAttributes(samplesX);

    
    assert(size(samplesX,1)==size(samplesY,1),'Sample vectors should have the same length');

    entropyY=entropyPlugin(samplesY);   

    if entropyY==0
           rfi=0
       return
    end 
    
    if(nargin==2)    
        mi=mutualInformationPlugin(samplesX,samplesY)
        mo=permutationModelExpectedMutualInformation(samplesX,samplesY)
    end
    rfi=(mi-mo)/entropyY;
end

