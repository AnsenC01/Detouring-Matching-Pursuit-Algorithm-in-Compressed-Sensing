figure(1)
subplot(2,1,1);
hold on
plot(dmp_success,'r');
xlabel('ϡ��� K');
ylabel('׼ȷ�ָ�����');
legend('dmp');
grid on;
title(['M=',num2str(M),' N=',num2str(N),' repeats=',num2str(repeats)]);
subplot(2,1,2);
hold on
plot(dmp_time_mean,'r');
xlabel('ϡ��� K');
ylabel('ƽ���ع�����ʱ��');
legend('dmp');
grid on;
title(['M=',num2str(M),' N=',num2str(N),' repeats=',num2str(repeats)]);