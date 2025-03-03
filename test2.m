load azip.mat
load dzip.mat
load testzip.mat
load dtest.mat
z=azip; 
D=dzip;
A1=testzip; %z
D1=dtest; %znam

tocnost=zeros(1, 10);
p=64;
q=64;

for k=10:19

    tocnost(k-9)=algoritam2(z,D,A1, D1,k,p,q);

end

k_values = 10:19;   

% crtanje grafičkog prikaza
figure;
plot(k_values, tocnost, 'ro-', 'MarkerFaceColor', 'r', 'LineWidth', 2);

% postavljanje oznaka osi i naslova
xlabel('Broj k');
ylabel('Točnost');
title('Ovisnost točnosti o broju k za p=q=64');
grid on;
