% fprintf('%8s%10.4f\n','1114',max(out.U1114xy))
% fprintf('%8s%10.4f\n','1124',max(out.U1124xy))
% fprintf('%8s%10.4f\n','1134',max(out.U1134xy))
% fprintf('%8s%10.4f\n','1118',max(out.U1118xy))
% fprintf('%8s%10.4f\n','1128',max(out.U1128xy))
% fprintf('%8s%10.4f\n','1138',max(out.U1138xy))
%%
% stima velocità centerline
% fprintf('%8s%10.4f\n','2214',max(out.U2214xy))
% fprintf('%8s%10.4f\n','2224',max(out.U2224xy))
% fprintf('%8s%10.4f\n','2234',max(out.U2234xy))
% % fprintf('%8s%10.4f\n','2218',max(out.U2218xy))
% % fprintf('%8s%10.4f\n','2228',max(out.U2228xy))
% % fprintf('%8s%10.4f\n','2238',max(out.U2238xy))
% fprintf('%8s%10.4f\n','2314',max(out.U2314xy))
% fprintf('%8s%10.4f\n','2324',max(out.U2324xy))
% fprintf('%8s%10.4f\n','2334',max(out.U2334xy))
% % fprintf('%8s%10.4f\n','2318',max(out.U2318xy))
% % fprintf('%8s%10.4f\n','2328',max(out.U2328xy))
% % fprintf('%8s%10.4f\n','2338',max(out.U2338xy))

U_max_vec_2 = [max(out.U2214xy) max(out.U2224xy) max(out.U2234xy) max(out.U2314xy) max(out.U2324xy) max(out.U2334xy)];
U_max_mean_2 = mean(U_max_vec_2);
U_max_vec_1 = [max(out.U1114xy) max(out.U1124xy) max(out.U1134xy)];
U_max_mean_1 = mean(U_max_vec_1);

%%
DNS_Re2_file = '../dati/360_Re_1.dat';
DNS_Re2_dati = readmatrix(DNS_Re2_file);
% DNS_Re3_file = '../dati/550_Re_1.dat';
% DNS_Re3_dati = readmatrix(DNS_Re3_file);
% DNS_Re4_file = '../dati/1000_Re_1.dat';
% DNS_Re4_dati = readmatrix(DNS_Re4_file);

%% partiamo dal confronto con LDV
% figure('Name','LDV1')
% plot(((R-(out.r2218xy(52:501)-out.r2218xy(52)))./D), out.U2218xy(52:501)./U_max_mean_2,'r-', 'LineWidth',2)
% hold on
% plot(((R-(out.r2228xy(52:501)-out.r2228xy(52)))./D), out.U2228xy(52:501)./U_max_mean_2,'b-', 'LineWidth',2)
% hold on
% plot(((R-(out.r2238xy(52:501)-out.r2238xy(52)))./D), out.U2238xy(52:501)./U_max_mean_2,'c-', 'LineWidth',2)
% hold on
% plot((R-y_LDV)/D, U_LDV_mean/U_max_mean_2, 'go','linewidth',2)
% hold on
% % plot((R-y_LDV)/D, U_LDV_mean_filt/U_max_mean_2, 'co','linewidth',2)
% % hold on
% xline(0.45,'--k','LineWidth',2.5)
% legend('LPT ppp1','LPT ppp2','LPT ppp3','LDV') %'LDV filtered')
% xlabel('r/D','fontsize',15)
% ylabel('U_z/U_c','fontsize',20)
% title('Comparison LPT,f1,up vs LDV, grid 8 ')
% 
% 
% figure('Name','LDV2')
% plot(((R-(out.r2214xy(1:471)-out.r2214xy(1)))./D), out.U2214xy(1:471)./U_max_mean_2,'r-', 'LineWidth',2)
% hold on
% plot(((R-(out.r2224xy(36:512)-out.r2224xy(36)))./D), out.U2224xy(36:512)./U_max_mean_2,'b-', 'LineWidth',2)
% hold on
% plot(((R-(out.r2234xy(15:491)-out.r2234xy(15)))./D), out.U2234xy(15:491)./U_max_mean_2,'-', 'LineWidth',2)
% hold on
% plot((R-y_LDV)/D, U_LDV_mean/U_max_mean_2, 'go','linewidth',2)
% hold on
% % plot((R-y_LDV)/D, U_LDV_mean_filt/U_max_mean_2, 'co','linewidth',2)
% hold on
% xline(0.45,'--k','LineWidth',2.5)
% % legend('LPT ppp1','LPT ppp2','LPT ppp3','LDV','LDV filtered')
% legend('LPT ppp1','LPT ppp2','LPT ppp3','LDV')
% xlabel('r/D','fontsize',15)
% ylabel('U_z/U_c','fontsize',20)
% title('Comparison LPT,f1,up vs LDV, grid 4')
% 
% 
% figure('Name','LDV3')
% plot((R-y_LDV)/D, U_LDV_mean/U_max_mean_2, 'go','linewidth',2)
% hold on
% % plot((R-y_LDV)/D, U_LDV_mean_filt/U_max_mean_2, 'co','linewidth',2)
% hold on
% plot(((R-(out.r2218xy(950)-out.r2218xy(501:950)))./D), out.U2218xy(501:950)./U_max_mean_2,'r', 'LineWidth',2)
% hold on
% plot(((R-(out.r2228xy(950)-out.r2228xy(501:950)))./D), out.U2228xy(501:950)./U_max_mean_2,'b', 'LineWidth',2)
% hold on
% plot(((R-(out.r2238xy(950)-out.r2238xy(501:950)))./D), out.U2238xy(501:950)./U_max_mean_2,'c', 'LineWidth',2)
% hold on
% xline(0.45,'--k','LineWidth',2.5)
% % legend('LDV','LDV filtered','ppp1','ppp2','ppp3')
% legend('LDV','ppp1','ppp2','ppp3')
% xlabel('r/D','fontsize',15)
% ylabel('U_z/U_c','fontsize',20)
% % title('comparison LPT,f1,low, grid 8 vs LDV')
% 
% 
% figure('Name','LDV4')
% plot((R-y_LDV)/D, U_LDV_mean/U_max_mean_2, 'go','linewidth',2)
% hold on
% % plot((R-y_LDV)/D, U_LDV_mean_filt/U_max_mean_2, 'co','linewidth',2)
% hold on
% plot(((R-(out.r2214xy(947)-out.r2214xy(471:947)))./D), out.U2214xy(471:947)./U_max_mean_2,'r', 'LineWidth',2)
% hold on
% plot(((R-(out.r2224xy(987)-out.r2224xy(512:987)))./D), out.U2224xy(512:987)./U_max_mean_2,'b', 'LineWidth',2)
% hold on
% plot(((R-(out.r2234xy(967)-out.r2234xy(491:967)))./D), out.U2234xy(491:967)./U_max_mean_2,'c', 'LineWidth',2)
% hold on
% xline(0.45,'--k','LineWidth',2.5)
% % legend('LDV','LDV filtered','ppp1','ppp2','ppp3')
% legend('LDV','ppp1','ppp2','ppp3')
% xlabel('r/D','fontsize',15)
% ylabel('U_z/U_c','fontsize',20)
% % title('comparison LPT,f1,low grid 4 vs LDV')
% 
% 
% figure('Name','LDV5')
% plot(((R-(out.r2318xy(52:501)-out.r2218xy(52)))./D), out.U2218xy(52:501)./U_max_mean_2,'r-', 'LineWidth',2)
% hold on
% plot(((R-(out.r2328xy(52:501)-out.r2228xy(52)))./D), out.U2228xy(52:501)./U_max_mean_2,'b-', 'LineWidth',2)
% hold on
% plot(((R-(out.r2338xy(52:501)-out.r2238xy(52)))./D), out.U2238xy(52:501)./U_max_mean_2,'c-', 'LineWidth',2)
% hold on
% plot((R-y_LDV)/D, U_LDV_mean/U_max_mean_2, 'go','linewidth',2)
% hold on
% % plot((R-y_LDV)/D, U_LDV_mean_filt/U_max_mean_2, 'co','linewidth',2)
% hold on
% xline(0.45,'--k','LineWidth',2.5)
% legend('LPT ppp1','LPT ppp2','LPT ppp3','LDV') %,'LDV filtered')
% xlabel('r/D','fontsize',15)
% ylabel('U_z/U_c','fontsize',20)
% title('Comparison LPT,f2,up vs LDV, grid 8 ')
% 
% 
% figure('Name','LDV6')
% plot(((R-(out.r2314xy(35:511)-out.r2314xy(35)))./D), out.U2314xy(35:511)./U_max_mean_2,'r-', 'LineWidth',2)
% hold on
% plot(((R-(out.r2324xy(12:488)-out.r2324xy(12)))./D), out.U2324xy(12:488)./U_max_mean_2,'b-', 'LineWidth',2)
% hold on
% plot(((R-(out.r2334xy(15:491)-out.r2334xy(15)))./D), out.U2334xy(15:491)./U_max_mean_2,'c-', 'LineWidth',2)
% hold on
% plot((R-y_LDV)/D, U_LDV_mean/U_max_mean_2, 'go','linewidth',2)
% hold on
% % plot((R-y_LDV)/D, U_LDV_mean_filt/U_max_mean_2, 'co','linewidth',2)
% hold on
% xline(0.45,'--k','LineWidth',2.5)
% legend('LPT ppp1','LPT ppp2','LPT ppp3','LDV') %,'LDV filtered')
% xlabel('r/D','fontsize',15)
% ylabel('U_z/U_c','fontsize',20)
% title('Comparison LPT,f2,up vs LDV, grid 4')
% 
% 
% figure('Name','LDV7')
% plot((R-y_LDV)/D, U_LDV_mean/U_max_mean_2, 'go','linewidth',2)
% hold on
% % plot((R-y_LDV)/D, U_LDV_mean_filt/U_max_mean_2, 'co','linewidth',2)
% hold on
% plot(((R-(out.r2318xy(950)-out.r2318xy(501:950)))./D), out.U2318xy(501:950)./U_max_mean_2,'r', 'LineWidth',2)
% hold on
% plot(((R-(out.r2328xy(950)-out.r2328xy(501:950)))./D), out.U2328xy(501:950)./U_max_mean_2,'b', 'LineWidth',2)
% hold on
% plot(((R-(out.r2338xy(950)-out.r2338xy(501:950)))./D), out.U2338xy(501:950)./U_max_mean_2,'c', 'LineWidth',2)
% hold on
% xline(0.45,'--k','LineWidth',2.5)
% % legend('LDV','LDV filtered','ppp1','ppp2','ppp3')
% legend('LDV','ppp1','ppp2','ppp3')
% xlabel('r/D','fontsize',15)
% ylabel('U_z/U_c','fontsize',20)
% % title('comparison LPT,f2,low vs LDV grid 8')
% 
% 
% figure('Name','LDV8')
% plot((R-y_LDV)/D, U_LDV_mean/U_max_mean_2, 'go','linewidth',2)
% hold on
% % plot((R-y_LDV)/D, U_LDV_mean_filt/U_max_mean_2, 'co','linewidth',2)
% hold on
% plot(((R-(out.r2314xy(987)-out.r2314xy(511:987)))./D), out.U2314xy(511:987)./U_max_mean_2,'r', 'LineWidth',2)
% hold on
% plot(((R-(out.r2324xy(964)-out.r2324xy(488:964)))./D), out.U2324xy(488:964)./U_max_mean_2,'b', 'LineWidth',2)
% hold on
% plot(((R-(out.r2334xy(967)-out.r2334xy(491:967)))./D), out.U2334xy(491:967)./U_max_mean_2,'c', 'LineWidth',2)
% hold on
% xline(0.45,'--k','LineWidth',2.5)
% % legend('LDV','LDV filtered','ppp1','ppp2','ppp3')
% legend('LDV','ppp1','ppp2','ppp3')
% xlabel('r/D','fontsize',15)
% ylabel('U_z/U_c','fontsize',20)
% % title('comparison LPT,f2,low vs LDV, grid 4')
% 
% 
% figure('Name','LDV9')
% plot((R-y_LDV)/D, U_LDV_mean/U_max_mean_2, 'go','linewidth',2)
% hold on
% % plot((R-y_LDV)/D, U_LDV_mean_filt/U_max_mean_2, 'co','linewidth',2)
% hold on
% plot(((R-(out.r2238xy(950)-out.r2238xy(501:950)))./D), out.U2238xy(501:950)./U_max_mean_2,'b', 'LineWidth',2)
% hold on
% plot(((R-(out.r2234xy(967)-out.r2234xy(491:967)))./D), out.U2234xy(491:967)./U_max_mean_2,'c', 'LineWidth',2)
% hold on
% xline(0.45,'--k','LineWidth',2.5)
% % legend('LDV','LDV filtered','grid 8','grid 4')
% legend('LDV','grid 8','grid 4')
% xlabel('r/D','fontsize',15)
% ylabel('U_z/U_c','fontsize',20)
% title('Comparison LPT,f1,ppp2,low, grid 4 vs grid 8')
% 
% 
% %stesso ppp, diversa frequenza, grid 4 low
% figure('Name','LDV10')
% plot(((R-(out.r2214xy(947)-out.r2214xy(471:947)))./D), out.U2214xy(471:947)./U_max_mean_2,'r', 'LineWidth',2)
% hold on
% plot(((R-(out.r2314xy(987)-out.r2314xy(511:987)))./D), out.U2314xy(511:987)./U_max_mean_2,'b', 'LineWidth',2)
% hold on
% plot((R-y_LDV)/D, U_LDV_mean/U_max_mean_2, 'go','linewidth',2)
% hold on
% xline(0.45,'--k','LineWidth',2.5)
% legend('300Hz','480Hz')
% xlabel('r/D','fontsize',15)
% ylabel('U_z/U_c','fontsize',20)
% % title('Comparison ppp1, grid4, low f1 vs f2')
% 
% figure('Name','LDV11')
% plot(((R-(out.r2224xy(987)-out.r2224xy(512:987)))./D), out.U2224xy(512:987)./U_max_mean_2,'r', 'LineWidth',2)
% hold on
% plot(((R-(out.r2324xy(964)-out.r2324xy(488:964)))./D), out.U2324xy(488:964)./U_max_mean_2,'b', 'LineWidth',2)
% hold on
% plot((R-y_LDV)/D, U_LDV_mean/U_max_mean_2, 'go','linewidth',2)
% hold on
% xline(0.45,'--k','LineWidth',2.5)
% legend('300Hz','480Hz')
% xlabel('r/D','fontsize',15)
% ylabel('U_z/U_c','fontsize',20)
% % title('Comparison ppp2, grid4, low f1 vs f2')
% 
% figure('Name','LDV12')
% plot(((R-(out.r2234xy(967)-out.r2234xy(491:967)))./D), out.U2234xy(491:967)./U_max_mean_2,'r', 'LineWidth',2)
% hold on
% plot(((R-(out.r2334xy(967)-out.r2334xy(491:967)))./D), out.U2334xy(491:967)./U_max_mean_2,'b', 'LineWidth',2)
% hold on
% plot((R-y_LDV)/D, U_LDV_mean/U_max_mean_2, 'go','linewidth',2)
% hold on
% xline(0.45,'--k','LineWidth',2.5)
% legend('300Hz','480Hz')
% xlabel('r/D','fontsize',15)
% ylabel('U_z/U_c','fontsize',20)
% % title('Comparison ppp3, grid4, low f1 vs f2')

