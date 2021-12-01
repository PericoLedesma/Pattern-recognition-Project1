%mahalanobis distance
%from wikipedia: D_M(x) = sqrt{(x - mu)'*Sigma*(x - mu)}
%x,mu are part of R^n
function y = my_dM(x,mu,Sigma)
    xbar = x - mu;
    frac = xbar'*Sigma*xbar;
    size(frac)
    y = sqrt(frac);
end