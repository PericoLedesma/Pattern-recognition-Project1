function myhoughline(im,rho,theta)
    %rho = x*cos(theta) + y*sin(theta)
    t = Tiff(im,'r');
    imageData = read(t);
    imshow(imadjust(rescale(imageData))), hold on;
    x = 1:250
    if sin(theta) == 0
        x = 0;
        y = 1:250;
    else
        y = (rho - x.*cos(theta))./sin(theta)
    end
    plot(x,y,'LineWidth',2,'Color','red')
end