%%
close all

%% confronto PIV

TPF2 = '../grafici letteratura/TPF fig 2/data.csv';
TPF2_dat = readtable(TPF2);
TPF2_PIV = '../grafici letteratura/TPF fig 2/PIV data.csv';
TPF2_PIV_dat = readtable(TPF2_PIV);

figure('Name','PIV1','Position',[100 100 700 400])
plot(TPF2_dat{:,1}, TPF2_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
plot(TPF2_PIV_dat{:,1}, TPF2_PIV_dat{:,2},'om','linewidth',2)
hold on
plot(((R-(out.r1114xy(12:488)-out.r1114xy(12)))./D), out.U1114xy(12:488)./U_max_mean_1,'r-', 'LineWidth',2)
hold on
plot(((R-(out.r1124xy(15:491)-out.r1124xy(15)))./D), out.U1124xy(15:491)./U_max_mean_1,'b-', 'LineWidth',2)
hold on
plot(((R-(out.r1134xy(13:490)-out.r1134xy(13)))./D), out.U1134xy(13:490)./U_max_mean_1,'c-', 'LineWidth',2)
hold on
xline(0.45,'--k','LineWidth',2.5)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
% errorbar(((20.7-(out.r1114xy(930)-out.r1114xy(493:930)))./41.4), out.U1114xy(493:930)./abs(max(out.U1114xy)), out.u_unc1114xy(493:930)./abs(max(out.U1114xy)),'r')
legend('DNS','PIV','$ppp_1$','$ppp_2$','$ppp_3$','fontsize',20,'interpreter','latex','location','west')
xlabel('r/D','fontsize',25)
ylabel('U/U_c','fontsize',30)
% title('Comparison mean U PIV, caso Re1, 160 Hz, grid4, upper part')

figure('Name','PIV2','Position',[100 100 700 400])
plot(TPF2_dat{:,1}, TPF2_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
plot(TPF2_PIV_dat{:,1}, TPF2_PIV_dat{:,2},'om','linewidth',2)
hold on
plot(((R-(out.r1114xy(964)-out.r1114xy(488:964)))./D), out.U1114xy(488:964)./U_max_mean_1,'r-', 'LineWidth',2)
hold on
plot(((R-(out.r1124xy(967)-out.r1124xy(491:967)))./D), out.U1124xy(491:967)./U_max_mean_1,'b-', 'LineWidth',2)
hold on
plot(((R-(out.r1134xy(966)-out.r1134xy(490:966)))./D), out.U1134xy(490:966)./U_max_mean_1,'c-', 'LineWidth',2)
hold on
xline(0.45,'--k','LineWidth',2.5)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
% errorbar(((20.7-(out.r1114xy(930)-out.r1114xy(493:930)))./41.4), out.U1114xy(493:930)./abs(max(out.U1114xy)), out.u_unc1114xy(493:930)./abs(max(out.U1114xy)),'r')
legend('DNS','PIV','$ppp_1$','$ppp_2$','$ppp_3$','fontsize',20,'interpreter','latex','location','west')
xlabel('r/D','fontsize',25)
ylabel('U/U_c','fontsize',30)
% title('Comparison mean U PIV, caso Re1, 160 Hz, grid4, lower part')

figure('Name','PIV3','Position',[100 100 700 400])
plot(TPF2_dat{:,1}, TPF2_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
plot(TPF2_PIV_dat{:,1}, TPF2_PIV_dat{:,2},'om','linewidth',2)
hold on
plot(((R-(out.r1118xy(52:501)-out.r1118xy(52)))./D), out.U1118xy(52:501)./U_max_mean_1,'r-', 'LineWidth',2)
hold on
plot(((R-(out.r1128xy(52:501)-out.r1128xy(52)))./D), out.U1128xy(52:501)./U_max_mean_1,'b-', 'LineWidth',2)
hold on
plot(((R-(out.r1138xy(52:501)-out.r1138xy(52)))./D), out.U1138xy(52:501)./U_max_mean_1,'c-', 'LineWidth',2)
hold on
xline(0.45,'--k','LineWidth',2.5)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
% errorbar(((20.7-(out.r1114xy(930)-out.r1114xy(493:930)))./41.4), out.U1114xy(493:930)./abs(max(out.U1114xy)), out.u_unc1114xy(493:930)./abs(max(out.U1114xy)),'r')
legend('DNS','PIV','$ppp_1$','$ppp_2$','$ppp_3$','fontsize',20,'interpreter','latex','location','west')
xlabel('r/D','fontsize',25)
ylabel('U/U_c','fontsize',30)
% title('Comparison mean U PIV, caso Re1, 160 Hz, grid8, upper part')

figure('Name','PIV4','Position',[100 100 700 400])
plot(TPF2_dat{:,1}, TPF2_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
plot(TPF2_PIV_dat{:,1}, TPF2_PIV_dat{:,2},'om','linewidth',2)
hold on
plot(((R-(out.r1118xy(950)-out.r1118xy(501:950)))./D), out.U1118xy(501:950)./U_max_mean_1,'r-', 'LineWidth',2)
hold on
plot(((R-(out.r1128xy(950)-out.r1128xy(501:950)))./D), out.U1128xy(501:950)./U_max_mean_1,'b-', 'LineWidth',2)
hold on
plot(((R-(out.r1138xy(950)-out.r1138xy(501:950)))./D), out.U1138xy(501:950)./U_max_mean_1,'c-', 'LineWidth',2)
hold on
xline(0.45,'--k','LineWidth',2.5)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
% errorbar(((20.7-(out.r1114xy(930)-out.r1114xy(493:930)))./41.4), out.U1114xy(493:930)./abs(max(out.U1114xy)), out.u_unc1114xy(493:930)./abs(max(out.U1114xy)),'r')
legend('DNS','PIV','$ppp_1$','$ppp_2$','$ppp_3$','fontsize',20,'interpreter','latex','location','west')
xlabel('r/D','fontsize',25)
ylabel('U/U_c','fontsize',30)

% title('Comparison mean U PIV, caso Re1, 160 Hz, grid8, lower part')


%% r = 0
%poly
ru01114xy = out.r1114xy(12);
rb01114xy = out.r1114xy(964);
ru01124xy = out.r1124xy(15);
rb01124xy = out.r1124xy(967);
ru01134xy = out.r1134xy(13);
rb01134xy = out.r1134xy(966);

ru01118xy = out.r1118xy(52);
rb01118xy = out.r1118xy(950);
ru01128xy = out.r1128xy(52);
rb01128xy = out.r1128xy(950);
ru01138xy = out.r1138xy(52);
rb01138xy = out.r1138xy(950);

ru02214xy = out.r2214xy(1);
rb02214xy = out.r2214xy(947);
ru02224xy = out.r2224xy(36);
rb02224xy = out.r2224xy(987);
ru02234xy = out.r2234xy(15);
rb02234xy = out.r2234xy(967);

ru02218xy = out.r2214xy(52);
rb02218xy = out.r2214xy(950);
ru02228xy = out.r2224xy(52);
rb02228xy = out.r2224xy(950);
ru02238xy = out.r2234xy(52);
rb02238xy = out.r2234xy(950);

ru02314xy = out.r2314xy(35);
rb02314xy = out.r2314xy(987);
ru02324xy = out.r2324xy(12);
rb02324xy = out.r2324xy(964);
ru02334xy = out.r2334xy(15);
rb02334xy = out.r2334xy(967);

ru02318xy = out.r2314xy(52);
rb02318xy = out.r2314xy(950);
ru02328xy = out.r2324xy(52);
rb02328xy = out.r2324xy(950);
ru02338xy = out.r2334xy(52);
rb02338xy = out.r2334xy(950);

%polz
ru01114xz = out.r1114xz(46);
rb01114xz = out.r1114xz(end);
ru01124xz = out.r1124xz(36);
rb01124xz = out.r1124xz(end);
ru01134xz = out.r1134xz(36);
rb01134xz = out.r1134xz(end);

ru01118xz = out.r1118xz(56);
rb01118xz = out.r1118xz(end);
ru01128xz = out.r1128xz(56);
rb01128xz = out.r1128xz(end);
ru01138xz = out.r1138xz(57);
rb01138xz = out.r1138xz(end);

ru02214xz = out.r2214xz(15);
rb02214xz = out.r2214xz(end);
ru02224xz = out.r2224xz(36);
rb02224xz = out.r2224xz(end);
ru02234xz = out.r2234xz(35);
rb02234xz = out.r2234xz(987);

ru02218xz = out.r2214xz(56);
rb02218xz = out.r2214xz(end);
ru02228xz = out.r2224xz(56);
rb02228xz = out.r2224xz(end);
ru02238xz = out.r2234xz(56);
rb02238xz = out.r2234xz(end);

ru02314xz = out.r2314xz(46);
rb02314xz = out.r2314xz(end);
ru02324xz = out.r2324xz(46);
rb02324xz = out.r2324xz(end);
ru02334xz = out.r2334xz(46);
rb02334xz = out.r2334xz(end);

ru02318xz = out.r2314xz(56);
rb02318xz = out.r2314xz(end);
ru02328xz = out.r2324xz(56);
rb02328xz = out.r2324xz(end);
ru02338xz = out.r2334xz(56);
rb02338xz = out.r2334xz(end);

%% posizione y/D=0.45
clc
% [~, idx_y_plus_25_up] = min(abs((out.r1114xz(1:488)-ru01114xz)/delta_ni(2)-25));
% [~, idx_y_plus_25_low] = min(abs((rb01114xz-out.r1114xz(1:end))/delta_ni(2)-25));
% fprintf('%10s%17s\n','y^+ = 25 up','y^+ = 25 low')
% fprintf('%7d%16d\n',idx_y_plus_25_up, idx_y_plus_25_low)
[~, idx_yD045_up] = min(abs((out.r1114xz-ru01114xz)/D-0.05));
[~, idx_yD045_low] = min(abs((rb01114xz-out.r1114xz)/D-0.05));
fprintf('%10s%19s\n','y/D = 0.45 up','y/D = 0.45 low')
fprintf('%8d%19d\n',idx_yD045_up, idx_yD045_low)

%% confronto DNS fig 7a-Re1-plot over line y
DNS7a_verde = '../grafici letteratura/DNS fig 7a/Re1.csv';
DNS7a_verde_dat = readtable(DNS7a_verde);


figure('Name','7a1','Position',[100 100 700 400])
semilogx(DNS7a_verde_dat{:,1},DNS7a_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1114xy(60:488)-ru01114xy)/delta_ni(1), (out.u_std1114xy(60:488))/u_tau(1),'r','LineWidth',2)
hold on
semilogx((rb01114xy-out.r1114xy(488:916))/delta_ni(1),(out.u_std1114xy(488:916))/u_tau(1),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1124xy(63:488)-ru01124xy)/delta_ni(1), (out.u_std1124xy(63:488))/u_tau(1),'b','LineWidth',2)
hold on
semilogx((rb01124xy-out.r1124xy(488:919))/delta_ni(1),(out.u_std1124xy(488:919))/u_tau(1),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1134xy(61:488)-ru01134xy)/delta_ni(1), (out.u_std1134xy(61:488))/u_tau(1),'c','LineWidth',2)
hold on
semilogx((rb01134xy-out.r1134xy(488:918))/delta_ni(1),(out.u_std1134xy(488:918))/u_tau(1),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{std}$','Interpreter','latex','FontSize',25)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',16,'location','northwest','interpreter','latex')
% title('LPT streamwise fluctuations vs y data for grid 4 at different ppp, upper and lower part of the pipe')


figure('Name','7a2','Position',[100 100 700 400])
semilogx(DNS7a_verde_dat{:,1},DNS7a_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1118xy(97:501)-ru01118xy)/delta_ni(1), (out.u_std1118xy(97:501))/u_tau(1),'r','LineWidth',2)
hold on
semilogx((rb01118xy-out.r1118xy(501:905))/delta_ni(1),(out.u_std1118xy(501:905))/u_tau(1),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1128xy(97:501)-ru01128xy)/delta_ni(1), (out.u_std1128xy(97:501))/u_tau(1),'b','LineWidth',2)
hold on
semilogx((rb01128xy-out.r1128xy(501:905))/delta_ni(1),(out.u_std1128xy(501:905))/u_tau(1),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1138xy(97:501)-ru01138xy)/delta_ni(1), (out.u_std1138xy(97:501))/u_tau(1),'c','LineWidth',2)
hold on
semilogx((rb01138xy-out.r1138xy(501:905))/delta_ni(1),(out.u_std1138xy(501:905))/u_tau(1),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{std}$','Interpreter','latex','FontSize',25)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',16,'location','northwest','interpreter','latex')
% title('LPT streamwise fluctuations vs y data for grid 8 at different ppp, upper and lower part of the pipe')


