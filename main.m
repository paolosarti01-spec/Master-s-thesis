% analisi delle incertezze al variare dei parametri scelti


clear
close all
clc


%% dati
D_m = 0.0456;           %[m]
R_m = D_m/2;
A = pi*(D_m^2/4);      %[m^2]
Q_m = [0.25; 0.48];  %[Kg/s], misurata dal flussimetro
rho = 1010.81;       %[Kg/m^3], misurata dal flussimetro
Temperature = 20.96; %[°C], misurata dal flussimetro
D = 45.6; %[mm]
R = D/2; %[mm]

%richiamo la function per calcolare viscosità dinamica, frazione di massa e
%indice di contrazione
[mu, w_g, contraction] = densityViscosityWaterGlycerolSolution(Temperature,rho);
ni = mu/rho; %viscosità cinematica della miscela calcolata a partire da rho tramite la letteratura
refractive_index = 1.333*(1-w_g)+1.474*w_g; %stima indice di rifrazione: è basato su acqua distillata, quindi il valore potrebbe discostarsi da quello misurato con il refrattometro


%% proprietà flusso
Q_v = Q_m./rho;  %[m^3/s]
U_b = Q_v./A;  %[m/s]
Re = (U_b*D_m)./ni; 
f = [0.03560; 0.03033];   %da Re calcolato, usando plot digitizer   % [0.035; 0.0285];  %friction factor: stima da articolo DNS figura 3
f_blasius = 0.3164*Re.^(-1/4);
u_tau = U_b.*sqrt(f./8);  % f = 8*(u_tau/U_b)^2 
delta_ni = ni./u_tau * 10^3; %[mm]
Re_tau = R_m./(delta_ni*10^-3); 
tau_wall = rho*u_tau.^2;

%% estrazione dati
var1 = ["Q025", "Q048"];
var2 = ["f160","f300", "f480"];
var3 = ["ppp1","ppp2","ppp3"];
var4 = ["grid4","grid8"];
var5 = ["planex","planey","planez"];
var6 = ["polx","poly","polz"];

T = struct();
for ii = 1:length(var1)
    for jj = 1:length(var2)
        for kk = 1:length(var3)
            for tt = 1:length(var4)
                for qq = 1:length(var5)
                    for rr = 1:length(var6)
                      S.(var1{ii}).(var2{jj}).(var3{kk}).(var4{tt}).(var5{qq}).(var6{rr}) = [];
                    end
                end
            end
        end
    end
end

for ii = 1:length(var1)
    for jj = 1:length(var2)
        for kk = 1:length(var3)
            for tt = 1:length(var4)
                for qq = 1:length(var5)
                    for rr = 1:length(var6)
                       basename = var1{ii} + "_" + var2{jj} + "_" + var3{kk} + "_" + var4{tt} + "_" + var5{qq} + "_" +var6{rr}; 
                       filepattern = fullfile('../dati/camp1000/', basename + "*.csv");
                       filelist = dir(filepattern);
                       S.(var1{ii}).(var2{jj}).(var3{kk}).(var4{tt}).(var5{qq}).(var6{rr}) = filelist;
                     
                      filepaths = fullfile({filelist.folder}, {filelist.name});
                      dataCell = cell(1, numel(filepaths));
                      for f = 1:numel(filepaths)
                          dataCell{f} = readtable(filepaths{f});
                          warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
                      end
                    
                      T.(var1{ii}).(var2{jj}).(var3{kk}).(var4{tt}).(var5{qq}).(var6{rr}) = dataCell;
                    end
                end
            end
        end
    end
end


%% LDV
ldv_file = dir(fullfile('../dati/LDV/', '*z*.csv'));
names = {ldv_file.name};
nums = regexp(names, 'z(\d+)', 'tokens');
nums = cellfun(@(x) str2double(x{1}), nums);
[~, idx] = sort(nums);
ldv_file = ldv_file(idx);
LDV = cell(numel(ldv_file),1);
LDV_filt = cell(numel(ldv_file),1);
valid_idx = cell(numel(ldv_file),1);
U_LDV_mean = zeros(numel(ldv_file),1);

for k = 1:numel(ldv_file)
    filename_LDV = fullfile('../dati/LDV/', ldv_file(k).name);    
    L = readtable(filename_LDV); 
    warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
    Vel_LDV = [L.VelocityCh_1_m_sec_, L.VelocityCh_2_m_sec_];
    LDV{k} = Vel_LDV;
    N_LDV = length(Vel_LDV(:,1));
    U_LDV_mean(k) = mean(L.VelocityCh_1_m_sec_);
    V_LDV_mean(k) = mean(L.VelocityCh_2_m_sec_);
    u_std_LDV(k) = sqrt((1/(N_LDV-1))*sum((LDV{k}(:,1)-U_LDV_mean(k)).^2));
    v_std_LDV(k) = sqrt((1/(N_LDV-1))*sum((LDV{k}(:,2)-V_LDV_mean(k)).^2));
    Rxy_LDV(k) = mean((LDV{k}(:,1)-U_LDV_mean(k)).*(LDV{k}(:,2)-V_LDV_mean(k)));

    % -------- FILTRO OUTLIER --------
    u_mean0 = mean(Vel_LDV(:,1));
    u_std0  = std(Vel_LDV(:,1));
    v_mean0 = mean(Vel_LDV(:,2));
    v_std0  = std(Vel_LDV(:,2));
    % thr = 3;
    if k<=3
        thr = 4;
    else
        thr = 3;
    end

    valid_idx = abs(Vel_LDV(:,1)-u_mean0) < thr*u_std0 & abs(Vel_LDV(:,2)-v_mean0) < thr*v_std0;

    Vel_LDV_filt = Vel_LDV(valid_idx,:);      

    LDV_filt{k} = Vel_LDV_filt;

    N_LDV_filt = size(Vel_LDV_filt,1);
    U_LDV_mean_filt(k) = mean(Vel_LDV_filt(:,1));
    V_LDV_mean_filt(k) = mean(Vel_LDV_filt(:,2));
    u_std_LDV_filt(k) = std(Vel_LDV_filt(:,1));
    v_std_LDV_filt(k) = std(Vel_LDV_filt(:,2));
    Rxy_LDV_filt(k) = mean((Vel_LDV_filt(:,1)-U_LDV_mean_filt(k)) .* (Vel_LDV_filt(:,2)-V_LDV_mean_filt(k)));
end
LDV_y_0 = 0.9;     %mm da parete
y_LDV = LDV_y_0 + [0 0.5 1 1.5 2 3 4 5 6 7 8 9 10];   %[mm]



%% estrazione variabili
out = struct();

Qmap  = containers.Map({'Q025','Q048'}, [1 2]);
Fmap  = containers.Map({'f160','f300','f480'}, [1 2 3]);
Cmap = struct( ...
    "VelocityU","U", "VelocityV","V", "VelocityW","W", ...
    "StandardDeviationVx","u_std", "StandardDeviationVy","v_std", "StandardDeviationVz","w_std", ...
    "UncertaintyVx","u_unc", ...
    "arc_length","r",...
    "du_dy","du_dy","du_dz","du_dz", ...
    "ReynoldsStressRxy","Rxy",  "ReynoldsStressRxz","Rxz", ...
    "NumberOfParticles","N_part" ...
    );
Pmap = struct("planex","x", "planey","y", "planez","z");
Imap = struct("polx","x","poly","y","polz","z");

ppp_list  = 1:3;
grid_list = [4 8];
planes = fieldnames(Pmap);
polFields = fieldnames(Imap);

for Qk = keys(Qmap)
    Qtag = Qk{1};
    Qi   = Qmap(Qtag);
    
    for Fk = keys(Fmap)
        Ftag = Fk{1};
        Fi   = Fmap(Ftag);
        
        for p = ppp_list
            for g = grid_list
                for pip = 1:numel(planes)
                    planeField = planes{pip};
                    for pf = 1:numel(polFields)
                        polField = polFields{pf};
                        
                        dataCell = T.(Qtag).(Ftag).(sprintf('ppp%d',p)).(sprintf('grid%d',g)).(planeField).(polField);
                        if isempty(dataCell)
                            continue
                        end
                        
                        for fidx = 1:numel(dataCell)
                            tbl = dataCell{fidx};  % estrai la tabella
                            compFields = fieldnames(tbl);
                            
                            for ci = 1:numel(compFields)
                                field = compFields{ci};
                                
                                if isfield(Cmap, field)
                                    compLetter = Cmap.(field);
                                    lastLetter = Imap.(polField);
                                    planeLetter = Pmap.(planeField);

                                    % costruzione nome variabile (char)
                                    suffix = sprintf('%d%d%d%d%s%s', Qi, Fi, p, g, planeLetter, lastLetter);
                                    varName = sprintf('%s%s', compLetter, suffix);

                                    % estrai dati dalla tabella
                                    polData = tbl.(field);

                                    % variabile base (segno solo per U)
                                    if compLetter == "U"
                                        out.(varName) = -polData;
                                    else
                                        out.(varName) = polData;
                                    end

                                    % costanti per scalatura
                                    if Qi == 1
                                        cost_ni  = delta_ni(1);
                                        cost_tau = u_tau(1);
                                    else
                                        cost_ni  = delta_ni(2);
                                        cost_tau = u_tau(2);
                                    end

                                    % PLUS mapping
                                    if compLetter == "y"
                                        y_plusName = sprintf('y_plus%s', suffix);
                                        out.(y_plusName) = out.(varName) ./ cost_ni;
                                    end

                                    if compLetter == "r"
                                        r_plusName = sprintf('r_plus%s', suffix);
                                        out.(r_plusName) = out.(varName) ./ cost_ni;
                                    end

                                    if compLetter == "U"
                                        U_plusName = sprintf('U_plus%s', suffix);
                                        out.(U_plusName) = out.(varName) ./ cost_tau;
                                    end

                                    % u_std_true mapping
                                    if compLetter == "u_std"
                                        Nname = sprintf('N_part%s', suffix);
                                        if isfield(out, Nname)
                                            Nval = out.(Nname);
                                        else
                                            error("La variabile %s non esiste in out.", Nname);
                                        end

                                        unc_std_u = out.(varName) .* sqrt(1 ./ (2 * (Nval - 1)));
                                        u_std_trueName = sprintf('u_std_true%s', suffix);
                                        out.(u_std_trueName) = sqrt(out.(varName).^2 - unc_std_u.^2);
                                    end

                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
















%% plot
figure(1)
grid on
hold on
plot(out.r2234xy,out.du_dz2234xy,'k-','LineWidth',2)
hold on
xlabel('y')
ylabel('$\frac{\partial u}{\partial y}$','Interpreter','latex')
title('$\frac{\partial u}{\partial y}$ vs y','Interpreter','latex')

figure(2)
grid on
hold on
plot(out.U1118xy,out.r1118xy,'k','LineWidth',2)
xlabel('U')
ylabel('y')
title('velocity profile along y')
%% massimo U e minimo du_dy
% clc
% tag = ['1134xz'];
% Uvar    = ['U' tag];
% dudyvar = ['du_dy' tag];
% rvar    = ['r' tag];
% U       = out.(Uvar);
% du_dy   = out.(dudyvar);
% r       = out.(rvar);
% [U_max, idx_Umax] = max(U);
% [du_dy_min, idx_dudy] = min(abs(du_dy));
% r_Umax     = r(idx_Umax);
% r_du_dymin = r(idx_dudy);
% [~, idx_ru0] = min(abs(abs(r_Umax - 22.8) - r));
% [~, idx_rb0] = min(abs((r_Umax + 22.8) - r));

