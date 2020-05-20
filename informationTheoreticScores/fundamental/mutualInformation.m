function mutualInfo = mutualInformation( probX, probY, probXY )
%MUTUALINFORMATION mutual information between random
%variables X and Y
%
%   Given the probability distribution of X,Y, and XY (i.e., the joint),
%   this function calculates the mutual information between X and Y

    
    entropyX=entropy(probX);
    entropyY=entropy(probY);
    entropyXY=entropy(probXY);
    
    mutualInfo=entropyX+entropyY-entropyXY;
end

