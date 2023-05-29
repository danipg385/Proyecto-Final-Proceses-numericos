%Regla Falsa: se ingresa el valor inicial y final del intervalo (xi, xs), la tolerancia del error (Tol) y el màximo nùmero de iteraciones (niter)

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

function [s,E,fm,N] = Regla_falsa()
    syms x
   
    %f=(348.42*(1-(h*1.05e-4))/(T+273))*(1-(exp(1)^(-x)))*s+(pi*x);     %Función a Evaluar
    f=input("Ingrese la función a evaluar: ");
    disp(" ")
    xi = input("Ingrese el limite inferior: ");
    disp(" ")
    xs = input("Ingrese el limite superior: ");
    disp(" ")
    Tol = input("Ingrese la tolerancia deseada: ");
    disp(" ")
    niter = input("Ingrese número de iteraciones: ");
    disp(" ")
    
    fi=eval(subs(f,xi));
    fs=eval(subs(f,xs));
    
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
        xm(c+1)= xi-((fi*(xs-xi))/(fs-fi));
        fm(c+1)=eval(subs(f,xm(c+1)));
        fe=fm(c+1);
        E(c+1)=Tol+1;
        error=E(c+1);
        N(c+1)=c+1;
        while error>Tol && fe~=0 && c<niter
            if fi*fe<0
                xs=xm(c+1);
                fs=eval(subs(f,xs));
            else
                xi=xm(c+1);
                fi=eval(subs(f,xi));
            end
            xa=xm(c+1);
            xm(c+2)=xs-(fs*(xs-xi))/(fs-fi);    %Fórmula
            fm(c+2)=eval(subs(f,xm(c+2)));
            fe=fm(c+2);
            E(c+2)=abs((xm(c+2)-xa));    %Decimales Correctos
           %E(c+2)=abs((xm(c+2)-xa)/(xm(c+2)));  %Cifras Significativas
            N(c+2)=c+2;
            error=E(c+2);
            c=c+1;
        end
        if fe==0
           s=xm(c+1);
           fprintf('%f es raiz de f(x)',xm(c+1)) 

           format long
           VarNames = ["Iteraciones (n)","Velocidad","Drag","Error"];
           table(N',xm',fm',E','VariableNames',VarNames)
       
        elseif error<Tol
           s=xm(c+1);
           fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f',xm(c+1),Tol)
        
           format long
           VarNames = ["Iteraciones (n)","Velocidad","Drag","Error"];
           table(N',xm',fm',E','VariableNames',VarNames)
        
        else 
           s=xm(c+1);
           fprintf('Fracasó en %f iteraciones',niter) 
        end
    else
       fprintf('El intervalo es inadecuado')         
    end    
    
end