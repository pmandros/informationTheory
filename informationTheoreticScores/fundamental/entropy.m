function entropy = entropy( distribution )
%ENTROPY Shannon entropy of a probability distribution
%   Given a discrete distribution, it computes the Shannon entropy
    assert(compareNumsWithPrec(round(sum(distribution)),1),'Distribution does not sum to 1' );
    
    if isrow(distribution)
        distribution=distribution';
    end
       
    distribution(distribution<=0)=[];
    
    entropy=-distribution'*log2(distribution);
end