% if r_Umax < 22.8
%     disp('distanza dalla centerline minore del raggio');
% end
% if r(end) < (22.8 + r_Umax)
%     disp('distanza dalla centerline in basso minore del raggio');
% end

% fprintf('%4s%9s%12s%10s %6s \n','CL','r_CL','ru','rb')
% fprintf('\n')
% fprintf('%4d --> %7.4f   %6d   %8d\n', idx_Umax, r_Umax, idx_ru0, idx_rb0)

%%
close all

%% r = 0
%poly
ru01114xy = out.r1114xy(60);
rb01114xy = out.r1114xy(930);
ru01124xy = out.r1124xy(46);
rb01124xy = out.r1124xy(942);
ru01134xy = out.r1134xy(50);
rb01134xy = out.r1134xy(930);

ru01118xy = out.r1118xy(150);
rb01118xy = out.r1118xy(840);
ru01128xy = out.r1128xy(140);
rb01128xy = out.r1128xy(846);
ru01138xy = out.r1138xy(150);
rb01138xy = out.r1138xy(838);

ru02214xy = out.r2214xy(60);
rb02214xy = out.r2214xy(925);
ru02224xy = out.r2224xy(60);
rb02224xy = out.r2224xy(920);
ru02234xy = out.r2234xy(60);
rb02234xy = out.r2234xy(920);

ru02218xy = out.r2214xy(170);
rb02218xy = out.r2214xy(870);
ru02228xy = out.r2224xy(170);
rb02228xy = out.r2224xy(865);
ru02238xy = out.r2234xy(180);
rb02238xy = out.r2234xy(865);

ru02314xy = out.r2314xy(72);
rb02314xy = out.r2314xy(920);
ru02324xy = out.r2324xy(68);
rb02324xy = out.r2324xy(925);
ru02334xy = out.r2334xy(80);
rb02334xy = out.r2334xy(915);

ru02318xy = out.r2314xy(175);
rb02318xy = out.r2314xy(865);
ru02328xy = out.r2324xy(170);
rb02328xy = out.r2324xy(875);
ru02338xy = out.r2334xy(180);
rb02338xy = out.r2334xy(870);

%polz
ru01114xz = out.r1114xz(95);
rb01114xz = out.r1114xz(920);
ru01124xz = out.r1124xz(80);
rb01124xz = out.r1124xz(930);
ru01134xz = out.r1134xz(90);
rb01134xz = out.r1134xz(920);

ru01118xz = out.r1118xz(160);
rb01118xz = out.r1118xz(860);
ru01128xz = out.r1128xz(150);
rb01128xz = out.r1128xz(860);
ru01138xz = out.r1138xz(165);
rb01138xz = out.r1138xz(860);

ru02214xz = out.r2214xz(90);
rb02214xz = out.r2214xz(910);
ru02224xz = out.r2224xz(95);
rb02224xz = out.r2224xz(920);
ru02234xz = out.r2234xz(90);
rb02234xz = out.r2234xz(880);

ru02218xz = out.r2214xz(180);
rb02218xz = out.r2214xz(870);
ru02228xz = out.r2224xz(180);
rb02228xz = out.r2224xz(865);
ru02238xz = out.r2234xz(180);
rb02238xz = out.r2234xz(830);

ru02314xz = out.r2314xz(95);
rb02314xz = out.r2314xz(900);
ru02324xz = out.r2324xz(110);
rb02324xz = out.r2324xz(910);
ru02334xz = out.r2334xz(110);
rb02334xz = out.r2334xz(895);

ru02318xz = out.r2314xz(175);
rb02318xz = out.r2314xz(850);
ru02328xz = out.r2324xz(175);
rb02328xz = out.r2324xz(850);
ru02338xz = out.r2334xz(175);
rb02338xz = out.r2334xz(850);


%% confronto DNS fig 7a-Re1-plot over line y
DNS7a_verde = '../grafici letteratura/DNS fig 7a/Re1.csv';
DNS7a_verde_dat = readtable(DNS7a_verde);


figure(3)
semilogx(DNS7a_verde_dat{:,1},DNS7a_verde_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1114xy(120:476)-ru01114xy)/delta_ni(1), (out.u_std1114xy(120:476))/u_tau(1),'k','LineWidth',2 )
hold on
semilogx((rb01114xy-out.r1114xy(440:870))/delta_ni(1),(out.u_std1114xy(440:870))/u_tau(1),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1124xy(105:476)-ru01124xy)/delta_ni(1), (out.u_std1124xy(105:476))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01124xy-out.r1124xy(440:870))/delta_ni(1),(out.u_std1124xy(440:870))/u_tau(1),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1134xy(115:476)-ru01134xy)/delta_ni(1), (out.u_std1134xy(115:476))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01134xy-out.r1134xy(440:870))/delta_ni(1),(out.u_std1134xy(440:870))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{z,rms}$','Interpreter','latex','FontSize',20)
legend('El Khoury Re 5300','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT streamwise fluctuations vs y data for grid 4 at different ppp, upper and lower part of the pipe')


figure(4)
semilogx(DNS7a_verde_dat{:,1},DNS7a_verde_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1118xy(210:540)-ru01118xy)/delta_ni(1), (out.u_std1118xy(210:540))/u_tau(1),'k','LineWidth',2 )
hold on
semilogx((rb01118xy-out.r1118xy(440:780))/delta_ni(1),(out.u_std1118xy(440:780))/u_tau(1),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1128xy(195:540)-ru01128xy)/delta_ni(1), (out.u_std1128xy(195:540))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01128xy-out.r1128xy(440:780))/delta_ni(1),(out.u_std1128xy(440:780))/u_tau(1),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1138xy(215:540)-ru01138xy)/delta_ni(1), (out.u_std1138xy(215:540))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01138xy-out.r1138xy(440:780))/delta_ni(1),(out.u_std1138xy(440:780))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{z,rms}$','Interpreter','latex','FontSize',20)
legend('El Khoury Re 5300','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT streamwise fluctuations vs y data for grid 8 at different ppp, upper and lower part of the pipe')

%% confronto DNS fig 7a-Re1-plot over line z
DNS7a_verde = '../grafici letteratura/DNS fig 7a/Re1.csv';
DNS7a_verde_dat = readtable(DNS7a_verde);


figure(5)
semilogx(DNS7a_verde_dat{:,1},DNS7a_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx((out.r1114xz(155:476)-ru01114xz)/delta_ni(1), (out.u_std1114xz(155:476))/u_tau(1),'k','LineWidth',2 )
hold on
semilogx((rb01114xz-out.r1114xz(440:860))/delta_ni(1),(out.u_std1114xz(440:860))/u_tau(1),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1124xz(145:476)-ru01124xz)/delta_ni(1), (out.u_std1124xz(145:476))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01124xz-out.r1124xz(440:870))/delta_ni(1),(out.u_std1124xz(440:870))/u_tau(1),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1134xz(150:476)-ru01134xz)/delta_ni(1), (out.u_std1134xz(150:476))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01134xz-out.r1134xz(440:860))/delta_ni(1),(out.u_std1134xz(440:860))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{z,rms}$','Interpreter','latex')
legend('El Khoury Re 5300','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT streamwise fluctuations vs z data for grid 4 at different ppp, front and rear part of the pipe')

figure(6)
semilogx(DNS7a_verde_dat{:,1},DNS7a_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx((out.r1118xz(220:540)-ru01118xz)/delta_ni(1), (out.u_std1118xz(220:540))/u_tau(1),'k','LineWidth',2 )
hold on
semilogx((rb01118xz-out.r1118xz(440:795))/delta_ni(1),(out.u_std1118xz(440:795))/u_tau(1),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1128xz(210:540)-ru01128xz)/delta_ni(1), (out.u_std1128xz(210:540))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01128xz-out.r1128xz(440:800))/delta_ni(1),(out.u_std1128xz(440:800))/u_tau(1),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1138xz(225:540)-ru01138xz)/delta_ni(1), (out.u_std1138xz(225:540))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01138xz-out.r1138xz(440:800))/delta_ni(1),(out.u_std1138xz(440:800))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{z,rms}$','Interpreter','latex')
legend('El Khoury Re 5300','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT streamwise fluctuations vs z data for grid 8 at different ppp, front and rear part of the pipe')

%%
close all

%% confronto DNS fig 7a-Re2-plot over line y
DNS7a_blu = '../grafici letteratura/DNS fig 7a/Re2.csv';
DNS7a_blu_dat = readtable(DNS7a_blu);

