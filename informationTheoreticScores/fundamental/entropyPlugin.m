function entr = entropyPlugin(samples )
%ENTROPYPLUGIN plugin estimator for Shannon entropy 
%  Samples can be a vector of samples, in which case the output will be
%  the entropy of a single variable, or a matrix with each column being the
%  samples of one variable, in which case the output is the multivariate 
%  empirical joint entropy
    assert(ismatrix(samples),'A vector or matrix is required for finding the entropy from samples')
    
    
    if(size(samples,1)==1)
        entr=0;
        return;
    end
    samples=concatenateAndFixAttributes(samples);
    
    
    
    
    prob=calcEmpiricalProbVector( samples);
    entr=entropy(prob);
    
end

