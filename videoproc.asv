function [ output_args ] = videoproc()
readerobj = VideoReader('earths.mp4');
vidFrames = read(readerobj);
numFrames = get(readerobj, 'NumberOfFrames');

%% Lowpass
% vidobj = VideoWriter('retardlowpass','MPEG-4');
% open(vidobj);
% h = ones(10)/100;
% for f = 1:numFrames
%     currframe = zeros(360,480,3);
%     for d = 1:3
%         currframe(:,:,d) = vidFrames(:,:,d,f);
%     end
%     currframe = imfilter(currframe,h);
%     currframe = uint8(currframe);
%     writeVideo(vidobj,currframe);
% end
% close(vidobj);

%% Highpass
% vidobj = VideoWriter('retardhighpass','MPEG-4');
% open(vidobj);
% h = ones(10)/100;
% for f = 1:numFrames
%     currframe = zeros(360,480,3);
%     for d = 1:3
%         currframe(:,:,d) = vidFrames(:,:,d,f);
%     end
%     currframe = currframe-imfilter(currframe,h);
% %     currframe(currframe<0) = 0;
%     currframe = uint8(currframe);
%     writeVideo(vidobj,currframe);
% end
% close(vidobj);

%% Kantdetektion
% vidobj = VideoWriter('retardedge','MPEG-4');
% open(vidobj);
% for f = 1:numFrames
%     currframe = zeros(360,480,3);
%     for d = 1:3
%         currframe(:,:,d) = vidFrames(:,:,d,f);
%     end
%     currframe = sobelVid(currframe);
%     currframe = uint8(currframe);
%     writeVideo(vidobj,currframe);
% end
% close(vidobj);

%% Chroma key
vidobj = VideoWriter('earthchroma','MPEG-4');
open(vidobj);
bg = double(imread('space.jpg'));
[rr, cc] = meshgrid(1:readerobj.Width,1:readerobj.Height,1:3);
mask = (sqrt((rr-(readerobj.Height/1.2)).^2+(cc-(readerobj.Height/2)).^2)<=270); % Skapar en cirkel med ettor
invmask = ones(readerobj.Height, readerobj.Width,3)-mask; % Inverterade masken, resten av bilden är ettor, cirkeln är nollor då vi inte vill räkna med jordgloben
subplot(2,2,1),imshow(invmask);

for f = 1:numFrames
    currframe = zeros(readerobj.Height,readerobj.Width,3);
    for d = 1:3
        currframe(:,:,d) = vidFrames(:,:,d,f);
%         if d == 2
        alphamask = zeros(readerobj.Height, readerobj.Width,3);
        alphamask(190<(currframe.*invmask) & (currframe.*invmask)<225) = 1; % Ett färgintensitetsintervall mellan 205-220.
        subplot(2,2,2),imshow(alphamask);
        subplot(2,2,3:4),imshow(currframe);
%             currframe = currframe.*alphamask;
%         end
    end
    currframe = uint8(currframe);
    writeVideo(vidobj,currframe);
end
close(vidobj);

%% Uppspelning
% hf = figure;
% set(hf, 'position', [150 150 readerobj.Width readerobj.Height])
% movie(hf, blurred, 1, readerobj.FrameRate);