queueCount_A=0;
queueCount_B=0;
queueCount_C=0;
queueCount_D=0;
queueCount_E=0;
norm_arrival=[];
sum=0;
i=1;
while sum<600
    sum=sum+4+24*rand();
    norm_arrival(i)=sum;
    i=i+1;
end
while norm_arrival(i-1)>600
    norm_arrival=norm_arrival(1:i-2);
    i=i-1;
end
norm_count=i-1;
urgent_arrival=[];
sum=0;
i=1;
while sum<600
    sum=sum+180+240*rand();
    urgent_arrival(i)=sum;
    i=i+1;
end
while urgent_arrival(i-1)>600
    urgent_arrival=urgent_arrival(1:i-2);
    i=i-1;
end
urgent_count=i-1;
normal_wait=zeros(1,norm_count);
urgent_wait=zeros(1,urgent_count);
normal_queueTime=zeros(1,norm_count);
urgent_queueTime=zeros(1,urgent_count);
A_work=0;
A_end=0;
normal_arrivalB=[];
urgent_arrivalB=[];
urgent_counter=1;
normal_counter=1;
while normal_counter<=norm_count || urgent_counter<=urgent_count
    response=11+4*rand();
    A_work=A_work+response;
    if urgent_counter<=urgent_count && urgent_arrival(urgent_counter)<=norm_arrival(normal_counter)
        if A_end<=urgent_arrival(urgent_counter)
            urgent_wait(urgent_counter)=urgent_wait(urgent_counter) + response;
            A_end=urgent_arrival(urgent_counter)+response;
        else
            queueCount_A=queueCount_A+1;
            urgent_wait(urgent_counter)=urgent_wait(urgent_counter)+(A_end-urgent_arrival(urgent_counter))+response;
            urgent_queueTime(urgent_counter)=urgent_queueTime(urgent_counter) + A_end-urgent_arrival(urgent_counter);
            A_end=A_end+response;
        end
        urgent_arrivalB(urgent_counter)=A_end;
        urgent_counter=urgent_counter+1;
    elseif normal_counter<=norm_count
        if A_end<=norm_arrival(normal_counter)
            normal_wait(normal_counter)=normal_wait(normal_counter) + response;
            A_end=norm_arrival(normal_counter)+response;
        else
            queueCount_A=queueCount_A+1;
            normal_wait(normal_counter)=normal_wait(normal_counter)+(A_end-norm_arrival(normal_counter))+response;
            normal_queueTime(normal_counter)=normal_queueTime(normal_counter) + A_end-norm_arrival(normal_counter);
            A_end=A_end+response;
        end
        normal_arrivalB(normal_counter)=A_end;
        normal_counter=normal_counter+1;
    end
