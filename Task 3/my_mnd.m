%multivariate density function (p. 17 from pattern classification)
function p = my_mnd(x,mu,Sigma,d)
    frac = 1/((2*pi)^(d/2)*sqrt(det(Sigma)));
    xbar = x - mu;
    pow = xbar'*(inv(Sigma))*xbar;
    p = frac*exp(-0.5*pow);
end