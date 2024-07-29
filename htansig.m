%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% implementation of a hyperbolic tangent sigmoid.
% inputs: z (argument of sigmoid), m (inverse transition width), mu
% (sigmoid inflection point)
%
% outputs: outuput (value of sigmoid at z)
function output = htansig(z,m,mu)
        output = (1/2)*(tanh(m*(z - mu)) + 1 );
end