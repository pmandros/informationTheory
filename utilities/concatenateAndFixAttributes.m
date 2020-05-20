function [samples,prodDomS] = concatenateAndFixAttributes( samples, prodDomSizes )
%CONCATENATEANDFIXATTRIBUTES Turns a row vector into a column, or if matrix,
%concatenates the columns (as in joining categorical attributes)

    prodDomS=0;

    %check if vector, and if matrix concatenate
    if isvector(samples)
        if nargin==2
           if prodDomSizes==true
                prodDomS=length(unique(samples));
           end
        end
        if isrow(samples)
            samples=samples';
        end
    else  %is matrix
        if nargin==2
           if prodDomSizes==true
                prodDomS=prod(arrayfun(@(x) length(unique(samples(:,x))), 1:1:size(samples,2)));
           end
        end
        [~,~,samples]=unique(samples,'rows');
    end
end

   