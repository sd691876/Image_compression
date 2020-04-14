x = double(imread('cameraman.tif'));
imshow(uint8(x));
N = 8;
n         = 1:N;
u         = 0:N-1;
tic;
cos_basis = zeros(N);
for i = u
    cos_basis(i+1,:) = sqrt(2/N).*cos((2.*(n-1)+1)*i*pi/(2*N)); % B'
end
cos_basis(1,:) = cos_basis(1,:)/sqrt(2); %B'
cos_basis      = cos_basis'; %B
toc;
%----------------------------method 1 ------------------------------------%
% method 1: DCT
%{
figure;
y     = cos_basis    * x'  * cos_basis' ;
mesh(y);
for i = size(y,1):-5:1
    y(i:end,i:end) = 0;
    x_bar = cos_basis'   * y'  * cos_basis; %IDCT x = B  * y
    imshow(uint8(x_bar));
    error(ceil(i/5)) = mean(mean((x-x_bar).^2));
end
plot(log10(error));
%}
Quantization_Tables = [16 11 10 16  24  40  51  61
                       12 12 14 19  26  58  60  55
                       14 13 16 24  40  57  69  56
                       14 17 22 29  51  87  80  62
                       18 22 37 56  68 109 103  77
                       24 35 55 64  81 104 113  92
                       49 64 78 87 103 121 120 101
                       72 92 95 98 112 100 103  99];
                   
Y = zeros(size(x,1),size(x,2));
Y_nofunc = zeros(size(x,1),size(x,2));
for i  = 1 : 8 : 256
    for j = 1 : 8 :256
        y_nofunc     = cos_basis'    * x(i:i+7,j:j+7)  * cos_basis ;
        Y_nofunc(i:i+7,j:j+7) = round(y_nofunc./Quantization_Tables);
        y =dct2(x(i:i+7,j:j+7));
        Y(i:i+7,j:j+7) = round(y./Quantization_Tables);
    end
end
%-----------------------decoder-------------------------------------------%

de_x = zeros(size(x,1),size(x,2));
de_x_nofunc = zeros(size(x,1),size(x,2));
for i  = 1 : 8 : 256
    for j = 1 : 8 :256
        de_y = Y(i:i+7,j:j+7).*Quantization_Tables;
        de_x(i:i+7,j:j+7) = idct2(de_y);
        de_y_nofunc = Y_nofunc(i:i+7,j:j+7).*Quantization_Tables;
        de_x_nofunc(i:i+7,j:j+7) = cos_basis   * de_y_nofunc  * cos_basis';
    end
end
figure;
subplot(121) ; imshow(uint8(de_x));
title('de_x');
subplot(122) ; imshow(uint8(de_x_nofunc));
title('de_x nofunc');
Mse = mean(mean((x-de_x).^2))
Psnr = 10 * log10((255.^2)/Mse)