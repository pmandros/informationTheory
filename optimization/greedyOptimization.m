function  selectedFeatures=greedyOptimization(measure, data, target)
%GREEDYOPTIMIZATION Greedily optimizes a function on tabular data
% Measure is the function to be optimized, data is the table, target is the
% the index of the target variable

    numVariables=size(data,2)-1;


    if nargin==3  
        Y=data(:,target);
    else
        target=numVariables+1;
        Y=data(:,end);
    end
    
    selectedFeatures=[];
    bestScore=-1000;
    
    for i=1:numVariables
        %find next best
        maxScore=-1000;
        maxVar=[];
        for j=1:numVariables
            if (j==target || ismember(j,selectedFeatures)) 
                continue;
            end
            X=data(:,[selectedFeatures j]);
            score=measure(X,Y);
            
            if (score>maxScore)
               maxVar=j;
               maxScore=score;                          
            end                     
        end

        if maxScore<=0 || maxScore<=bestScore
           return;
        end
        
        if maxScore>bestScore
            bestScore=maxScore;
            selectedFeatures=[selectedFeatures maxVar];
        end
        
    end
end





