function totalCor = totalCorrelation( marginalProbs, jointProb,normalize )
%TOTALCORRELATION Total correlation 
%   Calculates the total correlation given the marginal probabilities (cell
%   array with one vector per variable) and their joint probability (a
%   vector). If normalize==true, it calculates the normalized total
%   correlation
%

    numVar=length(marginalProbs);
    marginalEntropies=arrayfun(@(x) entropy(marginalProbs{x}),1:1:numVar);
    jointEntropy=entropy(jointProb);
    
    if(numVar==1)
       assert(compareNumsWithPrec(marginalEntropies(1),jointEntropy),'Weird things are going on');
       totalCor=0;
       return;
    end
    
    doNormalize=false;
    if(nargin==3)
       doNormalize=normalize; 
    end  

    sumOfEntropies=sum(marginalEntropies);
    numerator=sumOfEntropies-jointEntropy;
    denominator=1;
    
    if(doNormalize)
        denominator=sumOfEntropies-max(marginalEntropies);
    end
    
    totalCor=numerator/denominator;
end

