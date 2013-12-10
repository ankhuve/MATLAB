function [] = delay(dlytime,Ear,volright,volleft)
%dlytime = Delaytid i ms

%E = Vilket �ra delayen ska l�ggas p� (1=v�nster, 2=h�ger)

% H och V �r f�rh�llanden i ljudvolym mellan H�ger och v�nster �ra t.ex H=1
% & V=2, volymen i v�nster �ra �r dubbelt s� stark som i H�ger. Om ljudet
% blir f�r starkt g�r �ven decimaltal att anv�nda t.ex H=0.2 & V=1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% f�jande g�r om wav-filen fr�n mono till stereo ifall det
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% skulle beh�vas
a = input('what is the name of your wav file?')  
[Data, Fs, NBits, Opts] = wavread(a); %l�ser av filens Data, samplingsfrekvens, bitar/sampel, och �vrig info.
if size(wavread(a),2)==1
    c=[wavread(a) wavread(a)]; % g�r om vektorn fr�n size Nx1 till Nx2 d�r N �r vektorns storlek 
    wavwrite(c,Fs,NBits,a);
    disp('your wav-file has been converted from mono to stereo, please run the program again')
    clear sound
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dly = ceil(dlytime * 10^-3 * Fs); % G�r delaytiden som du inmatat till ms
DataDly = zeros(size(Data,1)+dly, 2);% skapar en tom matris som �r (l�ngden av ljudfilen)+(l�ngden av delayen)
d1 = dly:size(Data,1)+dly-1; % skapar ett index f�r var delayen ska b�rja, alla v�rden innan har amplituden 0.
d2 = 1:size(Data,1); %samma som ovanst�ende bara att nollorna s�tts i slutet 

if Ear==1; %delayen l�ggs p� v�nster �ra
    DataDly(d1,1) = volleft*Data(:,1);
    sound(DataDly, Fs)
    DataDly(d2,2) = volright*Data(:,2);
elseif Ear==2;%delayen l�ggs p� h�ger �ra
    DataDly(d2,1) = volleft*Data(:,1);
    DataDly(d1,2) = volright*Data(:,2);    
end

y=1;
B=input('Do you want to stop the sound/program? (press y): ')
if B==1
    clear sound %stoppar programmet genom att trycka y sedan enter
    
end


