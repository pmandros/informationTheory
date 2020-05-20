function [discreteData, cutPoints]=equalFreqDisc(data,numBins)
    if isrow(data)
        data=data';
    end

    [n, dim]=size(data);
    discreteData=zeros(n,dim);
    for i=1:dim
       discreteData(:,i)=doDiscretize(data(:,i),numBins);
    end
    discreteData=discreteData+1;
    [~,IA,~] = unique(sort(discreteData),'first');
    cutPoints=[IA(2:end)-1 ;length(discreteData)];    
end


function vectorDiscretized= doDiscretize(vector,numBins)
    vectorSorted=sort(vector);
    vectorDiscretized=vector;

    pos=vectorSorted(round(length(vector)/numBins *[1:numBins]));
    for j=1:length(vector)
        vectorDiscretized(j)=sum(vector(j)>pos);
    end
end