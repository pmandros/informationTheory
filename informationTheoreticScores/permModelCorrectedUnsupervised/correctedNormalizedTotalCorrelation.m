function [ws,entropies,correction] = correctedNormalizedTotalCorrelation( X, mutualInfoFunction, doNormalize, K)
%CORRECTEDNORMALIZEDTOTALCORRELATION Computes the corrected normalized total correlation for variables
%X=(X1,...,Xd) based on empirical probabilities
%   X is a matrix where each column contains the samples of a variable. 

    numAttr=size(X,2);

    %if 1 attribute only, score is 0
    if(numAttr==1)
       ws=0; 
       return
    end
    ws=zeros(1,numAttr-1);
    correction=zeros(1,numAttr-1);

    
    if(nargin==3)
        entropies=arrayfun(@(x) entropyPlugin(X(:,x)), 1:1:numAttr);       
    else
       if(ischar(K)) 
            %'Calculating entropies and sorting (maybe)'
            entropies=arrayfun(@(x) entropyPlugin(X(:,x)), 1:1:numAttr);

            %sort if required
            if strcmp(K,'ascend')
                %sorting according to ascending entropy
                [entropies, indices]=sort(entropies,'ascend');
                X=X(:,indices);
            elseif strcmp(K,'descend')
                %sorting according to descending entropy
                [entropies, indices]=sort(entropies,'descend');
                X=X(:,indices);         
            end     
       elseif (isvector(K))
            entropies=K;
       end
    end
      
    %initialize incremental calculation
    w=0;
    normalizer=0;
    
    for i=2:numAttr
       conditioned=X(:,i);
       conditional=X(:,1:1:(i-1));
       
       %incremental calculation
       newNominatorTerm=mutualInfoFunction(conditional,conditioned);
       correction(i-1)=permutationModelMutualInformationBound(conditional,conditioned);
              

       if doNormalize
           newDenominatorTerm=entropies(i);
           ws(i-1)=(normalizer*w+newNominatorTerm);
           normalizer=normalizer+newDenominatorTerm;
           w=ws(i-1)/normalizer;
       else
           w=w+newNominatorTerm;
       end
       ws(i-1)=w;
    end
    entropies=entropies(2:end);
    
end

