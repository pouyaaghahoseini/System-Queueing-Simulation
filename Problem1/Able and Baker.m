a=randi([5 10],1,60);
able=zeros(1,60);
baker=zeros(1,60);
tA = 0;
tB = 0;
t0 = 0;
uA = 0;
uB = 0;
wait = 0;
arrival=cumsum(a);
for i=1:60
    work=randi([10 16]);
    if tA<=tB
        wait = wait + max(0, tA - t0);
        tA = max(t0, tA) + work;
        able(1,i)=tA;
        baker(1,i)=tB;
        uA = uA + work;
    else
        wait = wait + max(0, tB - t0);
        tB = max(t0, tB) + work;
        baker(1,i)=tB;
        able(1,i)=tA;
        uB = uB + work;
    end
end

