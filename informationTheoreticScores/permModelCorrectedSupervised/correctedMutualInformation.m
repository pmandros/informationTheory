function rmi= correctedMutualInformation( samplesX, samplesY )
%CORRECTEDMUTUALINFORMATION Corrected mutual information
%using the expected value under the permutation model
%   Calculates the empirical mutual information from samples of X and
%   Y, corrected by the the expected mutual information under the permutation 
%   model. Argument mi is the precomputed mutual information, mo is the 
%   precomputed expected mutual information, and are optional.
    
    samplesY=concatenateAndFixAttributes(samplesY);
    samplesX=concatenateAndFixAttributes(samplesX);
    
    assert(size(samplesX,1)==size(samplesY,1),'Sample vectors should have the same length');

    mi=mutualInformationPlugin( samplesX, samplesY );
    mo=permutationModelExpectedMutualInformation(samplesX,samplesY);
    rmi=mi-mo;
    
end

