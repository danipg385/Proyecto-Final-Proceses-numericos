% Datos de entrada
X = [2 4 6 8 10];
Y = [12 8 6 5 4];

% Realizar interpolación mediante spline cúbico
xx = linspace(min(X), max(X), 1000); % Puntos para evaluar el spline
yy = spline(X, Y, xx); % Evaluación del spline

% Graficar los datos y el spline resultante
plot(X, Y, 'o', xx, yy, '-')
legend('Datos', 'Spline cúbico')
xlabel('x')
ylabel('f(x)')
title('Interpolación con Spline Cúbico')

% Obtener el polinomio que describe el comportamiento de los datos
pp = spline(X, Y); % Obtiene la representación del spline
coeffs = pp.coefs; % Coeficientes del polinomio
n = size(coeffs, 1); % Número de segmentos
polinomio = cell(n, 1); % Celda para almacenar los polinomios de cada segmento

for i = 1:n
    p = coeffs(i, :);
    grado = length(p) - 1;
    polinomio{i} = sprintf('%.4f', p(1));
    for j = 2:length(p)
        if p(j) >= 0
            polinomio{i} = [polinomio{i}, ' + ', sprintf('%.4f', p(j)), 'x^', num2str(grado)];
        else
            polinomio{i} = [polinomio{i}, ' - ', sprintf('%.4f', abs(p(j))), 'x^', num2str(grado)];
        end
        grado = grado - 1;
    end
end

% Mostrar los parámetros de entrada y el polinomio resultante
fprintf('Parámetros de entrada:\n');
fprintf('X = [%s]\n', num2str(X));
fprintf('Y = [%s]\n\n', num2str(Y));

fprintf('Polinomio que describe el comportamiento de los datos:\n');
for i = 1:n
    fprintf('Segmento %d: %s, %.4f <= x <= %.4f\n', i, polinomio{i}, X(i), X(i+1));
end
