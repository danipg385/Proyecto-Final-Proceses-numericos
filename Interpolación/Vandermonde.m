% Datos de ejemplo
X=[2 4 6 8 10];
Y=[12 8 6 5 4];

% Construcción de la matriz de Vandermonde
n = length(X);
A = ones(n, n); % Inicializar la matriz de Vandermonde con unos
for i = 2:n
    A(:, i) = X.^(i-1); % Llenar las columnas con las potencias de X
end

% Resolver el sistema de ecuaciones lineales
coeficientes = A \ Y'; % Resuelve el sistema A * coeficientes = Y

% Generar los valores para la curva interpolante
xx = linspace(min(X), max(X), 1000); % Puntos para evaluar el polinomio
yy = zeros(size(xx)); % Valores de la curva interpolante
for i = 1:n
    yy = yy + coeficientes(i) * xx.^(i-1); % Sumar los términos del polinomio
end

% Graficar los datos y la curva interpolante
plot(X, Y, 'o', xx, yy, '-')
legend('Datos', 'Polinomio de Vandermonde')
xlabel('x')
ylabel('f(x)')
title('Interpolación con Método de Vandermonde')

% Mostrar los parámetros de entrada y el polinomio resultante
fprintf('Parámetros de entrada:\n');
fprintf('X = [%s]\n', num2str(X));
fprintf('Y = [%s]\n\n', num2str(Y));

fprintf('Polinomio que describe el comportamiento de los datos:\n');
for i = 1:n
    fprintf('Término %d: %.4f * x^(%d)\n', i, coeficientes(i), i-1);
end
