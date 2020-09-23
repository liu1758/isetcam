function wavelength = createWavelength(range)
%CREATEWAVELENGTH Summary of this function goes here
%   Detailed explanation goes here
if getpref('ISET','useSingle',true)
    wavelength = single(range);
else
    wavelength = range;
end

