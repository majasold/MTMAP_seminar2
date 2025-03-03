function [tocnost] = tenzori_znam (z,D,A1, D1,k)

T=reshape(z,16,16,1707);
T2=reshape(A1,16,16,2007);

% Gaussovo zamucivanje
sigma = 0.9;
hsize = 5;
h = fspecial('gaussian', hsize, sigma);

T_blurred = zeros(20, 20, size(T, 3));
T_blurred2 = zeros(20,20,size(T,3));

for i = 1:size(T, 3)
    slice = T(:,:,i);
    blurred = imfilter(slice, h, 'replicate');
    T_blurred(:,:,i) = imresize(blurred, [20 20], 'bicubic');
end

for i = 1:size(T2, 3)
    slice = T2(:,:,i);
    blurred = imfilter(slice, h, 'replicate');
    T_blurred2(:,:,i) = imresize(blurred, [20 20], 'bicubic');
end


% faza treniranja %

AC = cell(1,10);
U1 = cell(1,10);
U2 = cell(1,10);
U3 = cell(1,10);
S = cell(1,10);
M = cell(1,10);
A = cell(1,10);

for i=1:10
    znam=i-1;
    ZJ=find(D==znam);
    AC{i}=T_blurred(:, :, ZJ); % grupiranje po znamenkama
    [S{i}, U1{i}, U2{i}, U3{i}]=hosvd(AC{i}); % HOSVD
    pom=mnozenje(S{i}, U1{i}, 1);
    M{i}=mnozenje(pom, U2{i}, 2); % bazne matrice za i-1 znamenku
 
    % normalizacija prvih k sliceva po trećem indeksu
    for v = 1:k
        M{i}(:,:,v) = M{i}(:,:,v) / norm(M{i}(:,:,v), 'fro');
    end

end

% faza testiranja %

R=zeros(10,1);
brojac=0;
for i=1:2007
    D = T_blurred2(:,:,i) / norm(T_blurred2(:,:,i), 'fro'); % normalizacija testne znamenke
    for j=1:10
        suma=0;
        for v=1:k
            suma = suma + trace(D' * M{j}(:,:,v))^2;
        end
        R(j)=1-suma; % greska
    end

    min_R=R(1);
    indeks=1;
    for j=2:10
        if R(j)<min_R
            min_R=R(j); % najmanja greska
            indeks=j; 
        end
    end
    znamenka=indeks-1; % znamenka koju je odredio algoritam

    if znamenka==D1(i)
        brojac=brojac+1;
    end
    
end

tocnost=brojac/2007;
