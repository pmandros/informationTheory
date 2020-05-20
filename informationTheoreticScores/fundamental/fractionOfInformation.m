function F = fractionOfInformation( probX, probY, probXY )
%FRACTIONOFINFORMATION Normalized mutual information between random
%variables X and Y, w.r.t. Y, i.,e F(X;Y)=I(X;Y)/H(Y)
%   Given the probability distribution of X,Y, and XY (i.e., the joint),
%   this function calculates the fraction of information between X and Y
    entropyX=entropyPlugin(probX);
    entropyY=entropyPlugin(probY);
    entropyXY=entropyPlugin(probXY);
    
    if(entropyY==0)
       F=0;
       return;
    end
    
    F=(entropyX+entropyY-entropyXY)/entropyY;
end

