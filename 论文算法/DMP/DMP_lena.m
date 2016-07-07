clear all;

X=imread('lena.bmp');
X1=double(X);
d=dctmtx(16);
dct=@(x)d*x*d';
B=blkproc(X1,[16,16],dct);                                                    %��ÿ��16x16�ֿ��С�������DCT�任
mask=[1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0;....
      1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0;....
      1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0;...
      1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0;...
      1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0;....
      1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0;...
      1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0;...
      1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0;...
      1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
      1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
      1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
      ];
   
   
   
% B2=blkproc(B,[16,16],@(x)mask.*x);   %ÿ���ֿ鱣�����ϲ���ϵ����������0���������ϡ���źż�ϡ���KΪ36��
C=im2col(B,[16 16],'distinct');%ÿ���ֿ��ų�һ�У�ÿ�г���256
M=64;
N=256;
% ���������ѡ��˹����������������
%��˹���������������
phi=randn(M,N);
%�������������
% a=hadamard(N);
% q=randperm(N);
% phi=a(q(1:M),:);
%����
Y=phi*C;
G=zeros(N,N);  %  �Ƚ����ָ�����Ŀվ���
% OMP�㷨�ع�
t0=clock;%�����ʱ��ʼ
for i=1:N  %  ��ѭ��
    i
    PSI=[phi,Y(:,i)]'*[phi,Y(:,i)];
    [~,rec,~,~]=DMP(PSI,256,32,eps);
%     rec=cs_omp(Y(:,i),phi,36);%ÿһ��������OMP�㷨�ع�
   G(:,i)=rec;
end
G2=col2im(G,[16 16],[256 256],'distinct');
inv=@(x)d'*x*d;
X2=blkproc(G2,[16 16],inv);%ͼ��ֿ�DCT��任
X2=uint8(X2);
figure(1);
subplot(121);imshow(X)
xlabel('ԭʼͼ��');
subplot(122);imshow(X2)
xlabel('�ع�ͼ��');
%Ϊ�˱��ڼ�������С�������Ͷ���ֵӰ�죬ͳһת����double���ͣ���norm������uint8 ������Ч
 X=double(X);
 X2=double(X2);
disp('��ʾ���')
% ������
%Relative_error=sqrt(sum(sum(abs(X2-X).^2)))/sqrt(sum(sum(abs(X).^2)))
 Relative_error=norm(X2-X)/norm(X) 

 %  MSE��� Ҳ����MSE=norm(X2-X).^2/��256*256��
MSE=sum(sum(abs(X2-X).^2))/(256*256)   
 %  PSNR
PSNR=10*log10(255*255/MSE) 
t1=clock;
t=etime(t1,t0)
%�����ʱ

