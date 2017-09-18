function y = deadZone(x, low, high)
% code by edo

if x < low
    y = x - low;
else if x > high
        y = x - high;
    else
        y = 0;
    end
end

end


