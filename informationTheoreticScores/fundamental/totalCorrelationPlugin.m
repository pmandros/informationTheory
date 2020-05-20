function w= totalCorrelationPlugin(X, varargin)
%TOTALCORRELATIONPLUGIN  estimator for the total correlation
%   X is a matrix where each column contains the samples of a variable.
%   Varargs govern the mutual information estimator choice, the sorting, and normalization

    numAttr=size(X,2);
    %if 1 attribute only, score is 0 (convention)
    if(numAttr==1)
       w=0; 
       return
    end
    
    %get extra key value properties
    mutualInfoEstimator=@permutationMutualInformation;
    changeOrdering=true;
    normalize=false;
    order='descend';
    entropies=arrayfun(@(x) entropyPlugin(X(:,x)), 1:1:numAttr);       

    for i=1:length(varargin)
        if(strcmp(varargin{i},'estimator')==1)
            mutualInfoEstimator=varargin{i+1};
            continue;
        end
        if(strcmp(varargin{i},'sortOrder')==1)
            entropies=arrayfun(@(x) entropyPlugin(X(:,x)), 1:1:numAttr);       
            changeOrdering=true;
            order=varargin{i+1};
            continue;
        end   
        if(strcmp(varargin{i},'normalize')==1)
            if changeOrdering==false
                entropies=arrayfun(@(x) entropyPlugin(X(:,x)), 1:1:numAttr);  
            end
            normalize=varargin{i+1};
            continue;
        end
    end

    %order variables 
    if(changeOrdering)
        if strcmp(order,'ascend')
            %sorting according to ascending entropy
            [entropies, indices]=sort(entropies,'ascend');
            X=X(:,indices);
        elseif strcmp(order,'descend')            
            %sorting according to descending entropy
            [entropies, indices]=sort(entropies,'descend');
            X=X(:,indices);   
        end  
    end
 
    %initialize incremental calculation
    ws=zeros(1,numAttr-1);
    w=0;
    normalizer=0;

    
    %incremental calculation
    for i=2:numAttr
       conditioned=X(:,i);
       conditional=X(:,1:1:(i-1));
       
       newNominatorTerm=mutualInfoEstimator(conditional,conditioned);
       
       if normalize
           newNumerator=(normalizer*w+newNominatorTerm);
           newDenominatorTerm=entropies(i);
           newNormalizer=normalizer+newDenominatorTerm;
           w=newNumerator/newNormalizer;
           normalizer=newNormalizer;
       else
           w=w+newNominatorTerm;
       end
       ws(i-1)=w;
    end
end
