function kldiv = kullbackLeiblerDivergence(targetDistribution,usedDistribution)
%KULLBACKLEIBLERDIVERGENCE computes the Kullback-Leibler divergence of

    assert(~any(usedDistribution==0),"kldiv is undefined when used distribution has zero when in target distribution non-zero" );
    assert(length(targetDistribution)==length(usedDistribution),"Distributions don't have same domain size");
    assert(abs(1 - sum(targetDistribution)) <= eps(max(1, sum(targetDistribution))),"Target distribution doesnt sum to 1" );
    assert(abs(1 - sum(usedDistribution)) <= eps(max(1, sum(usedDistribution))),"Used distribution doesnt sum to 1" );  
    if isrow(targetDistribution)
        targetDistribution=targetDistribution';
    end
    
    if isrow(usedDistribution)
        usedDistribution=usedDistribution';
    end
    
    kldiv=-targetDistribution'*log2(usedDistribution./targetDistribution);

end

