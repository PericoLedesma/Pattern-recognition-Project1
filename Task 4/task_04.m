%2: plot the Gaussian
mu = [3 4];
Sigma = [1 0; 0 2];
[X,Y] = meshgrid(-10:.5:10);
Z = mvnpdf([X(:) Y(:)],mu,Sigma);
Z = reshape(Z,size(X));
mesh(X,Y,Z)

%1: mahalanobis distance
x1 = [10 10]';
x2 = [0 0]';
x3 = [3 4]';
x4 = [6 8]';

y1 = my_dM(x1,mu',Sigma);
y2 = my_dM(x2,mu',Sigma);
y3 = my_dM(x3,mu',Sigma);
y4 = my_dM(x4,mu',Sigma);

Y = [y1 y2 y3 y4]