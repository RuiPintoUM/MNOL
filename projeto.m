% Coordenadas dos pontos geográficos
x = [0, 2, 3, 4, 1, 2, 4, 3, 2, 0, 1, 1.5, 2.5, 3, 3.5, 3, 2];
y = [0, 0, 1, 3, 4, 6, 4, 2, 1, 1, 3, 4, 5, 4, 3, 2, 1];

[p1,s1] = polyfit(x, y, 1);
[p2,s2] = polyfit(x,y,2);
[p3,s3] = polyfit(x,y,3);
[p4,s4] = polyfit(x,y,4);
[p5,s5] = polyfit(x,y,5);
[p6,s6] = polyfit(x,y,6);

% Erro

erro1 = s1.normr^2; % erro para polinómio de grau 1
erro2 = s2.normr^2; % erro para polinómio de grau 2
erro3 = s3.normr^2; % erro para polinómio de grau 3
erro4 = s4.normr^2; % erro para polinómio de grau 4
erro5 = s5.normr^2; % erro para polinómio de grau 5
erro6 = s6.normr^2; % erro para polinómio de grau 6

% Escolha de polinómio 5

% Controlo

areaSemElev = polyarea(x, y);

%Cálculo da área utilizando ajuste polinomial e integração numérica"

x_fit = linspace(min(x), max(x), 1000);

y_fit = polyval(p5, x_fit);

area1 = trapz(x_fit, y_fit);

% Cálculo da área com construção do modelo e mininmos quadrados

M = @(c, x) c(1) * cos(c(2) * x) + c(3) * x + c(4);

[c,S] = lsqcurvefit(M,[1 1 1 1],x,y); 

x_fit2 = linspace(min(x), max(x), 100);

y_fit2 = M(c, xForCurve);

area2 = trapz(x_fit2,y_fit2);

% ---- Exibição ----

% Gráficos 

figure;
scatter(x, y, 'filled');
hold on;
plot(x_fit, y_fit);
hold off;
title('Ajuste de curva polinomial');
xlabel('X');
ylabel('Y'); 

figure;
scatter(x, y, 'filled');
hold on;
plot(xForCurve, yFit);
hold off;
title('Ajuste da curva polinomial');
xlabel('X');
ylabel('Y');

% Erros

fprintf('Erros de grau de polinómios\n\n');
fprintf('grau 1: %.2f\n',erro1);
fprintf('grau 2: %.2f\n',erro2);
fprintf('grau 3: %.2f\n',erro3);
fprintf('grau 4: %.2f\n',erro4);
fprintf('grau 5: %.2f\n',erro5);
fprintf('grau 6: %.2f\n\n',erro6);

% Áreas

fprintf('Áreas\n\n');
fprintf('Área sem elevações: %.2f unidades de área\n',areaSemElev);
fprintf('Área estratégia 1: %.2f unidades de área\n', area1);
fprintf('Área estratégia 2: %.2f unidades de área\n', area2);