%% confronto DNS fig 7a-Re1-plot over line z
DNS7a_verde = '../grafici letteratura/DNS fig 7a/Re1.csv';
DNS7a_verde_dat = readtable(DNS7a_verde);


figure('Name','7a3','Position',[100 100 700 400])
semilogx(DNS7a_verde_dat{:,1},DNS7a_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1114xz(95:532)-ru01114xz)/delta_ni(1), (out.u_std1114xz(95:532))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01114xz-out.r1114xz(532:952))/delta_ni(1),(out.u_std1114xz(532:952))/u_tau(1),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1124xz(86:533)-ru01124xz)/delta_ni(1), (out.u_std1124xz(86:533))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01124xz-out.r1124xz(533:951))/delta_ni(1),(out.u_std1124xz(533:951))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1134xz(86:533)-ru01134xz)/delta_ni(1), (out.u_std1134xz(86:533))/u_tau(1),'c','LineWidth',2 )
hold on
semilogx((rb01134xz-out.r1134xz(533:951))/delta_ni(1),(out.u_std1134xz(533:951))/u_tau(1),'--c','LineWidth',2 )      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('z^+','fontsize',25)
ylabel('$u^+_{std}$','Interpreter','latex','fontsize',25)
legend('DNS','$ppp_1$,front','$ppp_1$,back','$ppp_2$,front','$ppp_2$,back', ...
    '$ppp_3$,front','$ppp_3$,back','fontsize',16,'location','northwest','interpreter','latex')
% title('LPT streamwise fluctuations vs z data for grid 4 at different ppp, front and rear part of the pipe')

figure('Name','7a4','Position',[100 100 700 400])
semilogx(DNS7a_verde_dat{:,1},DNS7a_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1118xz(105:542)-ru01118xz)/delta_ni(1), (out.u_std1118xz(105:542))/u_tau(1),'r','LineWidth',2)
hold on
semilogx((rb01118xz-out.r1118xz(542:952))/delta_ni(1),(out.u_std1118xz(542:952))/u_tau(1),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1128xz(105:542)-ru01128xz)/delta_ni(1), (out.u_std1128xz(105:542))/u_tau(1),'b','LineWidth',2)
hold on
semilogx((rb01128xz-out.r1128xz(542:952))/delta_ni(1),(out.u_std1128xz(542:952))/u_tau(1),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1138xz(106:543)-ru01138xz)/delta_ni(1), (out.u_std1138xz(106:543))/u_tau(1),'c','LineWidth',2)
hold on
semilogx((rb01138xz-out.r1138xz(543:952))/delta_ni(1),(out.u_std1138xz(543:952))/u_tau(1),'--c','LineWidth',2)      %plot della parte con y>R
hold on
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)
xlabel('z^+','fontsize',25)
ylabel('$u^+_{std}$','Interpreter','latex','fontsize',25)
legend('DNS','$ppp_1$,front','$ppp_1$,back','$ppp_2$,front','$ppp_2$,back', ...
    '$ppp_3$,front','$ppp_3$,back','fontsize',16,'location','northwest','interpreter','latex')
% title('LPT streamwise fluctuations vs z data for grid 8 at different ppp, front and rear part of the pipe')


%% confronto DNS fig 7a-Re2-plot over line y

