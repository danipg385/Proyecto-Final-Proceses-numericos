%Newton Sin Multipliciad: se ingresa el valor inicial (x0), la tolerancia del error (Tol) y el màximo nùmero de iteraciones (niter) 
%En este se pide como entrada lo mismo de siempre, pero se usa la segunda
%derivada en la fórmula

%La función es: f=(348.42*(1-(h*1.05e-4))/(T+273))*(1-(exp(1)^(-x)))*s+(pi*x)
%donde x es la Velocidad a encontrar para que el drag sea cero.

%DATOS: Para este analisis se usa una altura h=12000, temperatura T=-63 y
%superficie s=124, para esto, ingrese en el código la función con los datos
%reemplazados indicada a continuación:
%(348.42*(1-(12000*1.05e-4))/(-63+273))*(1-(exp(1)^(-x)))*124+(pi*x)

%X INICIAL: ingresamos x0=15 ya que sabemos que hay una raíz luego de ese
%número.

function [N,s,E] = newtonmult2()
    format long
    syms x
        %f=(348.42*(1-(h*1.05e-4))/(T+273))*(1-(exp(1)^(-x)))*s+(pi*x);     %Función a Evaluar
        f=input("Ingrese la función a evaluar: ");
        disp(" ")
        x0=input("Ingrese el valor inicial: ");
        disp(" ")
        Tol=input("Ingrese la tolerancia: ");
        disp(" ")
        niter=input("Ingrese el número de iteraciones: ");
        
        df=diff(f);
        d2f=diff(df);
        c=0;
        fm(c+1) = eval(subs(f,x0));
        fe=fm(c+1);
        dfm(c+1) = eval(subs(df,x0));
        dfe=dfm(c+1);
        d2fm(c+1) = eval(subs(d2f,x0));
        d2fe=d2fm(c+1);
        E(c+1)=Tol+1;
        error=E(c+1);
        xn(c+1)=x0;
        N(c+1)=c;

        figure
        x=0:0.01:20;
        fg=(348.42*(1-(12000*1.05e-4))/(-63+273))*(1-(exp(1).^(-x)))*124+(pi*x);
        plot(x,fg)
        grid on
        
        while error>Tol && c<niter && fe~=0
            xn(c+2)=x0-((fe*dfe)/((dfe)^2)-(fe*d2fe));   %Fórmula
            fm(c+2)=eval(subs(f,xn(c+2)));
            fe=fm(c+2);
            dfm(c+2)=eval(subs(df,xn(c+2)));
            dfe=dfm(c+2);
            d2fm(c+2)=eval(subs(d2f,xn(c+2)));
            d2fe=d2fm(c+2);
            %E(c+2)=abs(xn(c+2)-x0);         %Decimales Correctos
            E(c+2)=abs((xn-x0)/(xn));       %Cifras Significativas
            error=E(c+2);
            x0=xn(c+2);
            N(c+2)=c+1;
            c=c+1;
        end
        if fe==0
           s=x0;
           fprintf('%f es raiz de f(x) \n',x0)
           VarNames = ["Iteraciones (n)","Velocidad","Drag","Error"];
           table(N',xn',fm',E','VariableNames',VarNames)

        elseif error<Tol
           s=x0;
           fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f \n',x0,Tol)
           VarNames = ["Iteraciones (n)","Velocidad","Drag","Error"];
           table(N',xn',fm',E','VariableNames',VarNames)
        elseif dfe==0
           s=x0;
           fprintf('%f es una posible raiz múltiple de f(x) \n',x0)
           VarNames = ["Iteraciones (n)","Velocidad","Drag","Error"];
           table(N',xn',fm',E','VariableNames',VarNames)
        else 
           s=x0;
           fprintf('Fracasó en %f iteraciones \n',niter)
        end
        
end