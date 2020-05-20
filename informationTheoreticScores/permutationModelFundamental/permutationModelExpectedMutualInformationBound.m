function bound = permutationModelExpectedMutualInformationBound( samplesX,samplesY )
%PERMMODELMUTUALINFOBOUND Upper bound of Nguyen et al., 2010, for the expected value
%of mutual information under the permutation model
%
%   

    samplesY=concatenateAndFixAttributes(samplesY);
    samplesX=concatenateAndFixAttributes(samplesX);
    
    n=length(samplesX);
    
    domainSizeX=length(unique(samplesX));
    domainSizeY=length(unique(samplesY));   
    
    if(domainSizeX==1 || domainSizeY==1)
        bound=0;
        return;
    end
    
    bound=log2((n+domainSizeX*domainSizeY-domainSizeX-domainSizeY)/(n-1) );
                
end