figure('Name','7a5','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,7),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), u_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2214xy(49:471)-ru02214xy)/delta_ni(2), (out.u_std2214xy(49:471))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02214xy-out.r2214xy(471:899))/delta_ni(2),(out.u_std2214xy(471:899))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2224xy(84:512)-ru02224xy)/delta_ni(2), (out.u_std2224xy(84:512))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02224xy-out.r2224xy(512:939))/delta_ni(2),(out.u_std2224xy(512:939))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2234xy(63:491)-ru02234xy)/delta_ni(2), (out.u_std2234xy(63:491))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02234xy-out.r2234xy(491:919))/delta_ni(2),(out.u_std2234xy(491:919))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{std}$','Interpreter','latex','fontsize',25)
legend('DNS','LDV','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',16,'interpreter','latex','location','northwest')
% title('LPT streamwise fluctuations vs y data for grid 4,f1 at different ppp, upper and lower part of the pipe')


figure('Name','7a6','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,7),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), u_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2218xy(94:501)-ru02218xy)/delta_ni(2), (out.u_std2218xy(94:501))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02218xy-out.r2218xy(501:852))/delta_ni(2),(out.u_std2218xy(501:852))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2228xy(94:501)-ru02228xy)/delta_ni(2), (out.u_std2228xy(94:501))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02228xy-out.r2228xy(501:852))/delta_ni(2),(out.u_std2228xy(501:852))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2238xy(94:501)-ru02238xy)/delta_ni(2), (out.u_std2238xy(94:501))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02238xy-out.r2238xy(501:852))/delta_ni(2),(out.u_std2238xy(501:852))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{std}$','Interpreter','latex','fontsize',25)
legend('DNS','LDV','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',16,'interpreter','latex','location','northwest')
% title('LPT streamwise fluctuations vs y data for grid 8,f1 at different ppp, upper and lower part of the pipe')


figure('Name','7a7')
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,7),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), u_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2314xy(83:511)-ru02314xy)/delta_ni(2), (out.u_std2314xy(83:511))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02314xy-out.r2314xy(511:939))/delta_ni(2),(out.u_std2314xy(511:939))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2324xy(60:488)-ru02324xy)/delta_ni(2), (out.u_std2324xy(60:488))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02324xy-out.r2324xy(488:916))/delta_ni(2),(out.u_std2324xy(488:916))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2334xy(63:491)-ru02334xy)/delta_ni(2), (out.u_std2334xy(63:491))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02334xy-out.r2334xy(491:919))/delta_ni(2),(out.u_std2334xy(491:919))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{std}$','Interpreter','latex','fontsize',25)
legend('DNS','LDV','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',16,'interpreter','latex','location','northwest')
% title('LPT streamwise fluctuations vs y data for grid 4,f2 at different ppp, upper and lower part of the pipe')



figure('Name','7a8','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,7),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), u_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2318xy(94:501)-ru02318xy)/delta_ni(2), (out.u_std2318xy(94:501))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02318xy-out.r2318xy(501:850))/delta_ni(2),(out.u_std2318xy(501:850))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2328xy(94:501)-ru02328xy)/delta_ni(2), (out.u_std2328xy(94:501))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02328xy-out.r2328xy(501:850))/delta_ni(2),(out.u_std2328xy(501:850))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2338xy(94:501)-ru02338xy)/delta_ni(2), (out.u_std2338xy(94:501))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02338xy-out.r2338xy(501:850))/delta_ni(2),(out.u_std2338xy(501:850))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{std}$','Interpreter','latex','fontsize',25)
legend('DNS','LDV','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',16,'interpreter','latex','location','northwest')
% title('LPT streamwise fluctuations vs y data for grid 8,f2 at different ppp, upper and lower part of the pipe')


%% confronto frequenze
figure('Name','u_freq2')
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,7),'color',[0.75 0.75 0.75],'linewidth',3)
hold on
semilogx((out.r2224xy(84:512)-ru02224xy)/delta_ni(2), (out.u_std2224xy(84:512))/u_tau(2),'r','LineWidth',3 )
hold on
semilogx((out.r2324xy(60:488)-ru02324xy)/delta_ni(2), (out.u_std2324xy(60:488))/u_tau(2),'b','LineWidth',3 )
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{std}$','Interpreter','latex','fontsize',30)
legend('DNS', '300 Hz','480 Hz','fontsize',20,'location','northwest')


figure('Name','u_freq1')
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,7),'color',[0.75 0.75 0.75],'linewidth',3)
hold on
semilogx((rb02214xy-out.r2214xy(471:899))/delta_ni(2),(out.u_std2214xy(471:899))/u_tau(2),'r','LineWidth',3)      %plot della parte con y>R
hold on
semilogx((rb02314xy-out.r2314xy(511:939))/delta_ni(2),(out.u_std2314xy(511:939))/u_tau(2),'b','LineWidth',3)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{std}$','Interpreter','latex','fontsize',30)
legend('DNS', '300 Hz','480 Hz','fontsize',20,'location','northwest')


%% confronto DNS fig 7b-Re1-plot over line y
DNS7b_verde = '../grafici letteratura/DNS fig 7b/Re1.csv';
DNS7b_verde_dat = readtable(DNS7b_verde);

figure('Name','7b1','Position',[100 100 700 400])
semilogx(DNS7b_verde_dat{:,1},DNS7b_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1114xy(60:488)-ru01114xy)/delta_ni(1), (out.v_std1114xy(60:488))/u_tau(1),'r','LineWidth',2)
hold on
semilogx((rb01114xy-out.r1114xy(488:916))/delta_ni(1),(out.v_std1114xy(488:916))/u_tau(1),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1124xy(63:488)-ru01124xy)/delta_ni(1), (out.v_std1124xy(63:488))/u_tau(1),'b','LineWidth',2)
hold on
semilogx((rb01124xy-out.r1124xy(488:919))/delta_ni(1),(out.v_std1124xy(488:919))/u_tau(1),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1134xy(61:488)-ru01134xy)/delta_ni(1), (out.v_std1134xy(61:488))/u_tau(1),'c','LineWidth',2)
hold on
semilogx((rb01134xy-out.r1134xy(488:918))/delta_ni(1),(out.v_std1134xy(488:918))/u_tau(1),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{r,std}$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',16,'location','northwest','interpreter','latex')
% title('LPT radial fluctuations vs y for grid 4 at different ppp, upper and lower part of the pipe')


figure('Name','7b2','Position',[100 100 700 400])
semilogx(DNS7b_verde_dat{:,1},DNS7b_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1118xy(97:501)-ru01118xy)/delta_ni(1), (out.v_std1118xy(97:501))/u_tau(1),'r','LineWidth',2)
hold on
semilogx((rb01118xy-out.r1118xy(501:905))/delta_ni(1),(out.v_std1118xy(501:905))/u_tau(1),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1128xy(97:501)-ru01128xy)/delta_ni(1), (out.v_std1128xy(97:501))/u_tau(1),'b','LineWidth',2)
hold on
semilogx((rb01128xy-out.r1128xy(501:905))/delta_ni(1),(out.v_std1128xy(501:905))/u_tau(1),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1138xy(97:501)-ru01138xy)/delta_ni(1), (out.v_std1138xy(97:501))/u_tau(1),'c','LineWidth',2)
hold on
semilogx((rb01138xy-out.r1138xy(501:905))/delta_ni(1),(out.v_std1138xy(501:905))/u_tau(1),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{r,std}$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',16,'location','northwest','interpreter','latex')
% title('LPT radial fluctuations vs y for grid 8 at different ppp, upper and lower part of the pipe')


%% confronto DNS fig 7b-Re1-plot over line z

figure('Name','7b9','Position',[100 100 700 400])
semilogx(DNS7b_verde_dat{:,1},DNS7b_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1114xz(95:533)-ru01114xz)/delta_ni(1), (out.w_std1114xz(95:533))/u_tau(1),'r','LineWidth',2)
hold on
semilogx((rb01114xz-out.r1114xz(533:952))/delta_ni(1),(out.w_std1114xz(533:952))/u_tau(1),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1124xz(86:533)-ru01124xz)/delta_ni(1), (out.w_std1124xz(86:533))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01124xz-out.r1124xz(533:951))/delta_ni(1),(out.w_std1124xz(533:951))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1134xz(86:533)-ru01134xz)/delta_ni(1), (out.w_std1134xz(86:533))/u_tau(1),'c','LineWidth',2 )
hold on
semilogx((rb01134xz-out.r1134xz(533:951))/delta_ni(1),(out.w_std1134xz(533:951))/u_tau(1),'--c','LineWidth',2 )      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('z^+','fontsize',25)
ylabel('$u^+_{r,std}$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,front','$ppp_1$,back','$ppp_2$,front','$ppp_2$,back', ...
    '$ppp_3$,front','$ppp_3$,back','fontsize',18,'interpreter','latex','location','west')
% title('LPT radial fluctuations vs z for grid 4 at different ppp, front and rear part of the pipe')
 

% figure('Name','7b4')
% semilogx(DNS7b_verde_dat{:,1},DNS7b_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
% hold on
% semilogx((out.r1118xz(105:542)-ru01118xz)/delta_ni(1), (out.w_std1118xz(105:542))/u_tau(1),'r','LineWidth',1)
% hold on
% semilogx((rb01118xz-out.r1118xz(542:952))/delta_ni(1),(out.w_std1118xz(542:952))/u_tau(1),'--r','LineWidth',1)      %plot della parte con y>R
% hold on
% semilogx((out.r1128xz(105:542)-ru01128xz)/delta_ni(1), (out.w_std1128xz(105:542))/u_tau(1),'b','LineWidth',1)
% hold on
% semilogx((rb01128xz-out.r1128xz(542:952))/delta_ni(1),(out.w_std1128xz(542:952))/u_tau(1),'--b','LineWidth',1)      %plot della parte con y>R
% hold on
% semilogx((out.r1138xz(106:543)-ru01138xz)/delta_ni(1), (out.w_std1138xz(106:543))/u_tau(1),'y','LineWidth',1)
% hold on
% semilogx((rb01138xz-out.r1138xz(543:952))/delta_ni(1),(out.w_std1138xz(543:952))/u_tau(1),'--y','LineWidth',1)      %plot della parte con y>R
% hold on
% xlabel('z^+')
% ylabel('$u^+_{r,std}$','Interpreter','latex')
% legend('DNS','ppp1,front','ppp1,rear','ppp2,front','ppp2,rear', ...
%     'ppp3,front','ppp3,rear')
% title('LPT radial fluctuations vs z for grid 8 at different ppp, front and rear part of the pipe')

figure('Name','7b10','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,5),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx((out.r2214xz(65:512)-ru02214xz)/delta_ni(2), (out.w_std2214xz(65:512))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02214xz-out.r2214xz(512:951))/delta_ni(2),(out.w_std2214xz(512:951))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2224xz(86:533)-ru02224xz)/delta_ni(2), (out.w_std2224xz(86:533))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02224xz-out.r2224xz(533:951))/delta_ni(2),(out.w_std2224xz(533:951))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2234xz(83:511)-ru02234xz)/delta_ni(2), (out.w_std2234xz(83:511))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02234xz-out.r2234xz(511:939))/delta_ni(2),(out.w_std2234xz(511:939))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('z^+','fontsize',25)
ylabel('$u^+_{r,std}$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,front','$ppp_1$,back','$ppp_2$,front','$ppp_2$,back', ...
    '$ppp_3$,front','$ppp_3$,back','fontsize',18,'interpreter','latex','location','west')
% title('LPT radial fluctuations vs z for grid 8 at different ppp, front and rear part of the pipe')


%% confronto DNS fig 7b-Re2-plot over line y

figure('Name','7b5','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,5),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
% semilogx(y_LDV(1:13)./delta_ni(2), v_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
% hold on
semilogx((out.r2214xy(49:471)-ru02214xy)/delta_ni(2), (out.v_std2214xy(49:471))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02214xy-out.r2214xy(471:899))/delta_ni(2),(out.v_std2214xy(471:899))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2224xy(84:512)-ru02224xy)/delta_ni(2), (out.v_std2224xy(84:512))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02224xy-out.r2224xy(512:939))/delta_ni(2),(out.v_std2224xy(512:939))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2234xy(63:491)-ru02234xy)/delta_ni(2), (out.v_std2234xy(63:491))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02234xy-out.r2234xy(491:919))/delta_ni(2),(out.v_std2234xy(491:919))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{r,std}$','Interpreter','latex','fontsize',30)
% legend('DNS','LDV','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
%     '$ppp_3$,up','$ppp_3$,low','fontsize',16,'interpreter','latex','location','northwest')
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',16,'interpreter','latex','location','northwest')
% title('LPT radial fluctuations vs y data for grid 4,f1 at different ppp, upper and lower part of the pipe')


