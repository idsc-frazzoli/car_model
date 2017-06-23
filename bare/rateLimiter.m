function y= rateLimiter(curr, prev, maxRate)
% code by edo

global h;
if (maxRate < 0)
    error('rate of chanege has to be a positive parameter')
end
if curr > prev
    if  curr > prev + maxRate*h
        y = prev + maxRate*h;
    else
        y = curr;
    end
else
    if  curr < prev - maxRate*h
        y = prev - maxRate*h;
    else
        y = curr;
    end
end
end

