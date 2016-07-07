clc
clear

M=128;
X_init=imread('lena.bmp');
X_init=double(X_init);
[N,repeats]=size(X_init);

W=DWT(N);

X_dwt=full(W*sparse(X_init)*W');
% X_dwt1=X_dwt;
% X_dwt=zeros(N,N);
% X_dwt(1:K,1:K)=X_dwt1(1:K,1:K);


X_dwt=im2col(X_dwt,[16,16],'distinct');
X_dwt=X_dwt';


PHI=randn(M,N);

Y=PHI*X_dwt;

X_cs=zeros(N,repeats);

for t=1:repeats
    t
    
%     PSI=[PHI,Y(:,t)]'*[PHI,Y(:,t)];
%     [~,x_cs,~,~]=DMP(PSI,256,64,eps);
    [~,x_cs]=OMP(PHI,Y(:,t),64);

    X_cs(:,t)=x_cs;
end

X_cs=X_cs';
X_cs=col2im(X_cs,[16,16],[256,256],'distinct');

X_recover=full(W'*sparse(X_cs)*W);

%  ���(PSNR)
errorx=sum(sum(abs(X_recover-X_init).^2));        %  MSE���
psnr=10*log10(255*255/(errorx/N/repeats));   %  PSNR

%ԭʼͼ��
figure(1);
% subplot(1,2,1);
% imshow(uint8(X_init));
% title('ԭʼͼ��');
% 
% subplot(1,2,2);
imshow(uint8(X_recover));
title(['�ָ���ͼ��  ����ȣ�',num2str(psnr)]);


%  �任ͼ��
figure(2);
imshow(uint8(X_dwt));
title('С���任���ͼ��');
