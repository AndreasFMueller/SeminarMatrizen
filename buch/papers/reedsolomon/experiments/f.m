#
# f.m -- Reed-Solomon-Visualisierung mit FFT
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
N = 64;
b = 32;
l = N + b;

signal = zeros(l,1);
signal(1:N,1) = round(10 * rand(N,1));
signal

codiert = fft(signal)

plot(abs(signal));
xlim([1, l]);
title("Signal");
pause()

fehler = zeros(l,1);
fehler(21,1) = 2;
fehler(75,1) = 1;
fehler(7,1) = 2;

plot(fehler);
xlim([1, l]);
title("Fehler");
pause()

empfangen = codiert + fehler;

plot(abs(empfangen));
xlim([1, l]);
title("Empfangen");
pause()

decodiert = ifft(empfangen)
plot(abs(decodiert));
xlim([1, l]);
title("Decodiert");
pause()

syndrom = decodiert;
syndrom(1:N,1) = zeros(N,1)
plot(abs(syndrom));
xlim([1, l]);
title("Syndrom");
pause()

locator = abs(fft(syndrom))

plot(locator);
xlim([1, l]);
title("Locator");
pause()
