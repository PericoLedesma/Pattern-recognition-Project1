close all;
clear all;

%part 1
figure(1)
subplot(2,2,1)
t = Tiff('Cameraman.tiff','r');
I = imread('Cameraman.tiff');
imageData = read(t);
imshow(imageData)
title('Cameraman')

subplot(2,2,2)
BW = edge(I,'Canny');
imshow(BW)
title('Edge of the Cameraman')

%hough space
subplot(2,2,3)
[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);

%threshold hough space
subplot(2,2,4)
H(H<=30)=0;     %threshold of 15
imshow(imadjust(rescale(H)),'XData',T,'YData',R,'InitialMagnification','fit');
title('Hough transform with threshold');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);

%find local maxima
peaks = houghpeaks(H,5);
subplot(2,2,3)
plot(T(peaks(:,2)),R(peaks(:,1)),'s','color','blue');

%task 8
figure(2);
max = houghpeaks(H);
myhoughline('Cameraman.tiff',T(max(2)),R(max(1)));
close(t);