function I = jpeg_decode2(C)
%
% jpeg_decode - encode image I using block-by-block DCT coefficients
%
% input:
%  C (nxm matrix) - Input DCT coefficient matrix
% output:
%  I (nxm matrix) - Output image
T=dct_basis(8);
%C = jpeg_encode(I);
for i = 1:8:size(C,1)
    for j = 1:8:size(C,2);
        Csub = C(i:i+7,j:j+7);
        I(i:i+7,j:j+7)=T*Csub*T';
    end
end
I=I+128;
%imshow(J,[])
%imshow(C,[])

imshow(C,[])