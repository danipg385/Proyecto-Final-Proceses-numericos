% Datos de ejemplo
X=[2 4 6 8 10];
Y=[12 8 6 5 4];

% Cálculo de las diferencias divididas
n = length(X);
D = zeros(n); % Matriz de diferencias divididas
D(:, 1) = Y'; % La primera columna son los valores de Y
for j = 2:n
    for i = 1:n-j+1
        D(i, j) = (D(i+1, j-1) - D(i, j-1)) / (X(i+j-1) - X(i));
    end
end

% Generar los valores para la curva interpolante
xx = linspace(min(X), max(X), 1000); % Puntos para evaluar el polinomio
yy = zeros(size(xx)); % Valores de la curva interpolante
for k = 1:n
    term = D(1, k);
    for j = 1:k-1
        term = term .* (xx - X(j));
    end
    yy = yy + term;
end

% Graficar los datos y la curva interpolante
plot(X, Y, 'o', xx, yy, '-')
legend('Datos', 'Polinomio de Newton')
xlabel('x')
ylabel('f(x)')
title('Interpolación con Método de Newton')

% Mostrar los parámetros de entrada y el polinomio resultante
fprintf('Parámetros de entrada:\n');
fprintf('X = [%s]\n', num2str(X));
fprintf('Y = [%s]\n\n', num2str(Y));

fprintf('Polinomio que describe el comportamiento de los datos:\n');
syms x
polinomio = D(1, 1);
for k = 2:n
    term = D(1, k);
    for j = 1:k-1
        term = term * (x - X(j));
    end
    polinomio = polinomio + term;
end
polinomio = simplify(polinomio);
fprintf('P(x) = %s\n', char(polinomio));
