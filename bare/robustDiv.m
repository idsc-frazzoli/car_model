function z = robustDiv(num,den, epsilon)
% code by edo
% not sure why I have two of these robustDiv functions, but this setup worked fine

if den == 0
    if num ~= 0
        z = num/epsilon;
    else
        z = 0; %clamp stuff to zero cause if the slips are zero there won't be aby force anyway
    end
else
    z = num/den;
end

end