end
B_work=0;
B1_end=0;
B2_end=0;
B3_end=0;
urgent_counter=1;
normal_counter=1;
normal_arrivalC=[];
urgent_arrivalC=[];
departure=0;
c=0;
while normal_counter<=norm_count || urgent_counter<=urgent_count
    response=(19+40*rand());
    B_work=B_work+response;
    if normal_counter<=norm_count
        if urgent_counter<=urgent_count
            if normal_arrivalB(normal_counter)<urgent_arrivalB(urgent_counter)
                service=normal_arrivalB(normal_counter);
                c=1;
            else
                service=urgent_arrivalB(urgent_counter);
                c=2;
            end
        else
            service=normal_arrivalB(normal_counter);
            c=1;
        end
    else
        service=urgent_arrivalB(urgent_counter);
        c=2;
    end
    if c==2
        if B1_end<=service
            urgent_wait(urgent_counter)=urgent_wait(urgent_counter) + response;
            B1_end=urgent_arrivalB(urgent_counter)+response;
            departure=B1_end;
        elseif B2_end<=service
            urgent_wait(urgent_counter)=urgent_wait(urgent_counter) + response;
            B2_end=urgent_arrivalB(urgent_counter)+response;
            departure=B2_end;
        elseif B3_end<=service
            urgent_wait(urgent_counter)=urgent_wait(urgent_counter) + response;
            B3_end=urgent_arrivalB(urgent_counter)+response;
            departure=B3_end;
        else
            if B1_end<=B2_end && B1_end<=B3_end
                queueCount_B=queueCount_B+1;
                urgent_wait(urgent_counter)=urgent_wait(urgent_counter)+(B1_end-urgent_arrivalB(urgent_counter))+response;
                urgent_queueTime(urgent_counter)=urgent_queueTime(urgent_counter) + B1_end-urgent_arrivalB(urgent_counter);
                B1_end=B1_end+response;
                departure=B1_end;
            elseif B2_end<=B1_end && B2_end<=B3_end
                queueCount_B=queueCount_B+1;
                urgent_wait(urgent_counter)=urgent_wait(urgent_counter)+(B2_end-urgent_arrivalB(urgent_counter))+response;
                urgent_queueTime(urgent_counter)=urgent_queueTime(urgent_counter) + B2_end-urgent_arrivalB(urgent_counter);
                B2_end=B2_end+response;
                departure=B2_end;
            elseif B3_end<=B1_end && B3_end<=B2_end
                queueCount_B=queueCount_B+1;
                urgent_wait(urgent_counter)=urgent_wait(urgent_counter)+(B3_end-urgent_arrivalB(urgent_counter))+response;
                urgent_queueTime(urgent_counter)=urgent_queueTime(urgent_counter) + B3_end-urgent_arrivalB(urgent_counter);
                B3_end=B3_end+response;
                departure=B3_end;
            end
        end
        urgent_arrivalC(urgent_counter)=departure;
        urgent_counter=urgent_counter+1;
    elseif c==1
        if B1_end<=service
            normal_wait(normal_counter)=normal_wait(normal_counter) + response;
            B1_end=normal_arrivalB(normal_counter)+response;
            departure=B1_end;
        elseif B2_end<=service
            normal_wait(normal_counter)=normal_wait(normal_counter) + response;
            B2_end=normal_arrivalB(normal_counter)+response;
            departure=B2_end;
        elseif B3_end<=service
            normal_wait(normal_counter)=normal_wait(normal_counter) + response;
            B3_end=normal_arrivalB(normal_counter)+response;
            departure=B3_end;
        else
            if B1_end<=B2_end && B1_end<=B3_end
                queueCount_B=queueCount_B+1;
                normal_wait(normal_counter)=normal_wait(normal_counter)+(B1_end-normal_arrivalB(normal_counter))+response;
                normal_queueTime(normal_counter)=normal_queueTime(normal_counter) + B1_end-normal_arrivalB(normal_counter);
                B1_end=B1_end+response;
                departure=B1_end;
            elseif B2_end<=B1_end && B2_end<=B3_end
                queueCount_B=queueCount_B+1;
                normal_wait(normal_counter)=normal_wait(normal_counter)+(B2_end-normal_arrivalB(normal_counter))+response;
                normal_queueTime(normal_counter)=normal_queueTime(normal_counter) + B2_end-normal_arrivalB(normal_counter);
                B2_end=B2_end+response;
                departure=B2_end;
            elseif B3_end<=B1_end && B3_end<=B2_end
                queueCount_B=queueCount_B+1;
                normal_wait(normal_counter)=normal_wait(normal_counter)+(B3_end-normal_arrivalB(normal_counter))+response;
                normal_queueTime(normal_counter)=normal_queueTime(normal_counter) + B3_end-normal_arrivalB(normal_counter);
                B3_end=B3_end+response;
                departure=B3_end;
            end
        end
        normal_arrivalC(normal_counter)=departure;
        normal_counter=normal_counter+1;
    end
