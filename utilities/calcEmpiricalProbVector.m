function probVector = calcEmpiricalProbVector( X, smoothing)
%CALCEMPIRICALPROB Empirical distribution for a
%discrete/categoric random variable given its samples
%   Given a categoric vector X and a smoothing amount (optional)
%   this function outputes the (smoothed) empirical distribution of X

    if nargin==1
       smoothing=0; 
    end

    assert(smoothing>=0,'Smoothing amount cannot be negative');
    assert(isvector(X),'A vector of samples is required for finding the empirical distribution')
    
    n=length(X);
    domainSize=length(unique(X));
    C=categorical(X);
    probVector=(histcounts(C)+smoothing)./(n+smoothing*domainSize);
    
    assert(compareNumsWithPrec(1, sum(probVector) ),'Empirical distribution does not sum to 1' );

end

