function C = jpeg_encode2(I)


T=dct_basis(8);

I=I-128;

%for n=1:64
%    I(n)=I(n)-128;
%end
%for n=1:20
for i = 1:8:size(I,1)
    for j = 1:8:size(I,2);
        Isub = I(i:i+7,j:j+7);
        C(i:i+7,j:j+7)=T'*Isub*T;
    end
end
    
C=T'*I*T;
imshow(C,[]);

end
