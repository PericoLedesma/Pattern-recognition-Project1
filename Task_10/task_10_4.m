close all;
figure(1)
img = imread('HeadTool0002.bmp');
I=im2double(img);
J=adapthisteq(I,'ClipLimit',0.02, 'NumTiles', [32 32]);
imshowpair(I,J,'montage')
[centers, radii, metric] = imfindcircles(J,[13 50])

%part 4
centersStrong6 = centers(1:6,:); 
radiiStrong6 = radii(1:6);
viscircles(centersStrong6, radiiStrong6,'EdgeColor','b')

%part 5
figure(2)
imshow(img)
centersStrong2 = centers(1:2,:); 
radiiStrong2 = radii(1:2);
viscircles(centersStrong2, radiiStrong2,'EdgeColor','r')