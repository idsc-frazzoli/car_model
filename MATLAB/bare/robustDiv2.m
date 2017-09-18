function z = robustDiv2(num,den, epsilon)
% code by edo

if den == 0
    if abs(num) > epsilon
        z = num/epsilon;
    else
        z = 0; 
    end
else
    z = num/den;
end

end

