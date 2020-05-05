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
N =8;
EC  = zeros(size(x,1)/N,N*N);

for i  = 1 : N : 256
    for j = 1 : N :256
        y_nofunc     = cos_basis'    * x(i:i+7,j:j+7)  * cos_basis ;
        Y_nofunc(i:i+7,j:j+7) = round(y_nofunc./Quantization_Tables);
        y =dct2(x(i:i+7,j:j+7));
        Y(i:i+7,j:j+7) = round(y./Quantization_Tables);
        EC(ceil(i/N)*31 + ceil(j/N),:) = En_Coding(Y(i:i+7,j:j+7)); %compute Entropy of all figure
    end
end
reg = zeros(2, length(min(min(EC)):max(max(EC))));
reg(1,:) = min(min(EC)):max(max(EC));

for i = 1 : size(EC,1)
    for j = 1 : size(EC,2)
        for k = 1 : size(reg,2)
           if(EC(i,j)==reg(1,k))
               reg(2,k) = reg(2,k) + 1;
           end
        end
    end
end
for i = size(reg,2) : -1 : 1
    if(reg(2,i)==0)
        reg(:,i) = [];
    end
end
reg(2,:) = reg(2,:)/sum(reg(2,:)); % Probability






