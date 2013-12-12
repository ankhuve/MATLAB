function [ G ] = sobel( I )
H = [-1,0,1;-2,0,2;-1,0,1];

Gx = filter2(H,I);
Gy = filter2(rot90(H,3),I);

for x = 1:size(Gx,1)
    for y = 1:size(Gx,2)
        G(x,y) = sqrt((Gx(x,y)^2)+(Gy(x,y)^2));
    end
end
subplot(1,2,1),imshow(I,[]);
subplot(1,2,2),imshow(G,[]);