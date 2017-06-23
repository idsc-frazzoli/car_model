function [friction] = coulombFriction(in)
% code by edo

global params;

friction = sign(in) .* (params.b .* abs(in) + params.fric);

end

