function [ Blurred ] = conv_blur2( I,d )
rows = size(I,1); % Antal pixelrader i x-led f�r input-bilden.
cols = size(I,2); % Antal pixelrader i y-led f�r input-bilden.
krows = size(d,1); % Antal pixelrader i x-led f�r k�rnan.
kcols = size(d,2); % Antal pixelrader i y-led f�r k�rnan.
kcenter = floor((size(d)+1)/2); % Index f�r k�rnans mittv�rde.
l = kcenter(2)-1;
r = kcols-kcenter(2); % H�mta hur m�nga steg det �r till kanterna,
o = kcenter(1)-1;     % anpassar sig till hur stor k�rnan �r.
u = krows-kcenter(1);
NewMatrix = zeros(rows+o+u, cols+l+r); % Skapar matris med l�mpligt antal
                                       % extrarader/kolumner beroende p�
                                       % k�rnans storlek.
for i = 1+o:rows+o % Intervallet som �r sj�lva bilden.
    for j = 1+l:cols+r % Intervallet som �r sj�lva bilden.
        NewMatrix(i,j) = I(i-o, j-l); % L�gg in inputbilden i mitten av 
                                      % nya matrisen.
    end
end
Blurred = zeros(rows, cols); % Skapa matris i input-bildens storlek.

for x = 1:rows-o
    for y = 1:cols-l
        Blurred(x,y) = sum(sum(NewMatrix(x+l:x+l-1+krows, y+o:y+o-1+kcols).*d));
        % Faltning utf�rs och de nya v�rdena l�ggs in i Blurred.
    end
end
% imshow(Blurred,[]);