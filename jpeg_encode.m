function C = jpeg_encode(I)
%
% jpeg_encode - encode image I using block-by-block DCT coefficients
%
% input:
%  I (nxm matrix) - Input image
% output:
%  C (nxm matrix) - DCT coefficient matrix
I = I-128;
T = dct_basis(8);

for i = 1:8:size(I,1)
    for j = 1:8:size(I,2)
        block = I(i:i+7,j:j+7);
        C(i:i+7,j:j+7) = T'*block*T;
    end
end

subplot(1,2,1),imshow(I,[])
subplot(1,2,2),imshow(C,[])