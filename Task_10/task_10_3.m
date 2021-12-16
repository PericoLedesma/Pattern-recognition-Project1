close all;
blackImage = zeros(50, 50);
figure(1)
%exercise 1
subplot(2,1,1)
bI(30,21) = 255;
BW = edge(bI,'Canny');
imshow(bI)

subplot(2,1,2)
[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:1:89);
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);


%exercise 2
figure(2)
subplot(2,1,1)
bI = blackImage;
bI(30,21) = 255;
bI(8,40) = 255;
bI(22,7) = 255;
imshow(bI)

subplot(2,1,2)
BW = edge(bI,'Canny');
[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.1:89);
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);


%exercise 3
figure(3)
subplot(2,1,1)
bI = blackImage;
bI(22,7) = 255;
bI(30,21) = 255;
bI(47,47) = 255;
imshow(bI)

subplot(2,1,2)
BW = edge(bI,'Canny');
[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:1:89);
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);

%exercise 5
peaks = houghpeaks(H,1)
plot(T(peaks(:,2)),R(peaks(:,1)),'*','color','blue');

%exercise 6
