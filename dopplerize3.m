function[] = dopplerize3(V, D, L)
%% DOPPLERIZE3 Funktion för att simulera dopplereffekten
%   V är hastigheten på den rörliga ljudkällan, D är riktning som ljudkällan
%   kommer ifrån (1=vänster, 2=höger), och L är avståndet till ljudkällan.
%   Bra exempelvärden: V=20, D=1, L=15. För stor skillnad mellan V och L
%   och väldigt höga V och/eller L-värden ger även intressanta effekter..
%   Exempelvis V=1000 och L=10

%% Variablerna bestäms 
Fs = 44100; % Sampelhastigheten, 44.1kHz
C = 343; % Ljudets hastighet, M/s
V = V; % Hastighet, M/s
F_0 = 220; % Grundfrekvens av vågen, 220Hz
A = 1; % Vågens amplitud
t = 2; % Längden av ljudklippet, i sekunder
y =L; % Avståndet mellan betraktare och ljudkällan då ljudkällan är rakt framför betraktaren
d = V*t; % Längden av ljudkällans rörelse

%% Beräkna hur ljudet uppfattas av betraktaren under rörelsen
Vec_x = linspace(-d/2, d/2, 2*t*Fs); % Vektor med värden om ljudkällans placering 
                                     % relativt till sträckans mittpunkt under
                                     % rörelsen.
alpha = atan2(y, Vec_x); % Vinkeln i radianer mellan betraktare och ljudkällan under rörelsen
V_s = V.*cos(alpha); % Vektor med hastighetsinformation av ljudkällan relativt till betraktaren
freq_coeff = C./(C+V_s);% Vektor med koefficienter för frekvensförändringen 
                          % då ljudkällan rör sig.
freq_rel = F_0.*freq_coeff; % Vektor med värden om hur frekvensen uppfattas 
                            % av betraktaren när ljudkällan rör sig.

%% Volymförändringar, för att uppnå illusionen att ljudkällan åker förbi.
volUp = 0:1/(t*Fs):A; 
volUp = volUp.^2; % Öka volym från noll till full
volDown = volUp(end:-1:A); % Sänk volym från full till noll
volInc = 0:1/(t*Fs):A;
volInc = volInc.^(V/t); % Exponentiell ökning av volym som anpassar sig efter V och t (godtyckligt)
volDec = volInc(end:-1:1); % Exp. minskning av volym

%% Skapa ljuden för varsitt öra
aud_1(1,1:2*t*Fs) = 0; % Allokera en vektor av längd 2*t*Fs med nollor
aud_2(1,1:2*t*Fs) = 0; % Allokera en vektor av längd 2*t*Fs med nollor
T = linspace(0,2*t,2*t*Fs); % Vektor med värden på tid, med 2*t*Fs intervall
plot(T,freq_rel) % Plotta hur frekvensen förändras

% Ljudet när ljudkällan kommer mot betraktaren
aud_1(1:t*Fs) = sin(2*pi*freq_rel(1:end/2).*T(1:end/2)).*volUp(1:t*Fs);
aud_2(1:t*Fs) = sin(2*pi*freq_rel(1:end/2).*T(1:end/2)).*volInc(1:t*Fs);

%Ljudet när ljudkällan åker från betraktaren
aud_1(1+t*Fs:end) = sin(2*pi*freq_rel((end/2)+1:end).*T((end/2)+1:end)).*volDec(1:t*Fs);
aud_2(1+t*Fs:end) = sin(2*pi*freq_rel((end/2)+1:end).*T((end/2)+1:end)).*volDown(1:t*Fs);

%% Bestäm från vilket håll ljudkällan ska komma
if D==1
    S(1,:)= aud_1; % Lägg in aud_1 i vänster kanal
    S(2,:) = aud_2; % Lägg in aud_2 i höger kanal
elseif D==2
    S(2,:)= aud_1;
    S(1,:) = aud_2;
end

%% Spela upp ljudet
sound(S, Fs); % Spela upp ljudet med sampelhastigheten Fs