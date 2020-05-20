function [rmi, boundMo, mi] = correctedMutualInformationLowerBound( samplesX, samplesY )
%CORRECTEDMUTUALINFORMATIONLOWERBOUND Corrected mutual information
%using the upper bound of the permutation model
    
    samplesY=concatenateAndFixAttributes(samplesY);
    samplesX=concatenateAndFixAttributes(samplesX);
    
    assert(size(samplesX,1)==size(samplesY,1),'Sample vectors should have the same length');

    mi=mutualInformationPlugin( samplesX, samplesY );
    boundMo=permutationModelExpectedMutualInformationBound(samplesX,samplesY);
    rmi=mi-boundMo;
    
   
end

