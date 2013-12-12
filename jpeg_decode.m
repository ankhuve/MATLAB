function I = jpeg_decode(C)
%
% jpeg_decode - encode image I using block-by-block DCT coefficients
%
% input:
%  C (nxm matrix) - Input DCT coefficient matrix
% output:
%  I (nxm matrix) - Output image
I1 = mean(double(imread('uggla2.tif')),3);
T = dct_basis(8);
C = jpeg_encode(I1);
for i = 1:8:size(C,1)
    for j = 1:8:size(C,2)
        block = C(i:i+7,j:j+7);
        I(i:i+7,j:j+7) = T*block*T';
    end
end
I = I+128;
subplot(1,2,1),imshow(I,[])
subplot(1,2,2),imshow(I1,[])