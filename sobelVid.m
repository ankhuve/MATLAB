function [ G ] = sobelVid( I )
H = [-1,0,1;-2,0,2;-1,0,1];
H = H./2;
Gx = imfilter(I,H);
Gy = imfilter(I,rot90(H,3));

for x = 1:size(Gx,1)
    for y = 1:size(Gx,2)
        G(x,y) = sqrt((Gx(x,y)^2)+(Gy(x,y)^2));
    end
end
% subplot(1,2,1),imshow(I,[]);
% subplot(1,2,2),imshow(G,[]);