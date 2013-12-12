function Q = quantization( M, n )

T = dct_basis(8); % för in dct-matrisen i funktionen
I1 = mean(double(imread('uggla2.tif')),3); % läser in bilden i en variabel
I1 = I1-128; % pixlarna centreras kring nollnivån

% Testmatris
% M = zeros(8);
% for i = 4:-1:1
%     M(1:i,5-i) = 1;
% end

% Testmatris egen
% M = zeros(8);
% for i = 1:8
%     for j = 1:8
%         M(i,j) = (i^2+j^2);
%     end
% end

M = n*M;
% kodar bilden
for i = 1:8:size(I1,1)
    for j = 1:8:size(I1,2)
        block = I1(i:i+7,j:j+7);
        C(i:i+7,j:j+7) = T'*block*T;
        if sum(sum(M==0))>1
            C(i:i+7,j:j+7) = round(C(i:i+7,j:j+7).*M);
        else
            C(i:i+7,j:j+7) = round(C(i:i+7,j:j+7)./M);
        end
    end
end
T = dct_basis(8);
%avkodar bilden
for i = 1:8:size(C,1)
    for j = 1:8:size(C,2)
        block = C(i:i+7,j:j+7);
        block = block.*M;
        I(i:i+7,j:j+7) = T*block*T';
    end
end
disp(['Kompressionsgrad: ' num2str(size(C,1)*size(C,2)/sum(sum(C~=0))) ':1']) %printar kompressionsgraden
I = I+128;
subplot(1,2,1),imshow(I,[])
subplot(1,2,2),imshow(I1,[])