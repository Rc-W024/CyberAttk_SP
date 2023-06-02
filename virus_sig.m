% Simulation for CyberAttk. Computer virus simulation signal modulation
close all;
clear;
% zero-padding
zeropad=16;

%% Step 1: Generate a random stream of computer code data to simulate a virus
% code data generation
num_bits=200; % number of binary digits
code_data=randi([0,1],1,num_bits);  % generate random binary data

%disp(code_data);

%% Step 2: Generate a modulation signal
% modulation parameters
%%% adjuste according to the actual situation %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f0=120e9; % Center freq: 120 GHz - THz radar transmitter
fs=10000; % sampling/symbol rate (number of symbols transmitted per s)
modIndex=100; % modulation index that controls the range of frequency variation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=0:1/fs:length(code_data)-1/fs;
mod_sig=zeros(size(t));
for i=1:length(code_data)
    if code_data(i)==1
        mod_sig((i-1)*fs+1:i*fs)=1;
    end
end

TMs=fft(mod_sig,length(mod_sig)*zeropad);
figure;
plot(abs(TMs));
title('FFT of modelation signal')

%% Step 3: Frequency modulation
modulatedSig=cos(2*pi*(f0+modIndex*mod_sig).*t);

TM_s=fft(modulatedSig,length(modulatedSig)*zeropad);
figure;
plot(abs(TM_s));
title('FFT of modelated signal')

%% Print figures...
figure;
subplot(2,2,1);
plot(code_data);
title('Computer code data stream');
subplot(2,2,2);
plot(t,mod_sig);
xlabel('Time');
ylabel('Amplitude');
title('Modulation signal');
subplot(2,2,3:4);
plot(t,modulatedSig);
xlabel('Time');
ylabel('Amplitude');
title('Modulated signal');

