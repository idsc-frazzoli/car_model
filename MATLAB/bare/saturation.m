function y = saturation(x, low,high)
% code by edo

if x > high
    y = high;
else if x < low
        y = low;
    else
        y = x;
    end
end

end

