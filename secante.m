%Secante: Se ingresan los valores iniciales (x0, x1), la tolerancia del
%error (Tol) y el máximo número de interaciones (niter)

%FUNCION: utilizamos la función para  hallar el coeficiente de drag de una
%aeronave en función de la velocidad según su altura (h), temperatura del
%aire (T) y superficie de contacto (s).
%La función es: f=(348.42*(1-(h*1.05e-4))/(T+273))*(1-(exp(1)^(-x)))*s+(pi*x)
%donde x es la Velocidad a encontrar para que el drag sea cero.

%DATOS: Para este analisis se usa una altura h=12000, temperatura T=-63 y
%superficie s=124, para esto, ingrese en el código la función con los datos
%reemplazados indicada a continuación:
%(348.42*(1-(12000*1.05e-4))/(-63+273))*(1-(exp(1)^(-x)))*124+(pi*x)

%INTERVALO: ingresamos xi=15 y xs=18 ya que sabemos que hay una raíz en
%este intervalo.

function [n,xn,fm,E] = secante()
    syms x

        %f=(348.42*(1-(h*1.05e-4))/(T+273))*(1-(exp(1)^(-x)))*s+(pi*x);     %Función a Evaluar
        f=input("Ingrese la función a evaluar: ");
        disp(" ")
        x0 = input("Ingrese el limite inferior: ");
        disp(" ")
        x1 = input("Ingrese el limite superior: ");
        disp(" ")
        Tol = input("Ingrese la tolerancia deseada: ");
        disp(" ")
        niter = input("Ingrese número de iteraciones: ");
        disp(" ")
        c=0;
        fm(c+1) = eval(subs(f,x0));
        fe0=fm(c+1);
        E(c+1)=Tol+2;
        xn(c+1)=x0;
        N(c+1)=c;

        figure
        x=0:0.01:20;
        fg=(348.42*(1-(12000*1.05e-4))/(-63+273))*(1-(exp(1).^(-x)))*124+(pi*x);
        plot(x,fg)
        grid on

        if fe0==0
            s=x0;
            n=c;
            fprintf('%f es raíz de f(x)',x0)
        end
        c=c+1;
        fm(c+1) = eval(subs(f,x1));
        fe=fm(c+1);
        den=fe-fe0;
        E(c+1)=Tol+1;
        error=E(c+1);
        xn(c+1)=x1;
        N(c+1)=c;
        while error>Tol && fe~=0 && den~=0 && c<niter
            xn(c+2)=x1-fe*(x1-x0)/den;     %Fórmula
            %E(c+2)=abs((xn(c+2)-x1));      %Decimales Correctos
            E(c+2)=abs((xn-x0)/xn);        %Cifras Siginificativas
            error=E(c+2);
            x0=x1;
            fe0=fe;
            x1=xn(c+2);
            fm(c+2)=eval(subs(f,x1));
            fe=fm(c+2);
            den=fe-fe0;
            N(c+2)=c+1;
            c=c+1;
        end

        format long
        VarNames = ["Iteraciones (n)","Velocidad","Drag","Error"];
        table(N',xn',fm',E','VariableNames',VarNames)

        if fe==0
            n=c;
            fprintf('%f es raíz de f(x)  \n',x1)
        elseif error<Tol
            n=c;
            fprintf('%f es una aproximación de una raíz de F(x) con una tolerancia= %f \n',Tol)
        elseif den==0
            n=c;
            fprintf('%f es una posible raíz múltiple de f(x) \n',x0)
        else
            n=c;
            fprintf('Fracasó en %f iteraciones \n', niter)
        end

end