load azip.mat
load dzip.mat
load testzip.mat
load dtest.mat
z=azip; 
D=dzip;
A1=testzip; %z
D1=dtest; %znam

tocnost=zeros(1, 21);

for k=10:30

    tocnost(k-9)=tenzori_znam(z,D,A1, D1,k);

end

k_values = 10:30;   

% crtanje grafičkog prikaza
figure;
plot(k_values, tocnost, 'ro-', 'MarkerFaceColor', 'r', 'LineWidth', 2);

% postavljanje oznaka osi i naslova
xlabel('Broj k');
ylabel('Točnost');
title('Ovisnost točnosti o broju k');
grid on;
