function  results=exhaustiveCombinatorialOptimization(measure, data, target)
%EXHAUSTIVECOMBINATORIALOPTIMIZATION Optimizes exactly a function on tabular data
% Measure is the function to be optimized, data is the table, target is a
% boolean variable for whether the measure is supervised or unsupervised,
% and k is the number of results to return. The class variable is the last
% variable in the data
%

%     for i=1:length(varargin)
%         if(strcmp(varargin{i},'k')==1)
%             k=varargin{i+1};
%             continue;
%         end
%         if(strcmp(varargin{i},'control')==1)
%             controlVariables=varargin{i+1};
%             controlSamples=data(:,controlVariables);
%             continue;
%         end   
%     end

    if target==true
%         if exist('controlVariables','var')
%             data(:,controlVariables)=[];
%         end        
        targetVar=data(:,end);
        numVariables=size(data,2)-1;
    else
%         if exist('controlVariables','var')
%             data(:,controlVariables)=[];
%         end
        numVariables=size(data,2);
    end
    
%     results=cell(2^numVariables-1,2);
    variableVector=1:1:numVariables;
%     q=1;
    maxScore=-1000;
    maxRes=[];
    for i=1:numVariables
        %create all combinations of size i
        C = nchoosek(variableVector,i);

        %randomize their order (avoid deterministic order problems)
        perm=randperm(size(C,1));
        C=C(perm,:);
        
        scores=ones(1,size(C,1));
        combos=cell(size(C,1),1);
        parfor j=1:size(C,1)
            %get the variable combination
            combo=C(j,:);
            variableCombo=data(:,combo);
            if (target==true)
%                 if exist('controlVariables','var')
%                    comboScore=measure(variableCombo,targetVar,controlSamples); 
%                    combo=mapToOriginal(combo,controlVariables);
%                 else
                   comboScore=measure(variableCombo,targetVar);
%                 end               
            else
%                 if exists(controlSamples)
%                    comboScore=measure(variableCombo,controlSamples); 
%                    combo=mapToOriginal(combo,controlVariables);
%                 else
                   comboScore=measure(variableCombo); 
%                 end    
            end
            scores(j)=comboScore;
            combos{j}=combo;
            
%             if comboScore>maxScore
%                maxScore=comboScore; 
%                maxRes=combo;
%             end
            
%             results{q,1}=combo;
%             results{q,2}=comboScore;
%             q=q+1;
        end
        
        [M,I]=max(scores);
        if M>maxScore
           maxScore=M; 
           maxRes=combos{I};
        end
        
    end
    results=cell(1,2);
    results{1,1}=maxRes;
    results{1,2}=maxScore;
%     results=sortrows(results,2,'descend');
%     results=results(1:k,:)
%     if exist('k','var')
%         results=results(1:k,:);
%     end
end


function combo=mapToOriginal(combo, indices)
    for i=1:length(indices)
       where=find(combo>=indices(i));
       combo(where)= combo(where)+1;
        
    end
end



