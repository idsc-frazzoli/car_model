function y = saturation(x, low,high)

if x > high
    y = high;
elseif x < low
    y = low;
else
    y = x;
end

end