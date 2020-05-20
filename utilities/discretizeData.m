function discreteData=discretizeData(data,numBins,method)
    
    [n, dim]=size(data);
    discreteData=zeros(n,dim);
    for i=1:dim
       discreteData(:,i)=method(data(:,i),numBins);
    end
end
