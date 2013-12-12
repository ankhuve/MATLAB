function [ H ] = highpass( I,d )
blur = conv_blur(I,d);
H = I-blur;
subplot(1,2,1),imshow(I,[]);
subplot(1,2,2),imshow(H,[]);
