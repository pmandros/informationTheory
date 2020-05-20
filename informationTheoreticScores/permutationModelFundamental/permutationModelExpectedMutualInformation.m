function emi = permutationModelExpectedMutualInformation(samplesX, samplesY, pointsToInclude)
%PERMUTATIONMODELEXPECTEDMUTUALINFORMATION Expected mutual information
%under the permutation model for samples of discrete/categoric random variables X and Y
%   Given empirical samples of variables X and Y, this function calculates
%   the expected mutual information under the permutation model (using parallel for).

    samplesX=concatenateAndFixAttributes(samplesX);
    samplesY=concatenateAndFixAttributes(samplesY);
    
    assert(size(samplesX,1)==size(samplesY,1),'Sample vectors should have the same length');
     
    
    
    numSamples=length(samplesX);
    numMISamples=numSamples;
    
    contTable=crosstab(samplesY,samplesX);
    columnSums=sum(contTable,1);
    rowSums=sum(contTable,2);
    
    %if only one value for either, then emi is zero
    if(columnSums==numSamples | rowSums==numSamples)
        emi=0;
        return        
    end
    
    if nargin==3
       columnMarginalsToInclude=unique(samplesX(pointsToInclude));
       numMISamples=length(pointsToInclude);
       if numMISamples <=1 
          emi=0;
          return
       end
       toExclude=setdiff(1:1:length(columnSums),columnMarginalsToInclude);
       columnSums(toExclude)=[];
       if length(columnSums)==1
           emi=0;
           return;
       end
    end
    
    [X,Y]=meshgrid(rowSums,columnSums);
    pairsOfRowColumnSums=[X(:), Y(:)];
    emi=0;
    parfor i=1:length(pairsOfRowColumnSums)
       marginals= pairsOfRowColumnSums(i,:);
       rowMarginal= marginals(1);
       columnMarginal= marginals(2);

       iteratorMin=max(1,columnMarginal+rowMarginal-numSamples);
       iteratorMax=min(columnMarginal,rowMarginal);

       iterProb=hygepdf(iteratorMin,numSamples,rowMarginal,columnMarginal);
       cellContribution=iterProb*cellMICalc(iteratorMin,numMISamples,rowMarginal,columnMarginal);
 
       for k=iteratorMin+1:iteratorMax
          temp1 = iterProb* ((columnMarginal - (k - 1)) * (rowMarginal - (k - 1)));
          temp2 = ((k) * (numSamples - columnMarginal - rowMarginal + k));
          iterProb = temp1 / temp2;
          cellContribution = cellContribution + (cellMICalc(k, numMISamples, columnMarginal, rowMarginal) *iterProb);    
       end
       emi=emi+cellContribution;     
    end
end


function result=cellMICalc(nij,n, a,b)
    if nij==0
        result = 0;
    else
        firstPart=nij/n;
        secondPart= log2(n * nij / (a * b));
        result=firstPart*secondPart;
    end
end