end
normal_arrivalD=[];
urgent_arrivalD=[];
C_work=0;
C_end=0;
threshold=60;
urgent_counter=1;
normal_counter=1;
departure=0;
c=0;
while normal_counter<=norm_count || urgent_counter<=urgent_count
    response=20;
    if normal_counter<=norm_count
        if urgent_counter<=urgent_count
            if normal_arrivalC(normal_counter)<urgent_arrivalC(urgent_counter)
                service=normal_arrivalC(normal_counter);
                c=1;
            else
                service=urgent_arrivalC(urgent_counter);
                c=2;
            end
        else
            service=normal_arrivalC(normal_counter);
            c=1;
        end
    else
        service=urgent_arrivalC(urgent_counter);
        c=2;
    end
    if c==2
        if 10*rand()<4
            urgent_arrivalD(urgent_counter)=urgent_arrivalC(urgent_counter);
            urgent_counter=urgent_counter+1;    
            continue;
        end
        C_work=C_work+response;
        if C_end<=service
            urgent_wait(urgent_counter)=urgent_wait(urgent_counter) + response;
            C_end=urgent_arrivalC(urgent_counter)+response;
            departure=C_end;
        else
            queueCount_C=queueCount_C+1;
            urgent_wait(urgent_counter)=urgent_wait(urgent_counter)+(C_end-urgent_arrivalC(urgent_counter))+response;
            urgent_queueTime(urgent_counter)=urgent_queueTime(urgent_counter) + C_end-urgent_arrivalC(urgent_counter);
            C_end=C_end+response;
            departure=C_end;
        end
        if C_end>=threshold
            C_end=C_end+8+(4*rand());
            threshold=threshold+120;
        end
        urgent_arrivalD(urgent_counter)=departure;
        urgent_counter=urgent_counter+1;
    elseif c==1
        if 10*rand()<4
            normal_arrivalD(normal_counter)=normal_arrivalC(normal_counter);
            normal_counter=normal_counter+1;    
            continue;
        end
        C_work=C_work+response;
        if C_end<=service
            normal_wait(normal_counter)=normal_wait(normal_counter) + response;
            C_end=normal_arrivalC(normal_counter)+response;
            departure=C_end;
        else
            queueCount_C=queueCount_C+1;
            normal_wait(normal_counter)=normal_wait(normal_counter)+(C_end-normal_arrivalC(normal_counter))+response;
            normal_queueTime(normal_counter)=normal_queueTime(normal_counter) + C_end-normal_arrivalC(normal_counter);
            C_end=C_end+response;
            departure=C_end;
        end
        if C_end>=threshold
            C_end=C_end+8+(4*rand());
            threshold=threshold+120;
        end
        normal_arrivalD(normal_counter)=departure;
        normal_counter=normal_counter+1;
    end
end

