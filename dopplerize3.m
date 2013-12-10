function[] = dopplerize3(V, D, L)
%% DOPPLERIZE3 Funktion f�r att simulera dopplereffekten
%   V �r hastigheten p� den r�rliga ljudk�llan, D �r riktning som ljudk�llan
%   kommer ifr�n (1=v�nster, 2=h�ger), och L �r avst�ndet till ljudk�llan.
%   Bra exempelv�rden: V=20, D=1, L=15. F�r stor skillnad mellan V och L
%   och v�ldigt h�ga V och/eller L-v�rden ger �ven intressanta effekter..
%   Exempelvis V=1000 och L=10

%% Variablerna best�ms 
Fs = 44100; % Sampelhastigheten, 44.1kHz
C = 343; % Ljudets hastighet, M/s
V = V; % Hastighet, M/s
F_0 = 220; % Grundfrekvens av v�gen, 220Hz
A = 1; % V�gens amplitud
t = 2; % L�ngden av ljudklippet, i sekunder
y =L; % Avst�ndet mellan betraktare och ljudk�llan d� ljudk�llan �r rakt framf�r betraktaren
d = V*t; % L�ngden av ljudk�llans r�relse

%% Ber�kna hur ljudet uppfattas av betraktaren under r�relsen
Vec_x = linspace(-d/2, d/2, 2*t*Fs); % Vektor med v�rden om ljudk�llans placering 
                                     % relativt till str�ckans mittpunkt under
                                     % r�relsen.
alpha = atan2(y, Vec_x); % Vinkeln i radianer mellan betraktare och ljudk�llan under r�relsen
V_s = V.*cos(alpha); % Vektor med hastighetsinformation av ljudk�llan relativt till betraktaren
freq_coeff = C./(C+V_s);% Vektor med koefficienter f�r frekvensf�r�ndringen 
                          % d� ljudk�llan r�r sig.
freq_rel = F_0.*freq_coeff; % Vektor med v�rden om hur frekvensen uppfattas 
                            % av betraktaren n�r ljudk�llan r�r sig.

%% Volymf�r�ndringar, f�r att uppn� illusionen att ljudk�llan �ker f�rbi.
volUp = 0:1/(t*Fs):A; 
volUp = volUp.^2; % �ka volym fr�n noll till full
volDown = volUp(end:-1:A); % S�nk volym fr�n full till noll
volInc = 0:1/(t*Fs):A;
volInc = volInc.^(V/t); % Exponentiell �kning av volym som anpassar sig efter V och t (godtyckligt)
volDec = volInc(end:-1:1); % Exp. minskning av volym

%% Skapa ljuden f�r varsitt �ra
aud_1(1,1:2*t*Fs) = 0; % Allokera en vektor av l�ngd 2*t*Fs med nollor
aud_2(1,1:2*t*Fs) = 0; % Allokera en vektor av l�ngd 2*t*Fs med nollor
T = linspace(0,2*t,2*t*Fs); % Vektor med v�rden p� tid, med 2*t*Fs intervall
plot(T,freq_rel) % Plotta hur frekvensen f�r�ndras

% Ljudet n�r ljudk�llan kommer mot betraktaren
aud_1(1:t*Fs) = sin(2*pi*freq_rel(1:end/2).*T(1:end/2)).*volUp(1:t*Fs);
aud_2(1:t*Fs) = sin(2*pi*freq_rel(1:end/2).*T(1:end/2)).*volInc(1:t*Fs);

%Ljudet n�r ljudk�llan �ker fr�n betraktaren
aud_1(1+t*Fs:end) = sin(2*pi*freq_rel((end/2)+1:end).*T((end/2)+1:end)).*volDec(1:t*Fs);
aud_2(1+t*Fs:end) = sin(2*pi*freq_rel((end/2)+1:end).*T((end/2)+1:end)).*volDown(1:t*Fs);

%% Best�m fr�n vilket h�ll ljudk�llan ska komma
if D==1
    S(1,:)= aud_1; % L�gg in aud_1 i v�nster kanal
    S(2,:) = aud_2; % L�gg in aud_2 i h�ger kanal
elseif D==2
    S(2,:)= aud_1;
    S(1,:) = aud_2;
end

%% Spela upp ljudet
sound(S, Fs); % Spela upp ljudet med sampelhastigheten Fs