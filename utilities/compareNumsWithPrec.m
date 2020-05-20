function equal = compareNumsWithPrec( A,B )
%COMPARENUMSWITHPREC Compares two numbers with good precision
    equal=false;
    if (abs(A-B) < 1e4*eps(min(abs(A),abs(B))) ) 
        equal=true;
    end
end