D_work=0;
D1_end=0;
D2_end=0;
D3_end=0;
D4_end=0;
urgent_counter=1;
normal_counter=1;
normal_arrivalE=zeros(1,norm_count);
urgent_arrivalE=zeros(1,urgent_count);
departure=0;
c=0;
normal_tempD=sort(normal_arrivalD);
urgent_tempD=sort(urgent_arrivalD);
while normal_counter<=norm_count || urgent_counter<=urgent_count
    response=(17+60*rand());
    D_work=D_work+response;
    if normal_counter<=norm_count
        if urgent_counter<=urgent_count
            if normal_tempD(normal_counter)<urgent_tempD(urgent_counter)
                service=normal_tempD(normal_counter);
                c=1;
            else
                service=urgent_tempD(urgent_counter);
                c=2;
            end
        else
            service=normal_tempD(normal_counter);
            c=1;
        end
    else
        service=urgent_tempD(urgent_counter);
        c=2;
    end
    if c==2
        index=find(urgent_arrivalD==service);
        if D1_end<=service
            urgent_wait(index)=urgent_wait(index) + response;
            D1_end=urgent_arrivalD(index)+response;
            departure=D1_end;
        elseif D2_end<=service
            urgent_wait(index)=urgent_wait(index) + response;
            D2_end=urgent_arrivalD(index)+response;
            departure=D2_end;
        elseif D3_end<=service
            urgent_wait(index)=urgent_wait(index) + response;
            D3_end=urgent_arrivalD(index)+response;
            departure=D3_end;
        elseif D4_end<=service
            urgent_wait(index)=urgent_wait(index) + response;
            D4_end=urgent_arrivalD(index)+response;
            departure=D4_end;
        else
            if D1_end<=D2_end && D1_end<=D3_end && D1_end<=D4_end
                queueCount_D=queueCount_D+1;
                urgent_wait(index)=urgent_wait(index)+(D1_end-urgent_arrivalD(index))+response;
                urgent_queueTime(index)=urgent_queueTime(index) + D1_end-urgent_arrivalD(index);
                D1_end=D1_end+response;
                departure=D1_end;
            elseif D2_end<=D1_end && D2_end<=D3_end && D2_end<=D4_end
                queueCount_D=queueCount_D+1;
                urgent_wait(index)=urgent_wait(index)+(D2_end-urgent_arrivalD(index))+response;
                urgent_queueTime(index)=urgent_queueTime(index) + D2_end-urgent_arrivalD(index);
                D2_end=D2_end+response;
                departure=D2_end;
            elseif D3_end<=D1_end && D3_end<=D2_end && D3_end<=D4_end
                queueCount_D=queueCount_D+1;
                urgent_wait(index)=urgent_wait(index)+(D3_end-urgent_arrivalD(index))+response;
                urgent_queueTime(index)=urgent_queueTime(index) + D3_end-urgent_arrivalD(index);
                D3_end=D3_end+response;
                departure=D3_end;
            elseif D4_end<=D1_end && D4_end<=D2_end && D4_end<=D3_end
                queueCount_D=queueCount_D+1;
                urgent_wait(index)=urgent_wait(index)+(D4_end-urgent_arrivalD(index))+response;
                urgent_queueTime(index)=urgent_queueTime(index) + D4_end-urgent_arrivalD(index);
                D4_end=D4_end+response;
                departure=D4_end;
            end
        end
        urgent_arrivalE(index)=departure;
        urgent_counter=urgent_counter+1;
    elseif c==1
        index=find(normal_arrivalD==service);
        if D1_end<=service
            normal_wait(index)=normal_wait(index)+response;
            D1_end=normal_arrivalD(index)+response;
            departure=D1_end;
        elseif D2_end<=service
            normal_wait(index)=normal_wait(index) + response;
            D2_end=normal_arrivalD(index)+response;
            departure=D2_end;
        elseif D3_end<=service
            normal_wait(index)=normal_wait(index) + response;
            D3_end=normal_arrivalD(index)+response;
            departure=D3_end;
        elseif D4_end<=service
            normal_wait(index)=normal_wait(index) + response;
            D4_end=normal_arrivalD(index)+response;
            departure=D4_end;
        else
            if D1_end<=D2_end && D1_end<=D3_end && D1_end<=D4_end
                queueCount_D=queueCount_D+1;
                normal_wait(index)=normal_wait(index)+(D1_end-normal_arrivalD(index))+response;
                normal_queueTime(index)=normal_queueTime(index) + D1_end-normal_arrivalD(index);
                D1_end=D1_end+response;
                departure=D1_end;
            elseif D2_end<=D1_end && D2_end<=D3_end && D2_end<=D4_end
                queueCount_D=queueCount_D+1;
                normal_wait(index)=normal_wait(index)+(D2_end-normal_arrivalD(index))+response;
                normal_queueTime(index)=normal_queueTime(index) + D2_end-normal_arrivalD(index);
                D2_end=D2_end+response;
                departure=D2_end;
            elseif D3_end<=D1_end && D3_end<=D2_end && D3_end<=D4_end
                queueCount_D=queueCount_D+1;
                normal_wait(index)=normal_wait(index)+(D3_end-normal_arrivalD(index))+response;
                normal_queueTime(index)=normal_queueTime(index) + D3_end-normal_arrivalD(index);
                D3_end=D3_end+response;
                departure=D3_end;
            elseif D4_end<=D1_end && D4_end<=D2_end && D4_end<=D3_end
                queueCount_D=queueCount_D+1;
                normal_wait(index)=normal_wait(index)+(D4_end-normal_arrivalD(index))+response;
                normal_queueTime(index)=normal_queueTime(index) + D4_end-normal_arrivalD(index);
                D4_end=D4_end+response;
                departure=D4_end;
            end
        end
        normal_arrivalE(index)=departure;
        normal_counter=normal_counter+1;
    end
end

