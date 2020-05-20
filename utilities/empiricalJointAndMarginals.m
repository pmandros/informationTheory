function [ px,py,pxy] = empiricalJointAndMarginals( samplesX, samplesY )
%EMPIRICALJOINTANDMARGINALS Empirical joint and marginal
%distributions for two attributes from samples


    assert(compareNumsWithPrec(length(samplesX),length(samplesY)),'Sample vectors should have the same length');

    contTab=crosstab(samplesY,samplesX);
    
    marginalCountsX=sum(contTab,1);
    marginalCountsY=sum(contTab,2);     
    n=sum(marginalCountsX);
    
    pxy=(contTab(:))./(n);
    px=(marginalCountsX)./(n);
    py=(marginalCountsY)./(n);


end

