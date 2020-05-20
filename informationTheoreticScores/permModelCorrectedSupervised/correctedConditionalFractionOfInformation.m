function rcfi = correctedConditionalFractionOfInformation( samplesX, samplesY, samplesZ )
%CORRECTEDCONDITIONALFRACTIONOFINFORMATION Corrected conditional fraction of information
%using the expected value under the permutation model
%
%   Calculates the empirical fraction of information from samples of X and
%   Y conditioned on Z, corrected by the expected
%   mutual information under the permutation model.
    
    samplesY=concatenateAndFixAttributes(samplesY);
    samplesX=concatenateAndFixAttributes(samplesX);
    samplesZ=concatenateAndFixAttributes(samplesZ);
    numSamples=length(samplesZ);


    
    assert(length(samplesX)==length(samplesY) && length(samplesY)==numSamples ,'Sample vectors should have the same length');

    condEntropyY=permutationModelConditionalShannonEntropy(samplesZ,samplesY);   
    if(condEntropyY==0)
       rcfi=0;
       return
    end 
    
    [C,~,~] = unique(samplesZ);
    domSizeZ=length(C);
    
    %get indices of unique elements
    indices=arrayfun(@(x) find(samplesZ==C(x)),1:1:domSizeZ,'UniformOutput',false);
    probs=arrayfun(@(x) length(indices{x})/numSamples,1:1:domSizeZ);
    
    
    rcfi=sum(arrayfun(@(x) probs(x)*correctedMutualInformation(samplesX(indices{x}),samplesY(indices{x})),1:1:domSizeZ))/condEntropyY;
end