figure(7)
semilogx(DNS7a_blu_dat{:,1},DNS7a_blu_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), u_std_LDV_filt(1:13)/u_tau(2),'oc','linewidth',2)
hold on
semilogx((out.r2214xy(110:510)-ru02214xy)/delta_ni(2), (out.u_std2214xy(110:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02214xy-out.r2214xy(450:890))/delta_ni(2),(out.u_std2214xy(450:890))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2224xy(92:520)-ru02224xy)/delta_ni(2), (out.u_std2224xy(92:520))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02224xy-out.r2224xy(480:890))/delta_ni(2),(out.u_std2224xy(480:890))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2234xy(105:520)-ru02234xy)/delta_ni(2), (out.u_std2234xy(105:520))/u_tau(2),'b','LineWidth',2 )
hold on
semilogx((rb02234xy-out.r2234xy(480:885))/delta_ni(2),(out.u_std2234xy(480:885))/u_tau(2),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{z,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT streamwise fluctuations vs y data for grid 4,f1 at different ppp, upper and lower part of the pipe')


figure(8)
semilogx(DNS7a_blu_dat{:,1},DNS7a_blu_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), u_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2218xy(200:510)-ru02218xy)/delta_ni(2), (out.u_std2218xy(200:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02218xy-out.r2218xy(470:785))/delta_ni(2),(out.u_std2218xy(470:785))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2228xy(200:510)-ru02228xy)/delta_ni(2), (out.u_std2228xy(200:510))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02228xy-out.r2228xy(470:785))/delta_ni(2),(out.u_std2228xy(470:785))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2238xy(200:520)-ru02238xy)/delta_ni(2), (out.u_std2238xy(200:520))/u_tau(2),'b','LineWidth',2 )
hold on
semilogx((rb02238xy-out.r2238xy(470:775))/delta_ni(2),(out.u_std2238xy(470:775))/u_tau(2),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{z,rms}$','Interpreter','latex','fontsize',20)
legend('El Khoury Re 11700','LDV','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT streamwise fluctuations vs y data for grid 8,f1 at different ppp, upper and lower part of the pipe')



figure(9)
semilogx(DNS7a_blu_dat{:,1},DNS7a_blu_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), u_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2314xy(110:510)-ru02314xy)/delta_ni(2), (out.u_std2314xy(110:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02314xy-out.r2314xy(450:880))/delta_ni(2),(out.u_std2314xy(450:880))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2324xy(105:520)-ru02324xy)/delta_ni(2), (out.u_std2324xy(105:520))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02324xy-out.r2324xy(450:890))/delta_ni(2),(out.u_std2324xy(450:890))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2334xy(115:520)-ru02334xy)/delta_ni(2), (out.u_std2334xy(115:520))/u_tau(2),'b','LineWidth',2 )
hold on
semilogx((rb02334xy-out.r2334xy(480:880))/delta_ni(2),(out.u_std2334xy(480:880))/u_tau(2),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{z,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT streamwise fluctuations vs y data for grid 4,f2 at different ppp, upper and lower part of the pipe')



figure(10)
semilogx(DNS7a_blu_dat{:,1},DNS7a_blu_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), u_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2318xy(200:510)-ru02318xy)/delta_ni(2), (out.u_std2318xy(200:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02318xy-out.r2318xy(470:775))/delta_ni(2),(out.u_std2318xy(470:775))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2328xy(200:510)-ru02328xy)/delta_ni(2), (out.u_std2328xy(200:510))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02328xy-out.r2328xy(470:790))/delta_ni(2),(out.u_std2328xy(470:790))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2338xy(205:510)-ru02338xy)/delta_ni(2), (out.u_std2338xy(205:510))/u_tau(2),'b','LineWidth',2 )
hold on
semilogx((rb02338xy-out.r2338xy(470:790))/delta_ni(2),(out.u_std2338xy(470:790))/u_tau(2),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{z,rms}$','Interpreter','latex','fontsize',20)
legend('El Khoury Re 11700','LDV','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT streamwise fluctuations vs y data for grid 8,f2 at different ppp, upper and lower part of the pipe')


%% confronto DNS fig 7a-Re2-plot over line z
DNS7a_blu = '../grafici letteratura/DNS fig 7a/Re2.csv';
DNS7a_blu_dat = readtable(DNS7a_blu);

figure(11)
semilogx(DNS7a_blu_dat{:,1},DNS7a_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), u_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2214xz(125:510)-ru02214xz)/delta_ni(2), (out.u_std2214xz(125:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02214xz-out.r2214xz(450:875))/delta_ni(2),(out.u_std2214xz(450:875))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2224xz(130:520)-ru02224xz)/delta_ni(2), (out.u_std2224xz(130:520))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02224xz-out.r2224xz(480:885))/delta_ni(2),(out.u_std2224xz(480:885))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2234xz(125:520)-ru02234xz)/delta_ni(2), (out.u_std2234xz(125:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02234xz-out.r2234xz(480:845))/delta_ni(2),(out.u_std2234xz(480:845))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{z,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT streamwise fluctuations vs z data for grid 4,f1 at different ppp, front and rear part of the pipe')

figure(12)
semilogx(DNS7a_blu_dat{:,1},DNS7a_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), u_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2218xz(210:510)-ru02218xz)/delta_ni(2), (out.u_std2218xz(210:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02218xz-out.r2218xz(470:820))/delta_ni(2),(out.u_std2218xz(470:820))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2228xz(210:510)-ru02228xz)/delta_ni(2), (out.u_std2228xz(210:510))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02228xz-out.r2228xz(470:810))/delta_ni(2),(out.u_std2228xz(470:810))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2238xz(220:520)-ru02238xz)/delta_ni(2), (out.u_std2238xz(220:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02238xz-out.r2238xz(470:810))/delta_ni(2),(out.u_std2238xz(470:810))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{z,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT streamwise fluctuations vs z data for grid 8,f1 at different ppp, front and rear part of the pipe')

figure(13)
semilogx(DNS7a_blu_dat{:,1},DNS7a_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), u_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2314xz(130:510)-ru02314xz)/delta_ni(2), (out.u_std2314xz(130:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02314xz-out.r2314xz(450:865))/delta_ni(2),(out.u_std2314xz(450:865))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2324xz(145:540)-ru02324xz)/delta_ni(2), (out.u_std2324xz(145:540))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02324xz-out.r2324xz(450:875))/delta_ni(2),(out.u_std2324xz(450:875))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2334xz(145:520)-ru02334xz)/delta_ni(2), (out.u_std2334xz(145:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02334xz-out.r2334xz(480:860))/delta_ni(2),(out.u_std2334xz(480:860))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{z,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT streamwise fluctuations vs z data for grid 4,f2 at different ppp, front and rear part of the pipe')


figure(14)
semilogx(DNS7a_blu_dat{:,1},DNS7a_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), u_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2318xz(210:510)-ru02318xz)/delta_ni(2), (out.u_std2318xz(210:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02318xz-out.r2318xz(420:815))/delta_ni(2),(out.u_std2318xz(420:815))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2328xz(210:510)-ru02328xz)/delta_ni(2), (out.u_std2328xz(210:510))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02328xz-out.r2328xz(470:820))/delta_ni(2),(out.u_std2328xz(470:820))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2338xz(210:510)-ru02338xz)/delta_ni(2), (out.u_std2338xz(210:510))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02338xz-out.r2338xz(470:816))/delta_ni(2),(out.u_std2338xz(470:816))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{z,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT streamwise fluctuations vs z data for grid 8,f2 at different ppp, front and rear part of the pipe')


%%
close all


%% confronto DNS fig 7b-Re1-plot over line y
DNS7b_verde = '../grafici letteratura/DNS fig 7b/Re1.csv';
DNS7b_verde_dat = readtable(DNS7b_verde);

figure(15)
semilogx(DNS7b_verde_dat{:,1},DNS7b_verde_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1114xy(120:476)-ru01114xy)/delta_ni(1), (out.v_std1114xy(120:476))/u_tau(1),'k','LineWidth',2 )
hold on
semilogx((rb01114xy-out.r1114xy(440:870))/delta_ni(1),(out.v_std1114xy(440:870))/u_tau(1),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1124xy(105:476)-ru01124xy)/delta_ni(1), (out.v_std1124xy(105:476))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01124xy-out.r1124xy(440:870))/delta_ni(1),(out.v_std1124xy(440:870))/u_tau(1),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1134xy(115:476)-ru01134xy)/delta_ni(1), (out.v_std1134xy(115:476))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01134xy-out.r1134xy(440:870))/delta_ni(1),(out.v_std1134xy(440:870))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+','fontsize',15)
ylabel('$u^+_{r,rms}$','Interpreter','latex','fontsize',20)
legend('El Khoury Re 5300','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT radial fluctuations vs y for grid 4 at different ppp, upper and lower part of the pipe')
 

figure(16)
semilogx(DNS7b_verde_dat{:,1},DNS7b_verde_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
semilogx((out.r1118xy(210:540)-ru01118xy)/delta_ni(1), (out.v_std1118xy(210:540))/u_tau(1),'k','LineWidth',2 )
hold on
semilogx((rb01118xy-out.r1118xy(440:780))/delta_ni(1),(out.v_std1118xy(440:780))/u_tau(1),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1128xy(195:540)-ru01128xy)/delta_ni(1), (out.v_std1128xy(195:540))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01128xy-out.r1128xy(440:780))/delta_ni(1),(out.v_std1128xy(440:780))/u_tau(1),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1138xy(215:540)-ru01138xy)/delta_ni(1), (out.v_std1138xy(215:540))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01138xy-out.r1138xy(440:780))/delta_ni(1),(out.v_std1138xy(440:780))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+','fontsize',15)
ylabel('$u^+_{r,rms}$','Interpreter','latex','fontsize',20)
legend('El Khoury Re 5300','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT radial fluctuations vs y for grid 8 at different ppp, upper and lower part of the pipe')


%% confronto DNS fig 7b-Re1-plot over line z
DNS7b_verde = '../grafici letteratura/DNS fig 7b/Re1.csv';
DNS7b_verde_dat = readtable(DNS7b_verde);

figure(17)
semilogx(DNS7b_verde_dat{:,1},DNS7b_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx((out.r1114xz(120:476)-ru01114xz)/delta_ni(1), (out.w_std1114xz(120:476))/u_tau(1),'k','LineWidth',2 )
hold on
semilogx((rb01114xz-out.r1114xz(440:870))/delta_ni(1),(out.w_std1114xz(440:870))/u_tau(1),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1124xz(105:476)-ru01124xz)/delta_ni(1), (out.w_std1124xz(105:476))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01124xz-out.r1124xz(440:870))/delta_ni(1),(out.w_std1124xz(440:870))/u_tau(1),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1134xz(115:476)-ru01134xz)/delta_ni(1), (out.w_std1134xz(115:476))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01134xz-out.r1134xz(440:870))/delta_ni(1),(out.w_std1134xz(440:870))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 5300','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT radial fluctuations vs z for grid 4 at different ppp, front and rear part of the pipe')
 

figure(18)
semilogx(DNS7b_verde_dat{:,1},DNS7b_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx((out.r1118xz(210:540)-ru01118xz)/delta_ni(1), (out.w_std1118xz(210:540))/u_tau(1),'k','LineWidth',2 )
hold on
semilogx((rb01118xz-out.r1118xz(440:780))/delta_ni(1),(out.w_std1118xz(440:780))/u_tau(1),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1128xz(195:540)-ru01128xz)/delta_ni(1), (out.w_std1128xz(195:540))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01128xz-out.r1128xz(440:780))/delta_ni(1),(out.w_std1128xz(440:780))/u_tau(1),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1138xz(215:540)-ru01138xz)/delta_ni(1), (out.w_std1138xz(215:540))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01138xz-out.r1138xz(440:780))/delta_ni(1),(out.w_std1138xz(440:780))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 5300','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT radial fluctuations vs z for grid 8 at different ppp, front and rear part of the pipe')

%%
close all

%% confronto DNS fig 7b-Re2 - plot over line y
DNS7b_blu = '../grafici letteratura/DNS fig 7b/Re2.csv';
DNS7b_blu_dat = readtable(DNS7b_blu);

figure(19)
semilogx(DNS7b_blu_dat{:,1},DNS7b_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), v_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2214xy(110:510)-ru02214xy)/delta_ni(2), (out.v_std2214xy(110:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02214xy-out.r2214xy(450:890))/delta_ni(2),(out.v_std2214xy(450:890))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2224xy(92:520)-ru02224xy)/delta_ni(2), (out.v_std2224xy(92:520))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02224xy-out.r2224xy(480:890))/delta_ni(2),(out.v_std2224xy(480:890))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2234xy(105:520)-ru02234xy)/delta_ni(2), (out.v_std2234xy(105:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02234xy-out.r2234xy(480:885))/delta_ni(2),(out.v_std2234xy(480:885))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT radial fluctuations vs y for grid 4,f1 at different ppp, upper and lower part of the pipe')


figure(20)
semilogx(DNS7b_blu_dat{:,1},DNS7b_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), v_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2218xy(200:510)-ru02218xy)/delta_ni(2), (out.v_std2218xy(200:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02218xy-out.r2218xy(470:785))/delta_ni(2),(out.v_std2218xy(470:785))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2228xy(200:510)-ru02228xy)/delta_ni(2), (out.v_std2228xy(200:510))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02228xy-out.r2228xy(470:785))/delta_ni(2),(out.v_std2228xy(470:785))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2238xy(200:520)-ru02238xy)/delta_ni(2), (out.v_std2238xy(200:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02238xy-out.r2238xy(470:775))/delta_ni(2),(out.v_std2238xy(470:775))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT radial fluctuations vs y for grid 8,f1 at different ppp, upper and lower part of the pipe')



figure(21)
semilogx(DNS7b_blu_dat{:,1},DNS7b_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), v_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2314xy(110:510)-ru02314xy)/delta_ni(2), (out.v_std2314xy(110:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02314xy-out.r2314xy(450:880))/delta_ni(2),(out.v_std2314xy(450:880))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2324xy(105:520)-ru02324xy)/delta_ni(2), (out.v_std2324xy(105:520))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02324xy-out.r2324xy(450:890))/delta_ni(2),(out.v_std2324xy(450:890))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2334xy(115:520)-ru02334xy)/delta_ni(2), (out.v_std2334xy(115:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02334xy-out.r2334xy(480:880))/delta_ni(2),(out.v_std2334xy(480:880))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT radial fluctuations vs y for grid 4,f2 at different ppp, upper and lower part of the pipe')


figure(22)
semilogx(DNS7b_blu_dat{:,1},DNS7b_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), v_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2318xy(200:510)-ru02318xy)/delta_ni(2), (out.v_std2318xy(200:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02318xy-out.r2318xy(470:775))/delta_ni(2),(out.v_std2318xy(470:775))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2328xy(200:510)-ru02328xy)/delta_ni(2), (out.v_std2328xy(200:510))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02328xy-out.r2328xy(470:790))/delta_ni(2),(out.v_std2328xy(470:790))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2338xy(205:510)-ru02338xy)/delta_ni(2), (out.v_std2338xy(205:510))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02338xy-out.r2338xy(470:790))/delta_ni(2),(out.v_std2338xy(470:790))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT radial fluctuations vs y for grid 8,f2 at different ppp, upper and lower part of the pipe')