figure('Name','7b6','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,5),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), v_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2218xy(94:501)-ru02218xy)/delta_ni(2), (out.v_std2218xy(94:501))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02218xy-out.r2218xy(501:852))/delta_ni(2),(out.v_std2218xy(501:852))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2228xy(94:501)-ru02228xy)/delta_ni(2), (out.v_std2228xy(94:501))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02228xy-out.r2228xy(501:852))/delta_ni(2),(out.v_std2228xy(501:852))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2238xy(94:501)-ru02238xy)/delta_ni(2), (out.v_std2238xy(94:501))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02238xy-out.r2238xy(501:852))/delta_ni(2),(out.v_std2238xy(501:852))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{r,std}$','Interpreter','latex','fontsize',30)
legend('DNS','LDV','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',16,'interpreter','latex','location','northwest')
% title('LPT radial fluctuations vs y data for grid 8,f1 at different ppp, upper and lower part of the pipe')


figure('Name','7b7','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,5),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx((out.r2314xy(83:511)-ru02314xy)/delta_ni(2), (out.v_std2314xy(83:511))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02314xy-out.r2314xy(511:939))/delta_ni(2),(out.v_std2314xy(511:939))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2324xy(60:488)-ru02324xy)/delta_ni(2), (out.v_std2324xy(60:488))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02324xy-out.r2324xy(488:916))/delta_ni(2),(out.v_std2324xy(488:916))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2334xy(63:491)-ru02334xy)/delta_ni(2), (out.v_std2334xy(63:491))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02334xy-out.r2334xy(491:919))/delta_ni(2),(out.v_std2334xy(491:919))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{r,std}$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',16,'interpreter','latex','location','northwest')
% title('LPT radial fluctuations vs y data for grid 4,f2 at different ppp, upper and lower part of the pipe')



figure('Name','7b8','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,5),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx((out.r2318xy(94:501)-ru02318xy)/delta_ni(2), (out.v_std2318xy(94:501))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02318xy-out.r2318xy(501:850))/delta_ni(2),(out.v_std2318xy(501:850))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2328xy(94:501)-ru02328xy)/delta_ni(2), (out.v_std2328xy(94:501))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02328xy-out.r2328xy(501:850))/delta_ni(2),(out.v_std2328xy(501:850))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2338xy(94:501)-ru02338xy)/delta_ni(2), (out.v_std2338xy(94:501))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02338xy-out.r2338xy(501:850))/delta_ni(2),(out.v_std2338xy(501:850))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{r,std}$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',16,'interpreter','latex','location','northwest')
% title('LPT radial fluctuations vs y data for grid 8,f2 at different ppp, upper and lower part of the pipe')


%% confronto DNS fig 7c - Re1 - plot over line y
DNS7c_verde = '../grafici letteratura/DNS fig 7c/Re1.csv';
DNS7c_verde_dat = readtable(DNS7c_verde);

figure('Name','7c1','Position',[100 100 700 400])
semilogx(DNS7c_verde_dat{:,1},DNS7c_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1114xy(60:488)-ru01114xy)/delta_ni(1), (out.w_std1114xy(60:488))/u_tau(1),'r','LineWidth',2)
hold on
semilogx((rb01114xy-out.r1114xy(488:916))/delta_ni(1),(out.w_std1114xy(488:916))/u_tau(1),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1124xy(63:488)-ru01124xy)/delta_ni(1), (out.w_std1124xy(63:488))/u_tau(1),'b','LineWidth',2)
hold on
semilogx((rb01124xy-out.r1124xy(488:919))/delta_ni(1),(out.w_std1124xy(488:919))/u_tau(1),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1134xy(61:488)-ru01134xy)/delta_ni(1), (out.w_std1134xy(61:488))/u_tau(1),'c','LineWidth',2)
hold on
semilogx((rb01134xy-out.r1134xy(488:918))/delta_ni(1),(out.w_std1134xy(488:918))/u_tau(1),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{\theta,std}$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',18,'interpreter','latex','location','west')

% title('LPT azimuthal fluctuations vs y for grid 4 at different ppp, upper and lower part of the pipe')


figure('Name','7c2','Position',[100 100 700 400])
semilogx(DNS7c_verde_dat{:,1},DNS7c_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1118xy(97:501)-ru01118xy)/delta_ni(1), (out.w_std1118xy(97:501))/u_tau(1),'r','LineWidth',2)
hold on
semilogx((rb01118xy-out.r1118xy(501:905))/delta_ni(1),(out.w_std1118xy(501:905))/u_tau(1),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1128xy(97:501)-ru01128xy)/delta_ni(1), (out.w_std1128xy(97:501))/u_tau(1),'b','LineWidth',2)
hold on
semilogx((rb01128xy-out.r1128xy(501:905))/delta_ni(1),(out.w_std1128xy(501:905))/u_tau(1),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1138xy(97:501)-ru01138xy)/delta_ni(1), (out.w_std1138xy(97:501))/u_tau(1),'c','LineWidth',2)
hold on
semilogx((rb01138xy-out.r1138xy(501:905))/delta_ni(1),(out.w_std1138xy(501:905))/u_tau(1),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{\theta,std}$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',18,'interpreter','latex','location','west')

% title('LPT azimuthal fluctuations vs y for grid 8 at different ppp, upper and lower part of the pipe')


%% confronto DNS fig 7c-Re2-plot over line y

figure('Name','7c5','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,6),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx((out.r2214xy(49:471)-ru02214xy)/delta_ni(2), (out.w_std2214xy(49:471))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02214xy-out.r2214xy(471:899))/delta_ni(2),(out.w_std2214xy(471:899))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2224xy(84:512)-ru02224xy)/delta_ni(2), (out.w_std2224xy(84:512))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02224xy-out.r2224xy(512:939))/delta_ni(2),(out.w_std2224xy(512:939))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2234xy(63:491)-ru02234xy)/delta_ni(2), (out.w_std2234xy(63:491))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02234xy-out.r2234xy(491:919))/delta_ni(2),(out.w_std2234xy(491:919))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{\theta,std}$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',18,'interpreter','latex','location','west')

% title('LPT azimuthal fluctuations vs y data for grid 4,f1 at different ppp, upper and lower part of the pipe')


figure('Name','7c6','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,6),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx((out.r2218xy(94:501)-ru02218xy)/delta_ni(2), (out.w_std2218xy(94:501))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02218xy-out.r2218xy(501:852))/delta_ni(2),(out.w_std2218xy(501:852))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2228xy(94:501)-ru02228xy)/delta_ni(2), (out.w_std2228xy(94:501))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02228xy-out.r2228xy(501:852))/delta_ni(2),(out.w_std2228xy(501:852))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2238xy(94:501)-ru02238xy)/delta_ni(2), (out.w_std2238xy(94:501))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02238xy-out.r2238xy(501:852))/delta_ni(2),(out.w_std2238xy(501:852))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{\theta,std}$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',18,'interpreter','latex','location','west')

% title('LPT azimuthal fluctuations vs y data for grid 8,f1 at different ppp, upper and lower part of the pipe')


figure('Name','7c7','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,6),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx((out.r2314xy(83:511)-ru02314xy)/delta_ni(2), (out.w_std2314xy(83:511))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02314xy-out.r2314xy(511:939))/delta_ni(2),(out.w_std2314xy(511:939))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2324xy(60:488)-ru02324xy)/delta_ni(2), (out.w_std2324xy(60:488))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02324xy-out.r2324xy(488:916))/delta_ni(2),(out.w_std2324xy(488:916))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2334xy(63:491)-ru02334xy)/delta_ni(2), (out.w_std2334xy(63:491))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02334xy-out.r2334xy(491:919))/delta_ni(2),(out.w_std2334xy(491:919))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{\theta,std}$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',18,'interpreter','latex','location','west')

% title('LPT azimuthal fluctuations vs y data for grid 4,f2 at different ppp, upper and lower part of the pipe')



figure('Name','7c8','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,6),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx((out.r2318xy(94:501)-ru02318xy)/delta_ni(2), (out.w_std2318xy(94:501))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02318xy-out.r2318xy(501:850))/delta_ni(2),(out.w_std2318xy(501:850))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2328xy(94:501)-ru02328xy)/delta_ni(2), (out.w_std2328xy(94:501))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02328xy-out.r2328xy(501:850))/delta_ni(2),(out.w_std2328xy(501:850))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2338xy(94:501)-ru02338xy)/delta_ni(2), (out.w_std2338xy(94:501))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02338xy-out.r2338xy(501:850))/delta_ni(2),(out.w_std2338xy(501:850))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$u^+_{\theta,std}$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',18,'interpreter','latex','location','west')

% title('LPT azimuthal fluctuations vs y data for grid 8,f2 at different ppp, upper and lower part of the pipe')


%% confronto DNS fig 7c-Re1-plot over line z
DNS7a_verde = '../grafici letteratura/DNS fig 7a/Re1.csv';
DNS7a_verde_dat = readtable(DNS7a_verde);


figure('Name','7c9','Position',[100 100 700 400])
semilogx(DNS7c_verde_dat{:,1},DNS7c_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1114xz(95:532)-ru01114xz)/delta_ni(1), (out.v_std1114xz(95:532))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01114xz-out.r1114xz(532:952))/delta_ni(1),(out.v_std1114xz(532:952))/u_tau(1),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1124xz(86:533)-ru01124xz)/delta_ni(1), (out.v_std1124xz(86:533))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01124xz-out.r1124xz(533:951))/delta_ni(1),(out.v_std1124xz(533:951))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1134xz(86:533)-ru01134xz)/delta_ni(1), (out.v_std1134xz(86:533))/u_tau(1),'c','LineWidth',2 )
hold on
semilogx((rb01134xz-out.r1134xz(533:951))/delta_ni(1),(out.v_std1134xz(533:951))/u_tau(1),'--c','LineWidth',2 )      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlim([1, 300])
ylim([0, 1.3])
xlabel('z^+','fontsize',25)
ylabel('$u^+_{\theta,std}$','Interpreter','latex','FontSize',30)
legend('DNS','$ppp_1$,front','$ppp_1$,back','$ppp_2$,front','$ppp_2$,back', ...
    '$ppp_3$,front','$ppp_3$,back','fontsize',16,'interpreter','latex','location','northwest')
