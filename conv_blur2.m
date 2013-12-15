function [ Blurred ] = conv_blur2( I,d )
rows = size(I,1); % Antal pixelrader i x-led för input-bilden.
cols = size(I,2); % Antal pixelrader i y-led för input-bilden.
krows = size(d,1); % Antal pixelrader i x-led för kärnan.
kcols = size(d,2); % Antal pixelrader i y-led för kärnan.
kcenter = floor((size(d)+1)/2); % Index för kärnans mittvärde.
l = kcenter(2)-1;
r = kcols-kcenter(2); % Hämta hur många steg det är till kanterna,
o = kcenter(1)-1;     % anpassar sig till hur stor kärnan är.
u = krows-kcenter(1);
NewMatrix = zeros(rows+o+u, cols+l+r); % Skapar matris med lämpligt antal
                                       % extrarader/kolumner beroende på
                                       % kärnans storlek.
for i = 1+o:rows+o % Intervallet som är själva bilden.
    for j = 1+l:cols+r % Intervallet som är själva bilden.
        NewMatrix(i,j) = I(i-o, j-l); % Lägg in inputbilden i mitten av 
                                      % nya matrisen.
    end
end
Blurred = zeros(rows, cols); % Skapa matris i input-bildens storlek.

for x = 1:rows-o
    for y = 1:cols-l
        Blurred(x,y) = sum(sum(NewMatrix(x+l:x+l-1+krows, y+o:y+o-1+kcols).*d));
        % Faltning utförs och de nya värdena läggs in i Blurred.
    end
end
% imshow(Blurred,[]);