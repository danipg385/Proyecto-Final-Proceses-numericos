% Datos de ejemplo
X = [2 4 6 8 10];
Y = [12 8 6 5 4];

% Realizar la interpolación de spline lineal
pp = interp1(X, Y, 'linear', 'pp');

% Obtener los coeficientes del polinomio
coefs = pp.coefs;

% Obtener los puntos de control del polinomio
xi = pp.breaks;
yi = Y;

% Evaluar el polinomio en los puntos de control
yi_interp = ppval(pp, xi);

% Graficar los datos y el polinomio
plot(X, Y, 'o', xi, yi_interp, '-')
legend('Datos', 'Polinomio')
xlabel('x')
ylabel('f(x)')
title('Interpolación con Spline Lineal')

% Imprimir el polinomio
disp('Polinomio:')
for i = 1:numel(coefs)
    fprintf('P%d(x) = %f*(x - %.2f) + %f\n', i-1, coefs(i), xi(i), yi(i));
end