%% confronto DNS fig 7b-Re2 - plot over line z
DNS7b_blu = '../grafici letteratura/DNS fig 7b/Re2.csv';
DNS7b_blu_dat = readtable(DNS7b_blu);

figure(23)
semilogx(DNS7b_blu_dat{:,1},DNS7b_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), v_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2214xz(130:510)-ru02214xz)/delta_ni(2), (out.w_std2214xz(130:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02214xz-out.r2214xz(450:890))/delta_ni(2),(out.w_std2214xz(450:890))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2224xz(130:520)-ru02224xz)/delta_ni(2), (out.w_std2224xz(130:520))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02224xz-out.r2224xz(480:890))/delta_ni(2),(out.w_std2224xz(480:890))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2234xz(125:520)-ru02234xz)/delta_ni(2), (out.w_std2234xz(125:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02234xz-out.r2234xz(480:855))/delta_ni(2),(out.w_std2234xz(480:855))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT radial fluctuations vs z for grid 4,f1 at different ppp, front and rear part of the pipe')


figure(24)
semilogx(DNS7b_blu_dat{:,1},DNS7b_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), v_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2218xz(200:510)-ru02218xz)/delta_ni(2), (out.w_std2218xz(200:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02218xz-out.r2218xz(470:785))/delta_ni(2),(out.w_std2218xz(470:785))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2228xz(200:510)-ru02228xz)/delta_ni(2), (out.w_std2228xz(200:510))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02228xz-out.r2228xz(470:785))/delta_ni(2),(out.w_std2228xz(470:785))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2238xz(200:520)-ru02238xz)/delta_ni(2), (out.w_std2238xz(200:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02238xz-out.r2238xz(470:775))/delta_ni(2),(out.w_std2238xz(470:775))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT radial fluctuations vs z for grid 8,f1 at different ppp, front and rear part of the pipe')



figure(25)
semilogx(DNS7b_blu_dat{:,1},DNS7b_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), v_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2314xz(110:510)-ru02314xz)/delta_ni(2), (out.w_std2314xz(110:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02314xz-out.r2314xz(450:880))/delta_ni(2),(out.w_std2314xz(450:880))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2324xz(165:520)-ru02324xz)/delta_ni(2), (out.w_std2324xz(165:520))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02324xz-out.r2324xz(450:890))/delta_ni(2),(out.w_std2324xz(450:890))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2334xz(145:520)-ru02334xz)/delta_ni(2), (out.w_std2334xz(145:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02334xz-out.r2334xz(480:870))/delta_ni(2),(out.w_std2334xz(480:870))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT radial fluctuations vs z for grid 4,f2 at different ppp, front and rear part of the pipe')


figure(26)
semilogx(DNS7b_blu_dat{:,1},DNS7b_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), v_std_LDV(1:13)/u_tau(2),'og','linewidth',2)
hold on
semilogx((out.r2318xz(200:510)-ru02318xz)/delta_ni(2), (out.w_std2318xz(200:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02318xz-out.r2318xz(470:775))/delta_ni(2),(out.w_std2318xz(470:775))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2328xz(200:510)-ru02328xz)/delta_ni(2), (out.w_std2328xz(200:510))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02328xz-out.r2328xz(470:790))/delta_ni(2),(out.w_std2328xz(470:790))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2338xz(205:510)-ru02338xz)/delta_ni(2), (out.w_std2338xz(205:510))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02338xz-out.r2338xz(470:790))/delta_ni(2),(out.w_std2338xz(470:790))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT radial fluctuations vs z for grid 8,f2 at different ppp, front and rear part of the pipe')



%%
close all

%% confronto DNS fig 7c - Re1 - plot over line y
DNS7c_verde = '../grafici letteratura/DNS fig 7c/Re1.csv';
DNS7c_verde_dat = readtable(DNS7c_verde);

figure(27)
semilogx(DNS7c_verde_dat{:,1},DNS7c_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx((out.r1114xy(120:476)-ru01114xy)/delta_ni(1), (out.w_std1114xy(120:476))/u_tau(1),'k','LineWidth',2 )
hold on
semilogx((rb01114xy-out.r1114xy(440:870))/delta_ni(1),(out.w_std1114xy(440:870))/u_tau(1),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1124xy(105:476)-ru01124xy)/delta_ni(1), (out.w_std1124xy(105:476))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01124xy-out.r1124xy(440:870))/delta_ni(1),(out.w_std1124xy(440:870))/u_tau(1),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1134xy(115:476)-ru01134xy)/delta_ni(1), (out.w_std1134xy(115:476))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01134xy-out.r1134xy(440:870))/delta_ni(1),(out.w_std1134xy(440:870))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{\theta,rms}$','Interpreter','latex')
legend('El Khoury Re 5300','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT azimuthal fluctuations vs y for grid 4 at different ppp, upper and lower part of the pipe')
 

figure(28)
semilogx(DNS7c_verde_dat{:,1},DNS7c_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx((out.r1118xy(210:540)-ru01118xy)/delta_ni(1), (out.w_std1118xy(210:540))/u_tau(1),'k','LineWidth',2 )
hold on
semilogx((rb01118xy-out.r1118xy(440:780))/delta_ni(1),(out.w_std1118xy(440:780))/u_tau(1),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1128xy(195:540)-ru01128xy)/delta_ni(1), (out.w_std1128xy(195:540))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01128xy-out.r1128xy(440:780))/delta_ni(1),(out.w_std1128xy(440:780))/u_tau(1),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1138xy(215:540)-ru01138xy)/delta_ni(1), (out.w_std1138xy(215:540))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01138xy-out.r1138xy(440:780))/delta_ni(1),(out.w_std1138xy(440:780))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{\theta,rms}$','Interpreter','latex')
legend('El Khoury Re 5300','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT azimuthal fluctuations vs y for grid 8 at different ppp, upper and lower part of the pipe')



%% confronto DNS fig 7c - Re1 - plot over line z
DNS7c_verde = '../grafici letteratura/DNS fig 7c/Re1.csv';
DNS7c_verde_dat = readtable(DNS7c_verde);

figure(29)
semilogx(DNS7c_verde_dat{:,1},DNS7c_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx((out.r1114xz(120:476)-ru01114xz)/delta_ni(1), (out.v_std1114xz(120:476))/u_tau(1),'k','LineWidth',2 )
hold on
semilogx((rb01114xz-out.r1114xz(440:870))/delta_ni(1),(out.v_std1114xz(440:870))/u_tau(1),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1124xz(105:476)-ru01124xz)/delta_ni(1), (out.v_std1124xz(105:476))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01124xz-out.r1124xz(440:870))/delta_ni(1),(out.v_std1124xz(440:870))/u_tau(1),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1134xz(115:476)-ru01134xz)/delta_ni(1), (out.v_std1134xz(115:476))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01134xz-out.r1134xz(440:870))/delta_ni(1),(out.v_std1134xz(440:870))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{\theta,rms}$','Interpreter','latex')
legend('El Khoury Re 5300','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT azimuthal fluctuations vs z for grid 4 at different ppp, front and rear part of the pipe')
 

figure(30)
semilogx(DNS7c_verde_dat{:,1},DNS7c_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx((out.r1118xz(210:540)-ru01118xz)/delta_ni(1), (out.v_std1118xz(210:540))/u_tau(1),'k','LineWidth',2 )
hold on
semilogx((rb01118xz-out.r1118xz(440:780))/delta_ni(1),(out.v_std1118xz(440:780))/u_tau(1),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1128xz(195:540)-ru01128xz)/delta_ni(1), (out.v_std1128xz(195:540))/u_tau(1),'r','LineWidth',2 )
hold on
semilogx((rb01128xz-out.r1128xz(440:780))/delta_ni(1),(out.v_std1128xz(440:780))/u_tau(1),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1138xz(215:540)-ru01138xz)/delta_ni(1), (out.v_std1138xz(215:540))/u_tau(1),'b','LineWidth',2 )
hold on
semilogx((rb01138xz-out.r1138xz(440:780))/delta_ni(1),(out.v_std1138xz(440:780))/u_tau(1),'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{\theta,rms}$','Interpreter','latex')
legend('El Khoury Re 5300','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT azimuthal fluctuations vs z for grid 8 at different ppp, front and rear part of the pipe')


%%
close all

%% confronto DNS fig 7c-Re2 -  plot over line y
DNS7c_blu = '../grafici letteratura/DNS fig 7c/Re2.csv';
DNS7c_blu_dat = readtable(DNS7c_blu);

