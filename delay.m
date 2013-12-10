function [] = delay(dlytime,Ear,volright,volleft)
%dlytime = Delaytid i ms

%E = Vilket öra delayen ska läggas på (1=vänster, 2=höger)

% H och V är förhållanden i ljudvolym mellan Höger och vänster öra t.ex H=1
% & V=2, volymen i vänster öra är dubbelt så stark som i Höger. Om ljudet
% blir för starkt går även decimaltal att använda t.ex H=0.2 & V=1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% föjande gör om wav-filen från mono till stereo ifall det
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% skulle behövas
a = input('what is the name of your wav file?')  
[Data, Fs, NBits, Opts] = wavread(a); %läser av filens Data, samplingsfrekvens, bitar/sampel, och övrig info.
if size(wavread(a),2)==1
    c=[wavread(a) wavread(a)]; % gör om vektorn från size Nx1 till Nx2 där N är vektorns storlek 
    wavwrite(c,Fs,NBits,a);
    disp('your wav-file has been converted from mono to stereo, please run the program again')
    clear sound
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dly = ceil(dlytime * 10^-3 * Fs); % Gör delaytiden som du inmatat till ms
DataDly = zeros(size(Data,1)+dly, 2);% skapar en tom matris som är (längden av ljudfilen)+(längden av delayen)
d1 = dly:size(Data,1)+dly-1; % skapar ett index för var delayen ska börja, alla värden innan har amplituden 0.
d2 = 1:size(Data,1); %samma som ovanstående bara att nollorna sätts i slutet 

if Ear==1; %delayen läggs på vänster öra
    DataDly(d1,1) = volleft*Data(:,1);
    sound(DataDly, Fs)
    DataDly(d2,2) = volright*Data(:,2);
elseif Ear==2;%delayen läggs på höger öra
    DataDly(d2,1) = volleft*Data(:,1);
    DataDly(d1,2) = volright*Data(:,2);    
end

y=1;
B=input('Do you want to stop the sound/program? (press y): ')
if B==1
    clear sound %stoppar programmet genom att trycka y sedan enter
    
end


