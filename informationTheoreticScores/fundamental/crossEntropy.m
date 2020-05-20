function crossEntropy = crossEntropy( target, used )
%CROSSENTROPY calculates the cross Entropy of using distribution 'used' instead
%of 'target'

    assert(~any(used==0),"cross entropy is undefined when used distribution has zero when in target distribution non-zero" );
    assert(length(target)==length(used),"Distributions don't have same domain size");
    assert(abs(1 - sum(target)) <= eps(max(1, sum(target))),"Target distribution doesnt sum to 1" );
    assert(abs(1 - sum(used)) <= eps(max(1, sum(used))),"Used distribution doesnt sum to 1" );

   
    if isrow(target)
        target=target';
    end
    
    if isrow(used)
        used=used';
    end
    
    crossEntropy=-target'*log2(used);  
end

