function [ output_args ] = videoproc(mov, d)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
readerobj = VideoReader('retard.mp4');
vidFrames = read(readerobj);
numFrames = get(readerobj, 'NumberOfFrames');
for k=1:numFrames
    mov(k).cdata = vidFrames(:,:,:,k);
    mov(k).colormap = [];
end
rows = size(vidFrames,1);
cols = size(vidFrames,2);
dims = size(vidFrames,3);
krows = size(d,1); % Antal pixelrader i x-led för kärnan.
kcols = size(d,2); % Antal pixelrader i y-led för kärnan.
% kdims = size(d,3);
kcenter = floor((size(d)+1)/2); % Index för kärnans mittvärde.
kcenterdim = 2;
l = kcenter(2)-1;
r = kcols-kcenter(2); % Hämta hur många steg det är till kanterna,
o = kcenter(1)-1;     % anpassar sig till hur stor kärnan är.
u = krows-kcenter(1);
f = kcenterdim;
b = kcenterdim;

NewMatrix = zeros(rows+o+u, cols+l+r, dims+f+b); % Skapar matris med lämpligt antal
                                       % extrarader/kolumner beroende på
                                       % kärnans storlek.

for i = 1+o:rows+o % Intervallet som är själva bilden.
    for j = 1+l:cols+r % Intervallet som är själva bilden.
        for k = 1+f:dims+b
            NewMatrix(i,j,k) = vidFrames(i-o, j-l, k-f, l); % Lägg in inputbilden i mitten av 
            
        end                                                 % nya matrisen.
    end
end

n = 1
for i = 1:numFrames
    Blurred = zeros(rows, cols, dims); % Skapa matris i input-bildens storlek.
    n = n+1
    for x = 1:rows
        for y = 1:cols
            for z = 1:dims
                for i = 1:krows
                    for j = 1:kcols
%                         for k = 1:kdims
                        Blurred(x,y,z) = Blurred(x,y,z) + (NewMatrix(i+(x-1), j+(y-1), 1+(z-1))*d(i,j,1));
                        % Faltning utförs och de nya värdena läggs in i Blurred.
%                         end
                    end
                end
            end
        end
    end
    mov(1,i).cdata = Blurred;
    
end



%% Uppspelning
hf = figure;
set(hf, 'position', [150 150 readerobj.Width readerobj.Height])
movie(hf, mov, 1, readerobj.FrameRate);

end