figure(31)
semilogx(DNS7c_blu_dat{:,1},DNS7c_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx((out.r2214xy(110:510)-ru02214xy)/delta_ni(2), (out.w_std2214xy(110:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02214xy-out.r2214xy(450:890))/delta_ni(2),(out.w_std2214xy(450:890))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2224xy(92:520)-ru02224xy)/delta_ni(2), (out.w_std2224xy(92:520))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02224xy-out.r2224xy(480:890))/delta_ni(2),(out.w_std2224xy(480:890))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2234xy(105:520)-ru02234xy)/delta_ni(2), (out.w_std2234xy(105:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02234xy-out.r2234xy(480:885))/delta_ni(2),(out.w_std2234xy(480:885))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT azimuthal fluctuations vs y for grid 4,f1 at different ppp, upper and lower part of the pipe')


figure(32)
semilogx(DNS7c_blu_dat{:,1},DNS7c_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx((out.r2218xy(200:510)-ru02218xy)/delta_ni(2), (out.w_std2218xy(200:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02218xy-out.r2218xy(470:785))/delta_ni(2),(out.w_std2218xy(470:785))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2228xy(200:510)-ru02228xy)/delta_ni(2), (out.w_std2228xy(200:510))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02228xy-out.r2228xy(470:785))/delta_ni(2),(out.w_std2228xy(470:785))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2238xy(200:520)-ru02238xy)/delta_ni(2), (out.w_std2238xy(200:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02238xy-out.r2238xy(470:775))/delta_ni(2),(out.w_std2238xy(470:775))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT azimuthal fluctuations vs y for grid 8,f1 at different ppp, upper and lower part of the pipe')



figure(33)
semilogx(DNS7c_blu_dat{:,1},DNS7c_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx((out.r2314xy(110:510)-ru02314xy)/delta_ni(2), (out.w_std2314xy(110:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02314xy-out.r2314xy(450:880))/delta_ni(2),(out.w_std2314xy(450:880))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2324xy(105:520)-ru02324xy)/delta_ni(2), (out.w_std2324xy(105:520))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02324xy-out.r2324xy(450:890))/delta_ni(2),(out.w_std2324xy(450:890))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2334xy(115:520)-ru02334xy)/delta_ni(2), (out.w_std2334xy(115:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02334xy-out.r2334xy(480:880))/delta_ni(2),(out.w_std2334xy(480:880))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT azimuthal fluctuations vs y for grid 4,f2 at different ppp, upper and lower part of the pipe')


figure(34)
semilogx(DNS7c_blu_dat{:,1},DNS7c_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx((out.r2318xy(200:510)-ru02318xy)/delta_ni(2), (out.w_std2318xy(200:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02318xy-out.r2318xy(470:775))/delta_ni(2),(out.w_std2318xy(470:775))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2328xy(200:510)-ru02328xy)/delta_ni(2), (out.w_std2328xy(200:510))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02328xy-out.r2328xy(470:790))/delta_ni(2),(out.w_std2328xy(470:790))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2338xy(205:510)-ru02338xy)/delta_ni(2), (out.w_std2338xy(205:510))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02338xy-out.r2338xy(470:790))/delta_ni(2),(out.w_std2338xy(470:790))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT azimuthal fluctuations vs y for grid 8,f2 at different ppp, upper and lower part of the pipe')


%% confronto DNS fig 7c-Re2 - plot over line z
DNS7c_blu = '../grafici letteratura/DNS fig 7c/Re2.csv';
DNS7c_blu_dat = readtable(DNS7c_blu);

figure(35)
semilogx(DNS7c_blu_dat{:,1},DNS7c_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx((out.r2214xz(110:510)-ru02214xz)/delta_ni(2), (out.v_std2214xz(110:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02214xz-out.r2214xz(450:890))/delta_ni(2),(out.v_std2214xz(450:890))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2224xz(120:520)-ru02224xz)/delta_ni(2), (out.v_std2224xz(120:520))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02224xz-out.r2224xz(480:890))/delta_ni(2),(out.v_std2224xz(480:890))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2234xz(105:520)-ru02234xz)/delta_ni(2), (out.v_std2234xz(105:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02234xz-out.r2234xz(480:855))/delta_ni(2),(out.v_std2234xz(480:855))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT azimuthal fluctuations vs z for grid 4,f1 at different ppp, front and rear part of the pipe')


figure(36)
semilogx(DNS7c_blu_dat{:,1},DNS7c_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx((out.r2218xz(200:510)-ru02218xz)/delta_ni(2), (out.v_std2218xz(200:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02218xz-out.r2218xz(470:785))/delta_ni(2),(out.v_std2218xz(470:785))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2228xz(200:510)-ru02228xz)/delta_ni(2), (out.v_std2228xz(200:510))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02228xz-out.r2228xz(470:785))/delta_ni(2),(out.v_std2228xz(470:785))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2238xz(200:520)-ru02238xz)/delta_ni(2), (out.v_std2238xz(200:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02238xz-out.r2238xz(470:775))/delta_ni(2),(out.v_std2238xz(470:775))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT azimuthal fluctuations vs z for grid 8,f1 at different ppp, front and rear part of the pipe')



figure(37)
semilogx(DNS7c_blu_dat{:,1},DNS7c_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx((out.r2314xz(110:510)-ru02314xz)/delta_ni(2), (out.v_std2314xz(110:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02314xz-out.r2314xz(450:880))/delta_ni(2),(out.v_std2314xz(450:880))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2324xz(135:520)-ru02324xz)/delta_ni(2), (out.v_std2324xz(135:520))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02324xz-out.r2324xz(450:890))/delta_ni(2),(out.v_std2324xz(450:890))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2334xz(125:520)-ru02334xz)/delta_ni(2), (out.v_std2334xz(125:520))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02334xz-out.r2334xz(480:880))/delta_ni(2),(out.v_std2334xz(480:880))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT azimuthal fluctuations vs z for grid 4,f2 at different ppp, front and rear part of the pipe')


figure(38)
semilogx(DNS7c_blu_dat{:,1},DNS7c_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx((out.r2318xz(200:510)-ru02318xz)/delta_ni(2), (out.v_std2318xz(200:510))/u_tau(2),'k','LineWidth',2 )
hold on
semilogx((rb02318xz-out.r2318xz(470:775))/delta_ni(2),(out.v_std2318xz(470:775))/u_tau(2),'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2328xz(200:510)-ru02328xz)/delta_ni(2), (out.v_std2328xz(200:510))/u_tau(2),'r','LineWidth',2 )
hold on
semilogx((rb02328xz-out.r2328xz(470:790))/delta_ni(2),(out.v_std2328xz(470:790))/u_tau(2),'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2338xz(205:510)-ru02338xz)/delta_ni(2), (out.v_std2338xz(205:510))/u_tau(2),'g','LineWidth',2 )
hold on
semilogx((rb02338xz-out.r2338xz(470:790))/delta_ni(2),(out.v_std2338xz(470:790))/u_tau(2),'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$u^+_{r,rms}$','Interpreter','latex')
legend('El Khoury Re 11700','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT azimuthal fluctuations vs z for grid 8,f2 at different ppp, front and rear part of the pipe')



%%
close all


%% confronto DNS fig 7d - Re1 - plot over line y
DNS7d_verde = '../grafici letteratura/DNS fig 7d/Re1.csv';
DNS7d_verde_dat = readtable(DNS7d_verde);

figure(39)
semilogx(DNS7d_verde_dat{:,1},DNS7d_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx((out.r1114xy(120:476)-ru01114xy)/delta_ni(1), -(out.Rxy1114xy(120:476))/u_tau(1)^2,'k','LineWidth',2 )
hold on
semilogx((rb01114xy-out.r1114xy(440:870))/delta_ni(1),(out.Rxy1114xy(440:870))/u_tau(1)^2,'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1124xy(105:476)-ru01124xy)/delta_ni(1), -(out.Rxy1124xy(105:476))/u_tau(1)^2,'r','LineWidth',2 )
hold on
semilogx((rb01124xy-out.r1124xy(440:870))/delta_ni(1),(out.Rxy1124xy(440:870))/u_tau(1)^2,'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1134xy(115:476)-ru01134xy)/delta_ni(1), -(out.Rxy1134xy(115:476))/u_tau(1)^2,'b','LineWidth',2 )
hold on
semilogx((rb01134xy-out.r1134xy(440:870))/delta_ni(1),(out.Rxy1134xy(440:870))/u_tau(1)^2,'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$<u_zu_r>^+$','Interpreter','latex')
legend('El Khoury Re 5300','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT Reynolds stresses vs y for grid 4 at different ppp, upper and lower part of the pipe')
 

figure(40)
semilogx(DNS7d_verde_dat{:,1},DNS7d_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx((out.r1118xy(210:540)-ru01118xy)/delta_ni(1), -(out.Rxy1118xy(210:540))/u_tau(1)^2,'k','LineWidth',2 )
hold on
semilogx((rb01118xy-out.r1118xy(440:780))/delta_ni(1),(out.Rxy1118xy(440:780))/u_tau(1)^2,'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1128xy(195:540)-ru01128xy)/delta_ni(1), -(out.Rxy1128xy(195:540))/u_tau(1)^2,'r','LineWidth',2 )
hold on
semilogx((rb01128xy-out.r1128xy(440:780))/delta_ni(1),(out.Rxy1128xy(440:780))/u_tau(1)^2,'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1138xy(215:540)-ru01138xy)/delta_ni(1), -(out.Rxy1138xy(215:540))/u_tau(1)^2,'b','LineWidth',2 )
hold on
semilogx((rb01138xy-out.r1138xy(440:780))/delta_ni(1),(out.Rxy1138xy(440:780))/u_tau(1)^2,'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$<u_zu_r>^+$','Interpreter','latex')
legend('El Khoury Re 5300','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT Reynolds stresses vs y for grid 8 at different ppp, upper and lower part of the pipe')


%% confronto DNS fig 7d - Re1 - plot over line z
DNS7d_verde = '../grafici letteratura/DNS fig 7d/Re1.csv';
DNS7d_verde_dat = readtable(DNS7d_verde);

figure(41)
semilogx(DNS7d_verde_dat{:,1},DNS7d_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx((out.r1114xz(120:476)-ru01114xz)/delta_ni(1), -(out.Rxz1114xz(120:476))/u_tau(1)^2,'k','LineWidth',2 )
hold on
semilogx((rb01114xz-out.r1114xz(440:870))/delta_ni(1),(out.Rxz1114xz(440:870))/u_tau(1)^2,'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1124xz(105:476)-ru01124xz)/delta_ni(1), -(out.Rxz1124xz(105:476))/u_tau(1)^2,'r','LineWidth',2 )
hold on
semilogx((rb01124xz-out.r1124xz(440:870))/delta_ni(1),(out.Rxz1124xz(440:870))/u_tau(1)^2,'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1134xz(115:476)-ru01134xz)/delta_ni(1), -(out.Rxz1134xz(115:476))/u_tau(1)^2,'b','LineWidth',2 )
hold on
semilogx((rb01134xz-out.r1134xz(440:870))/delta_ni(1),(out.Rxz1134xz(440:870))/u_tau(1)^2,'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$$<u_zu_r>^+$$','Interpreter','latex')
legend('El Khoury Re 5300','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT Reynolds stresses vs z for grid 4 at different ppp, front and rear part of the pipe')
 

figure(42)
semilogx(DNS7d_verde_dat{:,1},DNS7d_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx((out.r1118xz(210:540)-ru01118xz)/delta_ni(1), -(out.Rxz1118xz(210:540))/u_tau(1)^2,'k','LineWidth',2 )
hold on
semilogx((rb01118xz-out.r1118xz(440:780))/delta_ni(1),(out.Rxz1118xz(440:780))/u_tau(1)^2,'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r1128xz(195:540)-ru01128xz)/delta_ni(1), -(out.Rxz1128xz(195:540))/u_tau(1)^2,'r','LineWidth',2 )
hold on
semilogx((rb01128xz-out.r1128xz(440:780))/delta_ni(1),(out.Rxz1128xz(440:780))/u_tau(1)^2,'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r1138xz(215:540)-ru01138xz)/delta_ni(1), -(out.Rxz1138xz(215:540))/u_tau(1)^2,'b','LineWidth',2 )
hold on
semilogx((rb01138xz-out.r1138xz(440:780))/delta_ni(1),(out.Rxz1138xz(440:780))/u_tau(1)^2,'--b','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$<u_zu_r>^+$','Interpreter','latex')
legend('El Khoury Re 5300','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT Reynolds stresses vs z for grid 8 at different ppp, front and rear part of the pipe')

%%
close all


%% confronto DNS fig 7d-Re2 - plot over line y
DNS7d_blu = '../grafici letteratura/DNS fig 7d/Re2.csv';
DNS7d_blu_dat = readtable(DNS7d_blu);

figure(43)
semilogx(DNS7d_blu_dat{:,1},DNS7d_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), Rxy_LDV(1:13)/u_tau(2)^2,'og','linewidth',2)
hold on
semilogx((out.r2214xy(110:510)-ru02214xy)/delta_ni(2), -(out.Rxy2214xy(110:510))/u_tau(2)^2,'k','LineWidth',2 )
hold on
semilogx((rb02214xy-out.r2214xy(450:890))/delta_ni(2),(out.Rxy2214xy(450:890))/u_tau(2)^2,'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2224xy(92:520)-ru02224xy)/delta_ni(2), -(out.Rxy2224xy(92:520))/u_tau(2)^2,'r','LineWidth',2 )
hold on
semilogx((rb02224xy-out.r2224xy(480:890))/delta_ni(2),(out.Rxy2224xy(480:890))/u_tau(2)^2,'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2234xy(105:520)-ru02234xy)/delta_ni(2), -(out.Rxy2234xy(105:520))/u_tau(2)^2,'g','LineWidth',2 )
hold on
semilogx((rb02234xy-out.r2234xy(480:885))/delta_ni(2),(out.Rxy2234xy(480:885))/u_tau(2)^2,'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$<u_zu_r>^+$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT Reynolds stresses vs y for grid 4,f1 at different ppp, upper and lower part of the pipe')


figure(44)
semilogx(DNS7d_blu_dat{:,1},DNS7d_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), Rxy_LDV(1:13)/u_tau(2)^2,'og','linewidth',2)
hold on
semilogx((out.r2218xy(200:510)-ru02218xy)/delta_ni(2), -(out.Rxy2218xy(200:510))/u_tau(2)^2,'k','LineWidth',2 )
hold on
semilogx((rb02218xy-out.r2218xy(470:785))/delta_ni(2),(out.Rxy2218xy(470:785))/u_tau(2)^2,'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2228xy(200:510)-ru02228xy)/delta_ni(2), -(out.Rxy2228xy(200:510))/u_tau(2)^2,'r','LineWidth',2 )
hold on
semilogx((rb02228xy-out.r2228xy(470:785))/delta_ni(2),(out.Rxy2228xy(470:785))/u_tau(2)^2,'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2238xy(200:520)-ru02238xy)/delta_ni(2), -(out.Rxy2238xy(200:520))/u_tau(2)^2,'g','LineWidth',2 )
hold on
semilogx((rb02238xy-out.r2238xy(470:775))/delta_ni(2),(out.Rxy2238xy(470:775))/u_tau(2)^2,'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$<u_zu_r>^+$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT Reynolds stresses vs y for grid 8,f1 at different ppp, upper and lower part of the pipe')



figure(45)
semilogx(DNS7d_blu_dat{:,1},DNS7d_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), Rxy_LDV(1:13)/u_tau(2)^2,'og','linewidth',2)
hold on
semilogx((out.r2314xy(110:510)-ru02314xy)/delta_ni(2), -(out.Rxy2314xy(110:510))/u_tau(2)^2,'k','LineWidth',2 )
hold on
semilogx((rb02314xy-out.r2314xy(450:880))/delta_ni(2),(out.Rxy2314xy(450:880))/u_tau(2)^2,'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2324xy(105:520)-ru02324xy)/delta_ni(2), -(out.Rxy2324xy(105:520))/u_tau(2)^2,'r','LineWidth',2 )
hold on
semilogx((rb02324xy-out.r2324xy(450:890))/delta_ni(2),(out.Rxy2324xy(450:890))/u_tau(2)^2,'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2334xy(115:520)-ru02334xy)/delta_ni(2), -(out.Rxy2334xy(115:520))/u_tau(2)^2,'g','LineWidth',2 )
hold on
semilogx((rb02334xy-out.r2334xy(480:880))/delta_ni(2),(out.Rxy2334xy(480:880))/u_tau(2)^2,'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$<u_zu_r>^+$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT Reynolds stresses vs y for grid 4,f2 at different ppp, upper and lower part of the pipe')


figure(46)
semilogx(DNS7d_blu_dat{:,1},DNS7d_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), Rxy_LDV(1:13)/u_tau(2)^2,'og','linewidth',2)
hold on
semilogx((out.r2318xy(200:510)-ru02318xy)/delta_ni(2), -(out.Rxy2318xy(200:510))/u_tau(2)^2,'k','LineWidth',2 )
hold on
semilogx((rb02318xy-out.r2318xy(470:775))/delta_ni(2),(out.Rxy2318xy(470:775))/u_tau(2)^2,'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2328xy(200:510)-ru02328xy)/delta_ni(2), -(out.Rxy2328xy(200:510))/u_tau(2)^2,'r','LineWidth',2 )
hold on
semilogx((rb02328xy-out.r2328xy(470:790))/delta_ni(2),(out.Rxy2328xy(470:790))/u_tau(2)^2,'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2338xy(205:510)-ru02338xy)/delta_ni(2), -(out.Rxy2338xy(205:510))/u_tau(2)^2,'g','LineWidth',2 )
hold on
semilogx((rb02338xy-out.r2338xy(470:790))/delta_ni(2),(out.Rxy2338xy(470:790))/u_tau(2)^2,'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$<u_zu_r>^+$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,up','LPT,ppp1,low','LPT,ppp2,up','LPT,ppp2,low', ...
    'LPT,ppp3,up','LPT,ppp3,low')
title('LPT Reynolds stresses vs y for grid 8,f2 at different ppp, upper and lower part of the pipe')


%% confronto DNS fig 7d-Re2 - plot over line z
DNS7d_blu = '../grafici letteratura/DNS fig 7d/Re2.csv';
DNS7d_blu_dat = readtable(DNS7d_blu);

figure(47)
semilogx(DNS7d_blu_dat{:,1},DNS7d_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), Rxy_LDV(1:13)/u_tau(2)^2,'og','linewidth',2)
hold on
semilogx((out.r2214xz(110:510)-ru02214xz)/delta_ni(2), -(out.Rxz2214xz(110:510))/u_tau(2)^2,'k','LineWidth',2 )
hold on
semilogx((rb02214xz-out.r2214xz(450:890))/delta_ni(2),(out.Rxz2214xz(450:890))/u_tau(2)^2,'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2224xz(92:520)-ru02224xz)/delta_ni(2), -(out.Rxz2224xz(92:520))/u_tau(2)^2,'r','LineWidth',2 )
hold on
semilogx((rb02224xz-out.r2224xz(480:890))/delta_ni(2),(out.Rxz2224xz(480:890))/u_tau(2)^2,'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2234xz(105:520)-ru02234xz)/delta_ni(2), -(out.Rxz2234xz(105:520))/u_tau(2)^2,'g','LineWidth',2 )
hold on
semilogx((rb02234xz-out.r2234xz(480:885))/delta_ni(2),(out.Rxz2234xz(480:885))/u_tau(2)^2,'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$<u_zu_r>^+$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT Reynolds stresses vs z for grid 4,f1 at different ppp, front and rear part of the pipe')


figure(48)
semilogx(DNS7d_blu_dat{:,1},DNS7d_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), Rxy_LDV(1:13)/u_tau(2)^2,'og','linewidth',2)
hold on
semilogx((out.r2218xz(200:510)-ru02218xz)/delta_ni(2), -(out.Rxz2218xz(200:510))/u_tau(2)^2,'k','LineWidth',2 )
hold on
semilogx((rb02218xz-out.r2218xz(470:785))/delta_ni(2),(out.Rxz2218xz(470:785))/u_tau(2)^2,'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2228xz(200:510)-ru02228xz)/delta_ni(2), -(out.Rxz2228xz(200:510))/u_tau(2)^2,'r','LineWidth',2 )
hold on
semilogx((rb02228xz-out.r2228xz(470:785))/delta_ni(2),(out.Rxz2228xz(470:785))/u_tau(2)^2,'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2238xz(200:520)-ru02238xz)/delta_ni(2), -(out.Rxz2238xz(200:520))/u_tau(2)^2,'g','LineWidth',2 )
hold on
semilogx((rb02238xz-out.r2238xz(470:775))/delta_ni(2),(out.Rxz2238xz(470:775))/u_tau(2)^2,'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$<u_zu_r>^+$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT Reynolds stresses vs z for grid 8,f1 at different ppp, front and rear part of the pipe')



figure(49)
semilogx(DNS7d_blu_dat{:,1},DNS7d_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), Rxy_LDV(1:13)/u_tau(2)^2,'og','linewidth',2)
hold on
semilogx((out.r2314xz(110:510)-ru02314xz)/delta_ni(2), -(out.Rxz2314xz(110:510))/u_tau(2)^2,'k','LineWidth',2 )
hold on
semilogx((rb02314xz-out.r2314xz(450:880))/delta_ni(2),(out.Rxz2314xz(450:880))/u_tau(2)^2,'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2324xz(105:520)-ru02324xz)/delta_ni(2), -(out.Rxz2324xz(105:520))/u_tau(2)^2,'r','LineWidth',2 )
hold on
semilogx((rb02324xz-out.r2324xz(450:890))/delta_ni(2),(out.Rxz2324xz(450:890))/u_tau(2)^2,'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2334xz(115:520)-ru02334xz)/delta_ni(2), -(out.Rxz2334xz(115:520))/u_tau(2)^2,'g','LineWidth',2 )
hold on
semilogx((rb02334xz-out.r2334xz(480:880))/delta_ni(2),(out.Rxz2334xz(480:880))/u_tau(2)^2,'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$<u_zu_r>^+$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT Reynolds stresses vs z for grid 4,f2 at different ppp, front and rear part of the pipe')


figure(50)
semilogx(DNS7d_blu_dat{:,1},DNS7d_blu_dat{:,2},'-b','LineWidth',2)
hold on
semilogx(y_LDV(1:13)./delta_ni(2), Rxy_LDV(1:13)/u_tau(2)^2,'og','linewidth',2)
hold on
semilogx((out.r2318xz(200:510)-ru02318xz)/delta_ni(2), -(out.Rxz2318xz(200:510))/u_tau(2)^2,'k','LineWidth',2 )
hold on
semilogx((rb02318xz-out.r2318xz(470:775))/delta_ni(2),(out.Rxz2318xz(470:775))/u_tau(2)^2,'--k','LineWidth',1)      %plot della parte con y>R
hold on
semilogx((out.r2328xz(200:510)-ru02328xz)/delta_ni(2), -(out.Rxz2328xz(200:510))/u_tau(2)^2,'r','LineWidth',2 )
hold on
semilogx((rb02328xz-out.r2328xz(470:790))/delta_ni(2),(out.Rxz2328xz(470:790))/u_tau(2)^2,'--r','LineWidth',2 )      %plot della parte con y>R
hold on
semilogx((out.r2338xz(205:510)-ru02338xz)/delta_ni(2), -(out.Rxz2338xz(205:510))/u_tau(2)^2,'g','LineWidth',2 )
hold on
semilogx((rb02338xz-out.r2338xz(470:790))/delta_ni(2),(out.Rxz2338xz(470:790))/u_tau(2)^2,'--g','LineWidth',2 )      %plot della parte con y>R
hold on
xlabel('y^+')
ylabel('$<u_zu_r>^+$','Interpreter','latex')
legend('El Khoury Re 11700','LDV','LPT,ppp1,front','LPT,ppp1,rear','LPT,ppp2,front','LPT,ppp2,rear', ...
    'LPT,ppp3,front','LPT,ppp3,rear')
title('LPT Reynolds stresses vs z for grid 8,f2 at different ppp, front and rear part of the pipe')



%%
close all

%% TPF fig 2, solo Re1

TPF2 = '../grafici letteratura/TPF fig 2/data.csv';
TPF2_dat = readtable(TPF2);
TPF2_PIV = '../grafici letteratura/TPF fig 2/PIV data.csv';
TPF2_PIV_dat = readtable(TPF2_PIV);

figure(51)
plot(TPF2_dat{:,1}, TPF2_dat{:,2},'k-','LineWidth',2)
hold on
plot(TPF2_PIV_dat{:,1}, TPF2_PIV_dat{:,2},'ob')
hold on
plot(((20.7-(out.r1114xy(60:493)-out.r1114xy(60)))./41.4), out.U1114xy(60:493)./abs(max(out.U1114xy)),'r-', 'LineWidth',2)
hold on
% errorbar((20.7-(out.r1114xy(60:493)-out.r1114xy(60)))./41.4, out.U1114xy(60:493)./abs(max(out.U1114xy)), out.u_unc1114xy(60:493)./abs(max(out.U1114xy)),'r')
legend('DNS ','PIV','LPT')
xlabel('r/D')
ylabel('U_z/U_c')
title('Confronto profili di velocità media, caso Re1, 160 Hz, ppp1, grid4')
% scostamento nell'inner layer, y/r<0.1 (Pope tabella 7.1), buon accordo
% con PIV considerando il diametro modificato

figure(52)
plot(TPF2_dat{:,1}, TPF2_dat{:,2},'-','color',[0.75 0.75 0.75],'LineWidth',2)
hold on
plot(TPF2_PIV_dat{:,1}, TPF2_PIV_dat{:,2},'ob','linewidth',2)
plot(((20.7-(out.r1114xy(930)-out.r1114xy(493:930)))./41.4), out.U1114xy(493:930)./abs(max(out.U1114xy)),'color',[0.1 0.9 0.1], 'LineWidth',2)
hold on
% errorbar(((20.7-(out.r1114xy(930)-out.r1114xy(493:930)))./41.4), out.U1114xy(493:930)./abs(max(out.U1114xy)), out.u_unc1114xy(493:930)./abs(max(out.U1114xy)),'r')
legend('DNS','PIV','LPT')
xlabel('r/D','fontsize',15)
ylabel('U_z/U_c','fontsize',20)
% title('Confronto profili di velocità media, case Re1, 160 Hz, ppp1, grid4, lower part')

figure(53)
plot(TPF2_dat{:,1}, TPF2_dat{:,2},'k-','LineWidth',2)
hold on
plot(TPF2_PIV_dat{:,1}, TPF2_PIV_dat{:,2},'ob')
plot(((17.5-(out.r1118xy(150:493)-out.r1118xy(150)))./35), out.U1118xy(150:493)./abs(max(out.U1118xy)),'r-', 'LineWidth',2)
% errorbar((17.5-(out.r1118xy(150:493)-out.r1118xy(150)))./35, out.U1118xy(150:493)./abs(max(out.U1118xy)), out.u_unc1118xy(150:493)./abs(max(out.U1118xy)),'r')
legend('DNS','PIV','LPT')
xlabel('r/D')
ylabel('U_z/U_c')
title('Confronto profili di velocità media, Re1, 160 Hz, ppp1, grid8')
%non viene bene


figure(54)
plot(TPF2_dat{:,1}, TPF2_dat{:,2},'k-','LineWidth',2)
hold on
plot(TPF2_PIV_dat{:,1}, TPF2_PIV_dat{:,2},'ob')
plot(((21.435-(out.r1124xy(46:493)-out.r1124xy(46)))./42.87), out.U1124xy(46:493)./abs(max(out.U1124xy)),'r-', 'LineWidth',2)
hold on
% errorbar((21.435-(out.r1124xy(46:493)-out.r1124xy(46)))./42.87, out.U1124xy(46:493)./abs(max(out.U1124xy)), out.u_unc1124xy(46:493)./abs(max(out.U1124xy)),'r')
legend('DNS ','PIV','LPT')
xlabel('r/D')
ylabel('U_z/U_c')
title('Confronto profili di velocità media, caso Re1, 160 Hz, ppp2, grid4')


figure(55)
plot(TPF2_dat{:,1}, TPF2_dat{:,2},'k-','LineWidth',2)
hold on
plot(TPF2_PIV_dat{:,1}, TPF2_PIV_dat{:,2},'ob')
plot(((21.435-(out.r1124xy(942)-out.r1124xy(493:942)))./42.87), out.U1124xy(493:942)./abs(max(out.U1124xy)),'r', 'LineWidth',2)
hold on
% errorbar(((21.435-(out.r1124xy(942)-out.r1124xy(493:942)))./42.87), out.U1124xy(493:942)./abs(max(out.U1124xy)), out.u_unc1124xy(493:942)./abs(max(out.U1124xy)),'r')
legend('DNS','PIV','LPT')
xlabel('r/D')
ylabel('U_z/U_c')
title('Confronto profili di velocità media, case Re1, 160 Hz, ppp2, grid4, lower part')


figure(56)
plot(TPF2_dat{:,1}, TPF2_dat{:,2},'k-','LineWidth',2)
hold on
plot(TPF2_PIV_dat{:,1}, TPF2_PIV_dat{:,2},'ob')
plot(((21.0537-(out.r1134xy(50:493)-out.r1134xy(50)))./42.1074), out.U1134xy(50:493)./abs(max(out.U1134xy)),'r-', 'LineWidth',2)
hold on
% errorbar((21.0537-(out.r1134xy(50:493)-out.r1134xy(50)))./42.1074, out.U1134xy(50:493)./abs(max(out.U1134xy)), out.u_unc1134xy(50:493)./abs(max(out.U1134xy)),'r')
legend('DNS ','PIV','LPT')
xlabel('r/D')
ylabel('U_z/U_c')
title('Confronto profili di velocità media, caso Re1, 160 Hz, ppp3, grid4')


figure(57)
plot(TPF2_dat{:,1}, TPF2_dat{:,2},'k-','LineWidth',2)
hold on
plot(TPF2_PIV_dat{:,1}, TPF2_PIV_dat{:,2},'ob')
plot(((21.0537-(out.r1134xy(930)-out.r1134xy(493:930)))./42.1074), out.U1134xy(493:930)./abs(max(out.U1134xy)),'r', 'LineWidth',2)
hold on
% errorbar(((21.0537-(out.r1134xy(930)-out.r1134xy(493:930)))./42.1074), out.U1134xy(493:930)./abs(max(out.U1134xy)), out.u_unc1134xy(493:930)./abs(max(out.U1124xy)),'r')
legend('DNS','PIV','LPT')
xlabel('r/D')
ylabel('U_z/U_c')
title('Confronto profili di velocità media, case Re1, 160 Hz, ppp3, grid4, lower part')


figure(58)
plot(TPF2_dat{:,1}, TPF2_dat{:,2},'k-','LineWidth',2)
hold on
plot(TPF2_PIV_dat{:,1}, TPF2_PIV_dat{:,2},'ob')
hold on
plot(((20.7-(out.r1114xy(60:480)-out.r1114xy(60)))./41.4), out.U1114xy(60:480)./abs(max(out.U1114xy)),'r-', 'LineWidth',2)
hold on
plot(((20.7-(out.r1114xy(930)-out.r1114xy(480:930)))./41.4), out.U1114xy(480:930)./abs(max(out.U1114xy)),'b-', 'LineWidth',2)
hold on
plot(((21.435-(out.r1124xy(46:491)-out.r1124xy(46)))./42.87), out.U1124xy(46:491)./abs(max(out.U1124xy)),'g-', 'LineWidth',2)
hold on
plot(((21.435-(out.r1124xy(942)-out.r1124xy(491:942)))./42.87), out.U1124xy(491:942)./abs(max(out.U1124xy)),'y', 'LineWidth',2)
hold on
plot(((21.0537-(out.r1134xy(50:492)-out.r1134xy(50)))./42.1074), out.U1134xy(50:492)./abs(max(out.U1134xy)),'m-', 'LineWidth',2)
hold on
plot(((21.0537-(out.r1134xy(930)-out.r1134xy(492:930)))./42.1074), out.U1134xy(492:930)./abs(max(out.U1134xy)),'c', 'LineWidth',2)
hold on
legend('DNS','PIV','ppp1 up','ppp1 bottom','ppp2 up','ppp2 bottom','ppp3 up','ppp3 bottom')
xlabel('r/D')
ylabel('U_z/U_c')
title('Confronto profili di velocità media, diversi ppp, grid 4')


%%
close all

%% confronto LPT e LDV, solo Re2
figure(59)
plot(((20.7376-(out.r2214xy(60:471)-out.r2214xy(60)))./41.4751), out.U2214xy(60:471)./max(out.U2214xy),'r-', 'LineWidth',2)
hold on
plot(((20.6176-(out.r2224xy(60:512)-out.r2224xy(60)))./41.2351), out.U2224xy(60:512)./max(out.U2224xy),'b-', 'LineWidth',2)
hold on
plot(((20.5754-(out.r2234xy(60:491)-out.r2234xy(60)))./41.1509), out.U2234xy(60:491)./max(out.U2234xy),'y-', 'LineWidth',2)
hold on
plot((R-y_LDV)/D, U_LDV_mean/max(out.U2224xy), 'co','linewidth',2)
hold on
legend('LPT ppp1','LPT ppp2','LPT ppp3','LDV')
xlabel('r/D')
ylabel('U_z/U_c')
title('Comparison LPT,f1,up vs LDV ')

figure(60)
plot(((20.7376-(out.r2314xy(72:512)-out.r2314xy(72)))./41.4751), out.U2314xy(72:512)./max(out.U2314xy),'r', 'LineWidth',2)
hold on
plot(((20.6176-(out.r2324xy(68:482)-out.r2324xy(68)))./41.2351), out.U2324xy(68:482)./max(out.U2324xy),'b', 'LineWidth',2)
hold on
plot(((20.5754-(out.r2334xy(80:500)-out.r2334xy(80)))./41.1509), out.U2334xy(80:500)./max(out.U2334xy),'y', 'LineWidth',2)
hold on
plot((R-y_LDV)/D, U_LDV_mean/max(out.U2324xy), 'go','linewidth',2)
hold on
legend('LPT ppp1','LPT ppp2','LPT ppp3','LDV')
xlabel('r/D')
ylabel('U_z/U_c')
title('Comparison LPT,f2,up vs LDV')


figure(61)
plot((R-y_LDV)/D, U_LDV_mean/max(out.U2324xy), 'go','linewidth',2)
hold on
plot(((20.7376-(out.r2214xy(925)-out.r2214xy(471:925)))./41.4751), out.U2214xy(471:925)./abs(max(out.U2214xy)),'r', 'LineWidth',2)
hold on
plot(((20.6176-(out.r2224xy(920)-out.r2224xy(512:920)))./41.2351), out.U2224xy(512:920)./abs(max(out.U2224xy)),'b', 'LineWidth',2)
hold on
plot(((20.5754-(out.r2234xy(920)-out.r2234xy(491:920)))./41.1509), out.U2234xy(491:920)./abs(max(out.U2234xy)),'y', 'LineWidth',2)
hold on
legend('LDV','ppp1','ppp2','ppp3')
xlabel('r/D')
ylabel('U_z/U_c')
title('comparison LPT,f1,low vs LDV')


figure(62)
plot((R-y_LDV)/D, U_LDV_mean/max(out.U2324xy), 'go','linewidth',2)
hold on
plot(((20.7376-(out.r2214xy(end)-out.r2214xy(471:end)))./41.4751), out.U2214xy(471:end)./abs(max(out.U2214xy)),'r', 'LineWidth',2)
hold on
plot(((20.6176-(out.r2224xy(end)-out.r2224xy(512:end)))./41.2351), out.U2224xy(512:end)./abs(max(out.U2224xy)),'b', 'LineWidth',2)
hold on
plot(((20.5754-(out.r2234xy(end)-out.r2234xy(491:end)))./41.1509), out.U2234xy(491:end)./abs(max(out.U2234xy)),'y', 'LineWidth',2)
hold on
legend('LDV','ppp1','ppp2','ppp3')
xlabel('r/D')
ylabel('U_z/U_c')
% title('comparison LPT,f1,low vs LDV')


%% confronto DNS fig 6
DNS6_blu = '../grafici letteratura/DNS fig 6a/blu.csv';
DNS6_blu_dat = readtable(DNS6_blu);
DNS6_verde = '../grafici letteratura/DNS fig 6a/verde.csv';
DNS6_verde_dat = readtable(DNS6_verde);
DNS6_nero = '../grafici letteratura/DNS fig 6a/nero.csv';
DNS6_nero_dat = readtable(DNS6_nero);
DNS6_rosso = '../grafici letteratura/DNS fig 6a/rosso.csv';
DNS6_rosso_dat = readtable(DNS6_rosso);
DNS_Re2_file = '../dati/360_Re_1.dat';
DNS_Re2_dati = readmatrix(DNS_Re2_file);

figure(100)
semilogx(DNS6_verde_dat{:,1},DNS6_verde_dat{:,2},'-g','LineWidth',2)
hold on
semilogx(DNS6_blu_dat{:,1},DNS6_blu_dat{:,2},'b-','LineWidth',2)
hold on
semilogx(DNS6_rosso_dat{:,1},DNS6_rosso_dat{:,2},'-r','LineWidth',2)
hold on
semilogx(DNS6_nero_dat{:,1},DNS6_nero_dat{:,2},'-k','LineWidth',2)
hold on
%Re1
semilogx((out.r1114xy(120:600)-ru01114xy)/delta_ni(1),out.U1114xy(120:600)./u_tau(1),'-c','LineWidth',2)
hold on
semilogx((out.r1124xy(105:600)-ru01124xy)/delta_ni(1),out.U1124xy(105:600)./u_tau(1),'-y','LineWidth',2)
hold on
semilogx((out.r1134xy(115:600)-ru01134xy)/delta_ni(1),out.U1134xy(115:600)./u_tau(1),'-m','LineWidth',2) %476
hold on
%Re2
semilogx((out.r2214xy(120:600)-ru02214xy)/delta_ni(2),out.U2214xy(120:600)./u_tau(2),'--c','LineWidth',2)
hold on
semilogx((out.r2224xy(105:600)-ru02224xy)/delta_ni(2),out.U2224xy(105:600)./u_tau(2),'--y','LineWidth',2)
hold on
semilogx((out.r2234xy(115:600)-ru02234xy)/delta_ni(2),out.U2234xy(115:600)./u_tau(2),'--m','LineWidth',2) %476
hold on
semilogx(DNS_Re2_dati(:,2),DNS_Re2_dati(:,3),'color',[0.75 0.75 0.75],'linewidth',2)
hold on
xlabel('y^+')
ylabel('U_z^+')
legend('DNS Re 1','DNS Re 2','DNS Re 3','DNS Re 4', ...
    'LPT Re 1, ppp1','LPT Re 1, ppp2','LPT Re 1, ppp3','LPT Re 2, ppp1','LPT Re 2, ppp2','LPT Re 2, ppp3')


%%
close all

%% confronto profili du/dy
figure(63)
grid on
hold on
plot(out.r1114xy,out.du_dy1114xy,'r-','LineWidth',2)
hold on
plot(out.r1118xy,out.du_dy1118xy,'b-','LineWidth',2)
hold on
xlabel('y')
ylabel('$\frac{\partial u}{\partial y}$','Interpreter','latex')
legend('grid 4', 'grid 8')
title('$\frac{\partial u}{\partial y}$ vs y, Q025, ppp1, 160Hz','Interpreter','latex')

figure(64)
plot(out.r1134xy,out.du_dy1134xy,'r-','LineWidth',2)
hold on
plot(out.r1138xy,out.du_dy1138xy,'b-','LineWidth',2)
hold on
xlabel('y')
ylabel('$\frac{\partial u}{\partial y}$','Interpreter','latex')
legend('grid 4', 'grid 8')
title('$\frac{\partial u}{\partial y}$ vs y, Q025, ppp3, 160Hz','Interpreter','latex')

figure(65)
plot(out.r2234xy,out.du_dy2234xy,'r-','LineWidth',2)
hold on
plot(out.r2238xy,out.du_dy2238xy,'b-','LineWidth',2)
hold on
xlabel('y')
ylabel('$\frac{\partial u}{\partial y}$','Interpreter','latex')
legend('grid 4', 'grid 8')
title('$\frac{\partial u}{\partial y}$ vs y, Q048, ppp3, 300Hz','Interpreter','latex')

% diversi andamenti, sembra più accurata la griglia 8, che si comporta bene
% vicino a parete



%% confronto profili du/dy variando frequenza di acquisizione
figure(66)
grid on
hold on
plot(out.r2214xy,out.du_dy2214xy,'r-','LineWidth',0.5)
hold on
plot(out.r2314xy,out.du_dy2314xy,'b-','LineWidth',0.5)
hold on
xlabel('y')
ylabel('$\frac{\partial u}{\partial y}$','Interpreter','latex')
legend('300 Hz', '480Hz')
title('$\frac{\partial u}{\partial y}$ vs y, Q048, ppp1, grid 4','Interpreter','latex')

figure(67)
grid on
hold on
plot(out.r2224xy,out.du_dy2224xy,'r-','LineWidth',0.5)
hold on
plot(out.r2324xy,out.du_dy2324xy,'b-','LineWidth',0.5)
hold on
xlabel('y')
ylabel('$\frac{\partial u}{\partial y}$','Interpreter','latex')
legend('300 Hz', '480Hz')
title('$\frac{\partial u}{\partial y}$ vs y, Q048, ppp2, grid 4','Interpreter','latex')

figure(68)
grid on 
hold on
plot(out.r2234xy,out.du_dy2234xy,'r-','LineWidth',0.5)
hold on
plot(out.r2334xy,out.du_dy2334xy,'b-','LineWidth',0.5)
hold on
xlabel('y')
ylabel('$\frac{\partial u}{\partial y}$','Interpreter','latex')
legend('300 Hz', '480Hz')
title('$\frac{\partial u}{\partial y}$ vs y, Q048, ppp3, grid 4','Interpreter','latex')


%grid 8
figure(69)
grid on
hold on
plot(out.r2218xy,out.du_dy2218xy,'r-','LineWidth',0.5)
hold on
plot(out.r2318xy,out.du_dy2318xy,'b-','LineWidth',0.5)
hold on
xlabel('y')
ylabel('$\frac{\partial u}{\partial y}$','Interpreter','latex')
legend('300 Hz', '480Hz')
title('$\frac{\partial u}{\partial y}$ vs y, Q048, ppp1, grid 8','Interpreter','latex')

figure(70)
grid on
hold on
plot(out.r2228xy,out.du_dy2228xy,'r-','LineWidth',0.5)
hold on
plot(out.r2328xy,out.du_dy2328xy,'b-','LineWidth',0.5)
hold on
xlabel('y')
ylabel('$\frac{\partial u}{\partial y}$','Interpreter','latex')
legend('300 Hz', '480Hz')
title('$\frac{\partial u}{\partial y}$ vs y, Q048, ppp2, grid 8','Interpreter','latex')

figure(71)
grid on 
hold on
plot(out.r2238xy,out.du_dy2238xy,'r-','LineWidth',0.5)
hold on
plot(out.r2338xy,out.du_dy2338xy,'b-','LineWidth',0.5)
hold on
xlabel('y')
ylabel('$\frac{\partial u}{\partial y}$','Interpreter','latex')
legend('300 Hz', '480Hz')
title('$\frac{\partial u}{\partial y}$ vs y, Q048, ppp3, grid 8','Interpreter','latex')


%%
close all

%% total shear stress
shear_stress1114xy = rho*(ni*out.du_dy1114xy - out.Rxy1114xy);
shear_stress1124xy = rho*(ni*out.du_dy1124xy - out.Rxy1124xy);
shear_stress1134xy = rho*(ni*out.du_dy1134xy - out.Rxy1134xy);

figure(72)
grid on
hold on
plot(linspace(0,1,50),linspace(1,0,50),'k','linewidth',3)
hold on
plot((((out.r1114xy(60:480)-out.r1114xy(60)))./20.7),shear_stress1114xy(60:480)./tau_wall(1),'r','linewidth',2)
hold on
plot((((out.r1124xy(46:491)-out.r1124xy(46)))./21.435),shear_stress1124xy(46:491)./tau_wall(1),'b','linewidth',2)
hold on
plot((((out.r1134xy(50:492)-out.r1134xy(50)))./21.0537),shear_stress1134xy(50:492)./tau_wall(1),'y','linewidth',2)
hold on
xlabel('y/R')
ylabel('$\frac{\tau}{\tau_w}$','Interpreter','latex','FontSize',20)
legend('theoretical','ppp1','ppp2','ppp3')
title('total shear stress Q025,160Hz,grid4, upper part')

figure(73)
grid on
hold on
plot(linspace(0,1,50),linspace(1,0,50),'k','linewidth',3)
hold on
plot((((out.r1114xy(930)-out.r1114xy(480:930)))./20.7), -shear_stress1114xy(480:930)./tau_wall(1),'r', 'LineWidth',2)
hold on
plot((((out.r1124xy(930)-out.r1124xy(491:942)))./21.435), -shear_stress1124xy(491:942)./tau_wall(1),'b', 'LineWidth',2)
hold on
plot((((out.r1134xy(930)-out.r1134xy(492:930)))./21.0537), -shear_stress1134xy(492:930)./tau_wall(1),'y', 'LineWidth',2)
hold on
xlabel('y/R')
ylabel('$\frac{\tau}{\tau_w}$','Interpreter','latex','FontSize',20)
legend('theoretical','ppp1','ppp2','ppp3')
title('total shear stress Q025,160Hz,grid4, bottom part')






%% 
close all

