function xInt = limitIntegrators(xInt)  % to avoid singularity if the model
% code by edo

if xInt(7) < 0
    xInt(7) = 0;
end

if xInt(8) < 0
    xInt(8) = 0;
end

if xInt(9) < 0
    xInt(9) = 0;
end

if xInt(10) < 0
    xInt(10) = 0;
end
    
end



