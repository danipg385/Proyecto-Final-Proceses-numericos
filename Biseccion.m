%Bisección: se ingresa el valor inicial y final del intervalo (xi, xs), la tolerancia del error (Tol) y el màximo nùmero de iteraciones (niter) 
%Modificado para dar los valores en una tabla!

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

function [xm] = Biseccion()
    syms x
    %f=(348.42*(1-(h*1.05e-4))/(T+273))*(1-(exp(1)^(-x)))*s+(pi*x);     %Función a Evaluar
    f=input("Ingrese la función a evaluar: ");
    disp(" ")
    xi=input("Ingrese el límite inferior: ");
    disp(" ")
    xs=input("Ingrese el límite superior: ");
    disp(" ")
    Tol=input("Ingrese la tolerancia: ");
    disp(" ")
    niter=input("Ingrese el número de iteraciones: ");
    fi=eval(subs(f,xi));
    fs=eval(subs(f,xs));
    
    n=0;

    figure
    x=0:0.01:20;
    fg=(348.42*(1-(12000*1.05e-4))/(-63+273))*(1-(exp(1).^(-x)))*124+(pi*x);
    plot(x,fg)
    grid on

    if fi==0
        s=xi;
        E=0;
        fprintf('%f es raiz de f(x)',xi)
    elseif fs==0
        s=xs;
        E=0;
        fprintf('%f es raiz de f(x)',xs)
    elseif fs*fi<0
        c=0;
        xm=(xi+xs)/2;
        fm(c+1)=eval(subs(f,xm));
        fe=fm(c+1);
        E(c+1)=Tol+1;
        error=E(c+1);
        n(c+1)=c;
        s(c+1)=xm;
        while error>Tol && fe~=0 && c<niter
            if fi*fe<0
                xs=xm;
                fs=eval(subs(f,xs));
            else
                xi=xm;
                fi=eval(subs(f,xi));
            end
            xa=xm;
            xm=(xi+xs)/2;          %Fórmula
            fm(c+2)=eval(subs(f,xm));
            fe=fm(c+2);
            E(c+2)=abs(xm-xa);         %Decimales Correctos
            %E(c+2)=abs((xm-xa)/(xm));     %Cifras Significativas
            n(c+2)=c+1;
            s(c+2)=xm;
            error=E(c+2);
            c=c+1;
        end
        if fe==0
           s=xm;
           fprintf('%f es raiz de f(x)',xm) 

           format long
           VarNames = ["Iteraciones (n)","Velocidad","Drag","Error"];
           table(n',s',fm',E','VariableNames',VarNames)

        elseif error<Tol

           fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f',xm,Tol)

           VarNames = ["Iteraciones (n)","Velocidad","Drag","Error"];
           table(n',s',fm',E','VariableNames',VarNames)
          
        else 
           s=xm;
           fprintf('Fracasó en %f iteraciones',niter) 
        end
        
    else
       fprintf('El intervalo es inadecuado')         
    end
    
end