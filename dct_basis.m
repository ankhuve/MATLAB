function T = dct_basis(m)
%
% dct_basis - calculate basis vectors for DCT-transform
%
% input:
%   m (real number)  - Basis vector length

T = zeros(m); % Allokera matris

for p = 0:m-1
    for q = 1:m-1
        T(p+1,q+1) = sqrt(2/m)*cos((pi*(2*p+1)*q)/(2*m));
    end
end
T(:,1) = (1/sqrt(m));

% % Test 1
% I = ones(m);
% T'*I*T
% 
% % Test 2
% D = ones(m);
% D(:,2:2:end) = -1;
% T'*D*T
% 
% % Test 3
% E = eye(m);
% T'*E*T

% % Inverstest
% n = 1;
% for p = 1:m
%     for q = 1:m
%         C = zeros(m);
%         C(p,q) = 1;
%         I = T*C*T';
%         subplot(m,m,n)
%         imshow(I,[])
%         n = n+1;
%     end
% end



% output:
%   T = (mxm matrix) - DCT basis matrix where each column is a basis vector
