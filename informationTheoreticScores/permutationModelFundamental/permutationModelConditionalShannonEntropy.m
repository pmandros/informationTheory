function permCondShannon = permutationModelConditionalShannonEntropy( samplesX,samplesY )
%PERMUTATIONMODELCONDITIONALSHANNONENTROPY Expected conditional
%Shannon entropy of Y given X under the permutation model

    assert(size(samplesX,1)==size(samplesY,1),'Samples should have the same length');
    entropyY=entropyFromSamples(samplesY);
    permMI=permutationModelExpectedMutualInformation(samplesX,samplesY);
    permCondShannon=entropyY-permMI;
    
%     assert(permCondShannon>=0,'Conditional shannon entropy should be greater or equal to 0');



end