% title('LPT azimuthal fluctuations vs z data for grid 4 at different ppp, front and rear part of the pipe')

% figure('Name','7c10')
% semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,6),'color',[0.75 0.75 0.75],'linewidth',2)
% hold on
% semilogx((out.r2214xz(49:471)-ru02214xz)/delta_ni(1), (out.v_std2214xz(49:471))/u_tau(1),'r','LineWidth',1)
% hold on
% semilogx((rb02214xz-out.r2214xz(471:899))/delta_ni(1),(out.v_std2214xz(471:899))/u_tau(1),'--r','LineWidth',1)      %plot della parte con y>R
% hold on
% semilogx((out.r2224xz(84:512)-ru02224xz)/delta_ni(1), (out.v_std2224xz(84:512))/u_tau(1),'b','LineWidth',1)
% hold on
% semilogx((rb02224xz-out.r2224xz(512:939))/delta_ni(1),(out.v_std2224xz(512:939))/u_tau(1),'--b','LineWidth',1)      %plot della parte con y>R
% hold on
% semilogx((out.r2234xz(63:491)-ru02234xz)/delta_ni(1), (out.v_std2234xz(63:491))/u_tau(1),'y','LineWidth',1)
% hold on
% semilogx((rb02234xz-out.r2234xz(491:919))/delta_ni(1),(out.v_std2234xz(491:919))/u_tau(1),'--y','LineWidth',1)      %plot della parte con y>R
% hold on
% xlabel('z^+')
% ylabel('$u^+_{std}$','Interpreter','latex','FontSize',15)
% legend('DNS','ppp1,front','ppp1,rear','ppp2,front','ppp2,rear', ...
%     'ppp3,front','ppp3,rear')
% % title('LPT azimuthal fluctuations vs z data for grid 8 at different ppp, front and rear part of the pipe')

