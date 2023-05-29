%Punto fijo: se ingresa el valor inicial (x0), la tolerancia del error (Tol) y el màximo nùmero de iteraciones (niter)

%FUNCION: utilizamos la función para  hallar el coeficiente de drag de una
%aeronave en función de la velocidad según su altura (h), temperatura del
%aire (T) y superficie de contacto (s).
%La función es: f=(348.42*(1-(h*1.05e-4))/(T+273))*(1-(exp(1)^(-x)))*s+(pi*x)
%donde x es la Velocidad a encontrar para que el drag sea cero.

%DATOS: Para este analisis se usa una altura h=12000, temperatura T=-63 y
%superficie s=124, para esto, ingrese en el código la función con los datos
%reemplazados indicada a continuación:
%(348.42*(1-(12000*1.05e-4))/(-63+273))*(1-(exp(1)^(-x)))*124+(pi*x)

%FUNCION CONDICIONAL: para este analisis, trabajamos con la funcion
%condicional g(x)= -((348.42*(1-(h*1.05e-4))/(T+273))*(1-(exp(1)^(-x)))*s)/pi
%tras reemplazar los valores de altura, temperatura y superficie, ingrese
%la siguiente función cuando el código se la solicite:
%-((348.42*(1-(12000*1.05e-4))/(-63+273))*(1-(exp(1)^(-x)))*124)/pi

%X INICIAL: ingresamos x0=15 ya que sabemos que hay una raíz luego de ese
%número.

function [n,xn,fm,E] = PuntoFijo()
    syms x

        %f=(348.42*(1-(h*1.05e-4))/(T+273))*(1-(exp(1)^(-x)))*s+(pi*x);     %Función a Evaluar
        f=input("Ingrese la función a evaluar: ");
        disp(" ")
        %g=-((348.42*(1-(h*1.05e-4))/(T+273))*(1-(exp(1)^(-x)))*s)/pi;     %Función Condicional
        g=input("Ingrese la función condicional: ");
        disp(" ")
        x0=input("Ingrese el valor inicial: ");
        disp(" ")
        Tol=input("Ingrese la tolerancia: ");
        disp(" ")
        niter=input("Ingrese el número de iteraciones: ");
        disp(" ")
        c=0;
        fm(c+1) = eval(subs(f,x0));
        fe=fm(c+1);
        E(c+1)=Tol+1;
        error=E(c+1);

        xn(c+1)=x0;
        N(c+1)=c;

        figure
        x=0:0.01:20;
        fg=(348.42*(1-(12000*1.05e-4))/(-63+273))*(1-(exp(1).^(-x)))*124+(pi*x);
        plot(x,fg)
        grid on

        while error>Tol && fe~=0 && c<niter
            xn(c+2)=eval(subs(g,x0));
            fm(c+2)=eval(subs(f,xn(c+2)));
            fe=fm(c+2);
            %E(c+2)=abs((xn(c+2)-x0));    %Decimales Correctos
            E(c+2)=abs((xn(c+2)-x0)/(xn(c+2)));  %Cifras Significativas
            error=E(c+2);
            x0=xn(c+2);
            N(c+2)=c+1;
            c=c+1;
        end
        if fe==0
           s=x0;
           n=c;
           fprintf('%f es raiz de f(x)',x0)
           
           format long
           VarNames = ["Iteraciones (n)","Velocidad","Drag","Error"];
           table(N',xn',fm',E','VariableNames',VarNames)
        elseif error<Tol
           s=x0;
           n=c;
           fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f',x0,Tol)
           
           format long
           VarNames = ["Iteraciones (n)","Velocidad","Drag","Error"];
           table(N',xn',fm',E','VariableNames',VarNames)
        
        else 
           s=x0;
           n=c;
           fprintf('Fracasó en %f iteraciones',niter) 
        end   

end