E_work=0;
E1_end=0;
E2_end=0;
E3_end=0;
urgent_counter=1;
normal_counter=1;
normal_departure=zeros(1,norm_count);
urgent_departure=zeros(1,urgent_count);
departure=0;
c=0;
normal_tempE=sort(normal_arrivalE);
urgent_tempE=sort(urgent_arrivalE);
while normal_counter<=norm_count || urgent_counter<=urgent_count
    response=(38+8*rand());
    E_work=E_work+response;
    if normal_counter<=norm_count
        if urgent_counter<=urgent_count
            if normal_tempE(normal_counter)<urgent_tempE(urgent_counter)
                service=normal_tempE(normal_counter);
                c=1;
            else
                service=urgent_tempE(urgent_counter);
                c=2;
            end
        else
            service=normal_tempE(normal_counter);
            c=1;
        end
    else
        service=urgent_tempE(urgent_counter);
        c=2;
    end
    if c==2
        index=find(urgent_arrivalE==service);
        if E1_end<=service
            urgent_wait(index)=urgent_wait(index) + response;
            E1_end=urgent_arrivalE(index)+response;
            departure=E1_end;
        elseif E2_end<=service
            urgent_wait(index)=urgent_wait(index) + response;
            E2_end=urgent_arrivalE(index)+response;
            departure=E2_end;
        elseif E3_end<=service
            urgent_wait(index)=urgent_wait(index) + response;
            E3_end=urgent_arrivalE(index)+response;
            departure=E3_end;
        else
            if E1_end<=E2_end && E1_end<=E3_end
                queueCount_E=queueCount_E+1;
                urgent_wait(index)=urgent_wait(index)+(E1_end-urgent_arrivalE(index))+response;
                urgent_queueTime(index)=urgent_queueTime(index) + E1_end-urgent_arrivalE(index);
                E1_end=E1_end+response;
                departure=E1_end;
            elseif E2_end<=E1_end && E2_end<=E3_end
                queueCount_E=queueCount_E+1;
                urgent_wait(index)=urgent_wait(index)+(E2_end-urgent_arrivalE(index))+response;
                urgent_queueTime(index)=urgent_queueTime(index) + E2_end-urgent_arrivalE(index);
                E2_end=E2_end+response;
                departure=E2_end;
            elseif E3_end<=E1_end && E3_end<=E2_end
                queueCount_E=queueCount_E+1;
                urgent_wait(index)=urgent_wait(index)+(E3_end-urgent_arrivalE(index))+response;
                urgent_queueTime(index)=urgent_queueTime(index) + E3_end-urgent_arrivalE(index);
                E3_end=E3_end+response;
                departure=E3_end;
            end
        end
        urgent_departure(index)=departure;
        urgent_counter=urgent_counter+1;
    elseif c==1
        index=find(normal_arrivalE==service);
        if E1_end<=service
            normal_wait(index)=normal_wait(index)+response;
            E1_end=normal_arrivalE(index)+response;
            departure=E1_end;
        elseif E2_end<=service
            normal_wait(index)=normal_wait(index)+response;
            E2_end=normal_arrivalE(index)+response;
            departure=E2_end;
        elseif E3_end<=service
            normal_wait(index)=normal_wait(index)+response;
            E3_end=normal_arrivalE(index)+response;
            departure=E3_end;
        else
            if E1_end<=E2_end && E1_end<=E3_end
                queueCount_E=queueCount_E+1;
                normal_wait(index)=normal_wait(index)+(E1_end-normal_arrivalE(index))+response;
                normal_queueTime(index)=normal_queueTime(index) + E1_end-normal_arrivalE(index);
                E1_end=E1_end+response;
                departure=E1_end;
            elseif E2_end<=E1_end && E2_end<=E3_end
                queueCount_E=queueCount_E+1;
                normal_wait(index)=normal_wait(index)+(E2_end-normal_arrivalE(index))+response;
                normal_queueTime(index)=normal_queueTime(index) + E2_end-normal_arrivalE(index);
                E2_end=E2_end+response;
                departure=E2_end;
            elseif E3_end<=E1_end && E3_end<=E2_end
                queueCount_E=queueCount_E+1;
                normal_wait(index)=normal_wait(index)+(E3_end-normal_arrivalE(index))+response;
                normal_queueTime(index)=normal_queueTime(index) + E3_end-normal_arrivalE(index);
                E3_end=E3_end+response;
                departure=E3_end;
            end
        end
        normal_departure(index)=departure;
        normal_counter=normal_counter+1;
    end
end
fprintf("2- Average Queue Time:");
r2=[normal_queueTime urgent_queueTime];
disp(mean(r2))
fprintf("3- Average Service Time:");
r3=(A_work+B_work+C_work+D_work+E_work)/5;
disp(r3)
fprintf("4-Occupation:\n");
fprintf("A:")
disp(A_work/6)
fprintf("B:")
disp(B_work/6)
fprintf("C:")
disp(C_work/6)
fprintf("D:")
disp(D_work/6)
fprintf("E:")
disp(E_work/6)
fprintf("5-Average Length of Queues:");
ql=(queueCount_A+queueCount_B+queueCount_C+queueCount_D+queueCount_E)/5;
disp(ql)
fprintf("6-Most Delay:");
r6=[normal_queueTime urgent_queueTime];
disp(max(r6));