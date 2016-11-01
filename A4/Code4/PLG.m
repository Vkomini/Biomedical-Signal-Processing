function Poly_Leng_L=PLG(Leng, mode, Value)
%%
if (mode < 0 || mode > Leng || abs(Value) > 1.0)
    disp('Bad arguments in routine plgndr')
    Poly_Leng_L=NaN;
    return ;
end
temp4=1;
if (mode > 0)
    somx2=sqrt(1-Value.^2);
    temp=cumsum([1,2*ones(1,mode-1)]);
    temp1=-somx2*(temp);
    temp3=cumprod(temp1);
    temp4=temp3(end);
end
if (Leng== mode)
    Poly_Leng_L=temp4;
    return
else
    temp5=Value*(2*mode+1)*temp4;
    if (Leng == (mode+1))
        Poly_Leng_L=temp5;
        return
    else
        for i=mode+2:Leng
            Poly_Leng_L=(Value*(2*i-1)*temp5-(i+mode-1)*temp4)/(i-mode);
            temp4=temp5;
            temp5=Poly_Leng_L;
        end
    end
end