figure('Name','7c10','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,6),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx((out.r2214xz(49:471)-ru02214xz)/delta_ni(2), (out.v_std2214xz(49:471))/u_tau(2),'r','LineWidth',2)
hold on
semilogx((rb02214xz-out.r2214xz(471:899))/delta_ni(2),(out.v_std2214xz(471:899))/u_tau(2),'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2224xz(84:512)-ru02224xz)/delta_ni(2), (out.v_std2224xz(84:512))/u_tau(2),'b','LineWidth',2)
hold on
semilogx((rb02224xz-out.r2224xz(512:939))/delta_ni(2),(out.v_std2224xz(512:939))/u_tau(2),'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2234xz(63:491)-ru02234xz)/delta_ni(2), (out.v_std2234xz(63:491))/u_tau(2),'c','LineWidth',2)
hold on
semilogx((rb02234xz-out.r2234xz(491:919))/delta_ni(2),(out.v_std2234xz(491:919))/u_tau(2),'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('z^+','fontsize',25)
ylabel('$u^+_{\theta,std}$','Interpreter','latex','FontSize',30)
legend('DNS','$ppp_1$,front','$ppp_1$,back','$ppp_2$,front','$ppp_2$,back', ...
    '$ppp_3$,front','$ppp_3$,back','fontsize',16,'interpreter','latex','location','northwest')

%% confronto DNS fig 7d - Re1 - plot over line y
DNS7d_verde = '../grafici letteratura/DNS fig 7d/Re1.csv';
DNS7d_verde_dat = readtable(DNS7d_verde);

figure('Name','7d1','Position',[100 100 700 400])
semilogx(DNS7d_verde_dat{:,1},DNS7d_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1114xy(60:488)-ru01114xy)/delta_ni(1), -(out.Rxy1114xy(60:488))/u_tau(1)^2,'r','LineWidth',2)
hold on
semilogx((rb01114xy-out.r1114xy(488:916))/delta_ni(1),(out.Rxy1114xy(488:916))/u_tau(1)^2,'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1124xy(63:488)-ru01124xy)/delta_ni(1), -(out.Rxy1124xy(63:488))/u_tau(1)^2,'b','LineWidth',2)
hold on
semilogx((rb01124xy-out.r1124xy(488:919))/delta_ni(1),(out.Rxy1124xy(488:919))/u_tau(1)^2,'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1134xy(61:488)-ru01134xy)/delta_ni(1), -(out.Rxy1134xy(61:488))/u_tau(1)^2,'c','LineWidth',2)
hold on
semilogx((rb01134xy-out.r1134xy(488:918))/delta_ni(1),(out.Rxy1134xy(488:918))/u_tau(1)^2,'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$R_{xy}^+$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',17,'interpreter','latex','location','northwest')
% title('LPT Reynolds stresses vs y for grid 4 at different ppp, upper and lower part of the pipe')

figure('Name','7d2','Position',[100 100 700 400])
semilogx(DNS7d_verde_dat{:,1},DNS7d_verde_dat{:,2},'color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1118xy(97:501)-ru01118xy)/delta_ni(1), -(out.Rxy1118xy(97:501))/u_tau(1)^2,'r','LineWidth',2)
hold on
semilogx((rb01118xy-out.r1118xy(501:905))/delta_ni(1),(out.Rxy1118xy(501:905))/u_tau(1)^2,'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1128xy(97:501)-ru01128xy)/delta_ni(1), -(out.Rxy1128xy(97:501))/u_tau(1)^2,'b','LineWidth',2)
hold on
semilogx((rb01128xy-out.r1128xy(501:905))/delta_ni(1),(out.Rxy1128xy(501:905))/u_tau(1)^2,'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r1138xy(97:501)-ru01138xy)/delta_ni(1), -(out.Rxy1138xy(97:501))/u_tau(1)^2,'c','LineWidth',2)
hold on
semilogx((rb01138xy-out.r1138xy(501:905))/delta_ni(1),(out.Rxy1138xy(501:905))/u_tau(1)^2,'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$R_{xy}^+$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',17,'interpreter','latex','location','northwest')
% title('LPT Reynolds stresses vs y for grid 8 at different ppp, upper and lower part of the pipe')



%% confronto DNS fig 7d-Re2-plot over line y
DNS7a_blu = '../grafici letteratura/DNS fig 7a/Re2.csv';
DNS7a_blu_dat = readtable(DNS7a_blu);

figure('Name','7d5','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,8),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2),Rxy_LDV(1:13)/u_tau(2)^2,'og','linewidth',2)
hold on
semilogx((out.r2214xy(49:471)-ru02214xy)/delta_ni(2), -(out.Rxy2214xy(49:471))/u_tau(2)^2,'r','LineWidth',2)
hold on
semilogx((rb02214xy-out.r2214xy(471:899))/delta_ni(2),(out.Rxy2214xy(471:899))/u_tau(2)^2,'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2224xy(84:512)-ru02224xy)/delta_ni(2), -(out.Rxy2224xy(84:512))/u_tau(2)^2,'b','LineWidth',2)
hold on
semilogx((rb02224xy-out.r2224xy(512:939))/delta_ni(2),(out.Rxy2224xy(512:939))/u_tau(2)^2,'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2234xy(63:491)-ru02234xy)/delta_ni(2), -(out.Rxy2234xy(63:491))/u_tau(2)^2,'c','LineWidth',2)
hold on
semilogx((rb02234xy-out.r2234xy(491:919))/delta_ni(2),(out.Rxy2234xy(491:919))/u_tau(2)^2,'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$R_{xy}^+$','Interpreter','latex','fontsize',30)
legend('DNS','LDV','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',17,'interpreter','latex','location','northwest')
% title('LPT Reynolds stresses vs y data for grid 4,f1 at different ppp, upper and lower part of the pipe')


figure('Name','7d6','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,8),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), Rxy_LDV(1:13)/u_tau(2)^2,'og','linewidth',2)
hold on
semilogx((out.r2218xy(94:501)-ru02218xy)/delta_ni(2), -(out.Rxy2218xy(94:501))/u_tau(2)^2,'r','LineWidth',2)
hold on
semilogx((rb02218xy-out.r2218xy(501:852))/delta_ni(2),(out.Rxy2218xy(501:852))/u_tau(2)^2,'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2228xy(94:501)-ru02228xy)/delta_ni(2), -(out.Rxy2228xy(94:501))/u_tau(2)^2,'b','LineWidth',2)
hold on
semilogx((rb02228xy-out.r2228xy(501:852))/delta_ni(2),(out.Rxy2228xy(501:852))/u_tau(2)^2,'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2238xy(94:501)-ru02238xy)/delta_ni(2), -(out.Rxy2238xy(94:501))/u_tau(2)^2,'c','LineWidth',2)
hold on
semilogx((rb02238xy-out.r2238xy(501:852))/delta_ni(2),(out.Rxy2238xy(501:852))/u_tau(2)^2,'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$R_{xy}^+$','Interpreter','latex','fontsize',30)
legend('DNS','LDV','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',17,'interpreter','latex','location','northwest')
% title('LPT Reynolds stresses vs y data for grid 8,f1 at different ppp, upper and lower part of the pipe')


figure('Name','7d7','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,8),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx((out.r2314xy(83:511)-ru02314xy)/delta_ni(2), -(out.Rxy2314xy(83:511))/u_tau(2)^2,'r','LineWidth',2)
hold on
semilogx((rb02314xy-out.r2314xy(511:939))/delta_ni(2),(out.Rxy2314xy(511:939))/u_tau(2)^2,'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2324xy(60:488)-ru02324xy)/delta_ni(2), -(out.Rxy2324xy(60:488))/u_tau(2)^2,'b','LineWidth',2)
hold on
semilogx((rb02324xy-out.r2324xy(488:916))/delta_ni(2),(out.Rxy2324xy(488:916))/u_tau(2)^2,'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2334xy(63:491)-ru02334xy)/delta_ni(2), -(out.Rxy2334xy(63:491))/u_tau(2)^2,'c','LineWidth',2)
hold on
semilogx((rb02334xy-out.r2334xy(491:919))/delta_ni(2),(out.Rxy2334xy(491:919))/u_tau(2)^2,'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$R_{xy}^+$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',17,'interpreter','latex','location','northwest')
% title('LPT Reynolds stresses vs y data for grid 4,f2 at different ppp, upper and lower part of the pipe')



figure('Name','7d8','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,8),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
semilogx((out.r2318xy(94:501)-ru02318xy)/delta_ni(2), -(out.Rxy2318xy(94:501))/u_tau(2)^2,'r','LineWidth',2)
hold on
semilogx((rb02318xy-out.r2318xy(501:850))/delta_ni(2),(out.Rxy2318xy(501:850))/u_tau(2)^2,'--r','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2328xy(94:501)-ru02328xy)/delta_ni(2), -(out.Rxy2328xy(94:501))/u_tau(2)^2,'b','LineWidth',2)
hold on
semilogx((rb02328xy-out.r2328xy(501:850))/delta_ni(2),(out.Rxy2328xy(501:850))/u_tau(2)^2,'--b','LineWidth',2)      %plot della parte con y>R
hold on
semilogx((out.r2338xy(94:501)-ru02338xy)/delta_ni(2), -(out.Rxy2338xy(94:501))/u_tau(2)^2,'c','LineWidth',2)
hold on
semilogx((rb02338xy-out.r2338xy(501:850))/delta_ni(2),(out.Rxy2338xy(501:850))/u_tau(2)^2,'--c','LineWidth',2)      %plot della parte con y>R
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('$R_{xy}^+$','Interpreter','latex','fontsize',30)
legend('DNS','$ppp_1$,up','$ppp_1$,low','$ppp_2$,up','$ppp_2$,low', ...
    '$ppp_3$,up','$ppp_3$,low','fontsize',17,'interpreter','latex','location','northwest')
% title('LPT Reynolds stresses vs y data for grid 8,f2 at different ppp, upper and lower part of the pipe')



%% confronto figura 6 Re1
% DNS6_blu = '../grafici letteratura/DNS fig 6a/blu.csv';
% DNS6_blu_dat = readtable(DNS6_blu);
DNS6_verde = '../grafici letteratura/DNS fig 6a/verde.csv';
DNS6_verde_dat = readtable(DNS6_verde);


% figure('Name','fig 6.1')
% semilogx(DNS6_verde_dat{:,1},DNS6_verde_dat{:,2}-15,'color',[0.75 0.75 0.75],'LineWidth',2)
% hold on
% plot(((out.r1118xy(52:501)-out.r1118xy(52))./delta_ni(1)), out.U1118xy(52:501)./u_tau(1),'r-', 'LineWidth',2)
% hold on
% plot(((out.r1128xy(52:501)-out.r1128xy(52))./delta_ni(1)), out.U1128xy(52:501)./u_tau(1),'b-', 'LineWidth',2)
% hold on
% plot(((out.r1138xy(52:501)-out.r1138xy(52))./delta_ni(1)), out.U1138xy(52:501)./u_tau(1),'c-', 'LineWidth',2)
% hold on
% xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
% xlim([1 1000])
% xlabel('y^+','fontsize',15)
% ylabel('U^+','fontsize',15)
% legend('DNS','ppp1','ppp2','ppp3')
% title('mean axial velocity VS y^+, Re1, grid 8, upper part, different ppp')
% 
% 
% figure('Name','fig 6.2')
% semilogx(DNS6_verde_dat{:,1},DNS6_verde_dat{:,2}-15,'color',[0.75 0.75 0.75],'LineWidth',2)
% hold on
% plot(((out.r1114xy(12:488)-out.r1114xy(12))./delta_ni(1)), out.U1114xy(12:488)./u_tau(1),'r-', 'LineWidth',2)
% hold on
% plot(((out.r1124xy(15:491)-out.r1124xy(15))./delta_ni(1)), out.U1124xy(15:491)./u_tau(1),'b-', 'LineWidth',2)
% hold on
% plot(((out.r1134xy(13:490)-out.r1134xy(13))./delta_ni(1)), out.U1134xy(13:490)./u_tau(1),'c-', 'LineWidth',2)
% hold on
% xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
% xlim([1 1000])
% xlabel('y^+','fontsize',15)
% ylabel('U^+','fontsize',15)
% legend('DNS','ppp1','ppp2','ppp3')
% title('mean axial velocity VS y^+, Re1, grid 4, upper part, different ppp')
% 
% 
% figure('Name','fig 6.3')
% semilogx(DNS6_verde_dat{:,1},DNS6_verde_dat{:,2}-15,'color',[0.75 0.75 0.75],'LineWidth',2)
% hold on
% plot(((out.r1118xy(950)-out.r1118xy(501:950))./delta_ni(1)), out.U1118xy(501:950)./u_tau(1),'r-', 'LineWidth',2)
% hold on
% plot(((out.r1128xy(950)-out.r1128xy(501:950))./delta_ni(1)), out.U1128xy(501:950)./u_tau(1),'b-', 'LineWidth',2)
% hold on
% plot(((out.r1138xy(950)-out.r1138xy(501:950))./delta_ni(1)), out.U1138xy(501:950)./u_tau(1),'c-', 'LineWidth',2)
% hold on
% xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
% xlim([1 1000])
% xlabel('y^+','fontsize',15)
% ylabel('U^+','fontsize',15)
% legend('DNS','ppp1','ppp2','ppp3')
% title('mean axial velocity VS y^+, Re1, grid 8, lower part, different ppp')
% 
% 
% figure('Name','fig 6.4')
% semilogx(DNS6_verde_dat{:,1},DNS6_verde_dat{:,2}-15,'color',[0.75 0.75 0.75],'LineWidth',2)
% hold on
% plot(((out.r1114xy(964)-out.r1114xy(488:964))./delta_ni(1)), out.U1114xy(488:964)./u_tau(1),'r-', 'LineWidth',2)
% hold on
% plot(((out.r1124xy(967)-out.r1124xy(491:967))./delta_ni(1)), out.U1124xy(491:967)./u_tau(1),'b-', 'LineWidth',2)
% hold on
% plot(((out.r1134xy(966)-out.r1134xy(490:966))./delta_ni(1)), out.U1134xy(490:966)./u_tau(1),'c-', 'LineWidth',2)
% hold on
% xline((0.1*R)/delta_ni(1),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
% xlim([1 1000])
% xlabel('y^+','fontsize',15)
% ylabel('U^+','fontsize',15)
% legend('DNS','ppp1','ppp2','ppp3')
% title('mean axial velocity VS y^+, Re1, grid 4, lower part, different ppp')
% 

%% confronto figura 6 Re2 f1
% figure('Name','fig 6.5')
% semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',2)
% hold on
% plot(((out.r2218xy(52:501)-out.r2218xy(52))./delta_ni(2)), out.U2218xy(52:501)./u_tau(2),'r-', 'LineWidth',2)
% hold on
% plot(((out.r2228xy(52:501)-out.r2228xy(52))./delta_ni(2)), out.U2228xy(52:501)./u_tau(2),'b-', 'LineWidth',2)
% hold on
% plot(((out.r2238xy(52:501)-out.r2238xy(52))./delta_ni(2)), out.U2238xy(52:501)./u_tau(2),'c-', 'LineWidth',2)
% hold on
% semilogx(y_LDV./delta_ni(2), U_LDV_mean_filt./u_tau(2),'og','linewidth',2)
% hold on
% xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
% xlim([1 1000])
% hold on
% xlabel('y^+','fontsize',15)
% ylabel('U^+','fontsize',15)
% legend('DNS','ppp1','ppp2','ppp3','LDV','fontsize',15)
% ax = gca;
% ax.XAxis.FontSize = 16;
% ax.YAxis.FontSize = 16;
% % title('mean axial velocity VS y^+, Re2, f=300 Hz, grid 8, upper part, different ppp')


% figure('Name','fig 6.6')
% semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',2)
% hold on
% semilogx((out.r2214xy(1:471)-ru02214xy)/delta_ni(2),out.U2214xy(1:471)./u_tau(2),'r','LineWidth',2)
% hold on
% semilogx((out.r2224xy(36:512)-ru02224xy)/delta_ni(2),out.U2224xy(36:512)./u_tau(2),'b','LineWidth',2)
% hold on
% semilogx((out.r2234xy(15:491)-ru02234xy)/delta_ni(2),out.U2234xy(15:491)./u_tau(2),'c','LineWidth',2) %476
% hold on
% semilogx(y_LDV./delta_ni(2), U_LDV_mean_filt./u_tau(2),'og','linewidth',2)
% hold on
% xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
% xlim([1 1000])
% hold on
% xlabel('y^+','fontsize',15)
% ylabel('U^+','fontsize',15)
% legend('DNS','ppp1','ppp2','ppp3','LDV')
% % title('mean axial velocity VS y^+, Re2, f=300 Hz, grid 4, upper part, different ppp')


figure('Name','fig 6.7','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
plot(((out.r2218xy(950)-out.r2218xy(501:950))./delta_ni(2)), out.U2218xy(501:950)./u_tau(2),'r-', 'LineWidth',2)
hold on
plot(((out.r2228xy(950)-out.r2228xy(501:950))./delta_ni(2)), out.U2228xy(501:950)./u_tau(2),'b-', 'LineWidth',2)
hold on
plot(((out.r2238xy(950)-out.r2238xy(501:950))./delta_ni(2)), out.U2238xy(501:950)./u_tau(2),'c-', 'LineWidth',2)
hold on
semilogx(y_LDV./delta_ni(2), U_LDV_mean_filt./u_tau(2),'og','linewidth',2)
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
xlim([1 1000])
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('U^+','fontsize',25)
legend('DNS','$ppp_1$','$ppp_2$','$ppp_3$','LDV','fontsize',15,'location','southeast','interpreter','latex')
% title('mean axial velocity VS y^+, Re2, f=300 Hz, grid 8, lower part, different ppp')


figure('Name','fig 6.8','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
plot(((out.r2214xy(947)-out.r2214xy(471:987))./delta_ni(2)), out.U2214xy(471:987)./u_tau(2),'r-', 'LineWidth',2)
hold on
plot(((out.r2224xy(987)-out.r2224xy(512:987))./delta_ni(2)), out.U2224xy(512:987)./u_tau(2),'b-', 'LineWidth',2)
hold on
plot(((out.r2234xy(967)-out.r2234xy(491:967))./delta_ni(2)), out.U2234xy(491:967)./u_tau(2),'c-', 'LineWidth',2)
hold on
semilogx(y_LDV./delta_ni(2), U_LDV_mean_filt./u_tau(2),'og','linewidth',2)
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlim([1 1000])
xlabel('y^+','fontsize',25)
ylabel('U^+','fontsize',25)
legend('DNS','$ppp_1$','$ppp_2$','$ppp_3$','LDV','fontsize',15,'location','southeast','interpreter','latex')
% title('mean axial velocity VS y^+, Re2, f=300 Hz, grid 4  lower part, different ppp')


%%
close all

%% confronto figura 6 Re2 f2
% figure('Name','fig 6.9')
% semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',2)
% hold on
% plot(((out.r2318xy(52:501)-out.r2318xy(52))./delta_ni(2)), out.U2318xy(52:501)./u_tau(2),'r-', 'LineWidth',2)
% hold on
% plot(((out.r2328xy(52:501)-out.r2328xy(52))./delta_ni(2)), out.U2328xy(52:501)./u_tau(2),'b-', 'LineWidth',2)
% hold on
% plot(((out.r2338xy(52:501)-out.r2338xy(52))./delta_ni(2)), out.U2338xy(52:501)./u_tau(2),'c-', 'LineWidth',2)
% hold on
% semilogx(y_LDV./delta_ni(2), U_LDV_mean_filt./u_tau(2),'og','linewidth',2)
% hold on
% xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
% xlim([1 1000])
% hold on
% xlabel('y^+','fontsize',15)
% ylabel('U^+','fontsize',15)
% legend('DNS','ppp1','ppp2','ppp3','LDV','fontsize',15)
% ax = gca;
% ax.XAxis.FontSize = 16;
% ax.YAxis.FontSize = 16;
% title('mean axial velocity VS y^+, Re2, f=480 Hz, grid 8, upper part, different ppp')


% figure('Name','fig 6.10')
% semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',2)
% hold on
% semilogx((out.r2314xy(35:511)-ru02314xy)/delta_ni(2),out.U2314xy(35:511)./u_tau(2),'r','LineWidth',2)
% hold on
% semilogx((out.r2324xy(12:488)-ru02324xy)/delta_ni(2),out.U2324xy(12:488)./u_tau(2),'b','LineWidth',2)
% hold on
% semilogx((out.r2334xy(15:491)-ru02334xy)/delta_ni(2),out.U2334xy(15:491)./u_tau(2),'c','LineWidth',2) %476
% hold on
% semilogx(y_LDV./delta_ni(2), U_LDV_mean_filt./u_tau(2),'og','linewidth',2)
% hold on
% xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
% xlim([1 1000])
% hold on
% xlabel('y^+','fontsize',15)
% ylabel('U^+','fontsize',15)
% legend('DNS','ppp1','ppp2','ppp3','LDV')
% title('mean axial velocity VS y^+, Re2, f=480 Hz, grid 4, upper part, different ppp')


figure('Name','fig 6.11','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
plot(((out.r2318xy(950)-out.r2318xy(501:950))./delta_ni(2)), out.U2318xy(501:950)./u_tau(2),'r-', 'LineWidth',2)
hold on
plot(((out.r2328xy(950)-out.r2328xy(501:950))./delta_ni(2)), out.U2328xy(501:950)./u_tau(2),'b-', 'LineWidth',2)
hold on
plot(((out.r2338xy(950)-out.r2338xy(501:950))./delta_ni(2)), out.U2338xy(501:950)./u_tau(2),'c-', 'LineWidth',2)
hold on
semilogx(y_LDV./delta_ni(2), U_LDV_mean_filt./u_tau(2),'og','linewidth',2)
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
xlim([1 1000])
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('U^+','fontsize',25)
legend('DNS','$ppp_1$','$ppp_2$','$ppp_3$','LDV','fontsize',20,'location','southeast','interpreter','latex')
% title('mean axial velocity VS y^+, Re2, f=480 Hz, grid 8, lower part, different ppp')


figure('Name','fig 6.12','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
plot(((out.r2314xy(987)-out.r2314xy(511:987))./delta_ni(2)), out.U2314xy(511:987)./u_tau(2),'r-', 'LineWidth',2)
hold on
plot(((out.r2324xy(964)-out.r2324xy(488:964))./delta_ni(2)), out.U2324xy(488:964)./u_tau(2),'b-', 'LineWidth',2)
hold on
plot(((out.r2334xy(967)-out.r2334xy(491:967))./delta_ni(2)), out.U2334xy(491:967)./u_tau(2),'c-', 'LineWidth',2)
hold on
semilogx(y_LDV./delta_ni(2), U_LDV_mean_filt./u_tau(2),'og','linewidth',2)
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlim([1 1000])
xlabel('y^+','fontsize',25)
ylabel('U^+','fontsize',25)
legend('DNS','$ppp_1$','$ppp_2$','$ppp_3$','LDV','fontsize',20,'location','southeast','interpreter','latex')
% title('mean axial velocity VS y^+, Re2, f=480 Hz, grid 4, lower part, different ppp')

%% fig 6, stesso ppp e grid, diversa frequenza
figure('name','fig 6.13','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',3)
hold on
plot(((out.r2234xy(967)-out.r2234xy(491:967))./delta_ni(2)), out.U2234xy(491:967)./u_tau(2),'r-', 'LineWidth',3)
hold on
plot(((out.r2334xy(967)-out.r2334xy(491:967))./delta_ni(2)), out.U2334xy(491:967)./u_tau(2),'b-', 'LineWidth',3)
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
xlim([1 1000])
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('U^+','fontsize',25)
legend('DNS','300 Hz','480 Hz','fontsize',25,'location','southeast')
% title('comparison f1 vs f2, grid 4, lower part, ppp3')

figure('name','fig 6.14','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',3)
hold on
plot(((out.r2224xy(987)-out.r2224xy(512:987))./delta_ni(2)), out.U2224xy(512:987)./u_tau(2),'r-', 'LineWidth',3)
hold on
plot(((out.r2324xy(964)-out.r2324xy(488:964))./delta_ni(2)), out.U2324xy(488:964)./u_tau(2),'b-', 'LineWidth',3)
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
xlim([1 1000])
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('U^+','fontsize',25)
legend('DNS','300 Hz','480 Hz','fontsize',25,'location','southeast')
% title('comparison f1 vs f2, grid 4, lower part, ppp2')


% figure('name','fig 6.15')
% semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',2)
% hold on
% plot(((out.r2238xy(950)-out.r2238xy(501:950))./delta_ni(2)), out.U2238xy(501:950)./u_tau(2),'r-', 'LineWidth',2)
% hold on
% plot(((out.r2338xy(950)-out.r2338xy(501:950))./delta_ni(2)), out.U2338xy(501:950)./u_tau(2),'b-', 'LineWidth',2)
% hold on
% xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
% xlim([1 1000])
% xlabel('y^+','fontsize',15)
% ylabel('U^+','fontsize',15)
% legend('DNS','300 Hz','480 Hz')
% title('comparison f1 vs f2, grid 8, lower part, ppp3')
% 
% 
% figure('name','fig 6.16')
% semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',2)
% hold on
% plot(((out.r2238xy(52:501)-out.r2238xy(52))./delta_ni(2)), out.U2238xy(52:501)./u_tau(2),'r-', 'LineWidth',2)
% hold on
% plot(((out.r2338xy(52:501)-out.r2338xy(52))./delta_ni(2)), out.U2338xy(52:501)./u_tau(2),'b-', 'LineWidth',2)
% hold on
% xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
% xlim([1 1000])
% xlabel('y^+','fontsize',15)
% ylabel('U^+','fontsize',15)
% legend('DNS','300 Hz','480 Hz')
% title('comparison f1 vs f2, grid 8, upper part, ppp3')


figure('name','fig 6.17','Position',[100 100 700 400])
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',3)
hold on
plot(((out.r2214xy(947)-out.r2214xy(471:987))./delta_ni(2)), out.U2214xy(471:987)./u_tau(2),'r-', 'LineWidth',3)
hold on
plot(((out.r2314xy(987)-out.r2314xy(511:987))./delta_ni(2)), out.U2314xy(511:987)./u_tau(2),'b-', 'LineWidth',3)
hold on
xline((0.1*R)/delta_ni(2),'--k','LineWidth',2.5)  %inner layer (y/R<0.1)
xlim([1 1000])
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xlabel('y^+','fontsize',25)
ylabel('U^+','fontsize',25)
legend('DNS','300 Hz','480 Hz','fontsize',25,'location','southeast')
% title('comparison f1 vs f2, grid 4, lower part, ppp1')



% %% N particles vs y plus
% figure('Name','particles')
% semilogx((out.r2214xy(49:471)-ru02214xy)/delta_ni(2), (out.N_part2214xy(49:471))/u_tau(2),'r','LineWidth',1)
% hold on
% semilogx((rb02214xy-out.r2214xy(471:899))/delta_ni(2),(out.N_part2214xy(471:899))/u_tau(2),'--r','LineWidth',1)      %plot della parte con y>R
% hold on
% semilogx((out.r2224xy(84:512)-ru02224xy)/delta_ni(2), (out.N_part2224xy(84:512))/u_tau(2),'b','LineWidth',1 )
% hold on
% semilogx((rb02224xy-out.r2224xy(512:939))/delta_ni(2),(out.N_part2224xy(512:939))/u_tau(2),'--b','LineWidth',1 )      %plot della parte con y>R
% hold on
% semilogx((out.r2234xy(63:491)-ru02234xy)/delta_ni(2), (out.N_part2234xy(63:491))/u_tau(2),'c','LineWidth',1 )
% hold on
% semilogx((rb02234xy-out.r2234xy(491:919))/delta_ni(2),(out.N_part2234xy(491:919))/u_tau(2),'--c','LineWidth',1 )      %plot della parte con y>R
% hold on
% xlabel('y^+','fontsize',15)
% ylabel('$N_{part}$','Interpreter','latex','fontsize',20)
% legend('LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
%     'LPT,ppp3,up','LPT,ppp3,low')
% title('LPT streamwise fluctuations vs y data for grid 4,f1 at different ppp, upper and lower part of the pipe')
