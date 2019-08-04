SD = 1;
m = 2;
A= normrnd(m,SD,1,100);
A= [A(A>=0) -A(A<0)]; %Make all random numbers positive
arrivalJacob = cumsum(A);
arrivalB = zeros(1,100);
responseJacob = rand(1,100);
wait=zeros(1,100);
queueTime=zeros(1,100);
ableWork=0;
bakerWork=0;
jacobEnd = 0;
for i=1:100
    if jacobEnd<=arrivalJacob(i)
        wait(i)=wait(i) + responseJacob(i);
        jacobEnd=arrivalJacob(i)+responseJacob(i);
    else
        wait(i)=wait(i)+(jacobEnd-arrivalJacob(i))+responseJacob(i);
        queueTime(i)= queueTime(i) + (jacobEnd-arrivalJacob(i));
        jacobEnd=jacobEnd+responseJacob(i);
    end
    arrivalB(i)=jacobEnd;
end
responseAble= rand(1,100)+3;
responseBaker= rand(1,100)+4;
ableEnd=0;
bakerEnd=0;
for i=1:100
    if (ableEnd<=arrivalB(i) && bakerEnd<=arrivalB(i))
        choice=randi(2);
        if (choice == 1)
            wait(i)=wait(i) + responseAble(i);
            ableEnd=arrivalB(i)+responseAble(i);
            ableWork=ableWork+responseAble(i);
        else
            wait(i)=wait(i) + responseBaker(i);
            bakerEnd=arrivalB(i)+responseBaker(i);
            bakerWork=bakerWork+responseBaker(i);
        end
    elseif (ableEnd<=arrivalB(i) && bakerEnd>arrivalB(i))
            wait(i)=wait(i) + responseAble(i);
            ableEnd=arrivalB(i)+responseAble(i);
            ableWork=ableWork+responseAble(i);
    elseif (ableEnd>arrivalB(i) && bakerEnd<=arrivalB(i))
            wait(i)=wait(i) + responseBaker(i);
            bakerEnd=arrivalB(i)+responseBaker(i);
            bakerWork=bakerWork+responseBaker(i);
    else
        if (ableEnd<=bakerEnd)
            wait(i)=wait(i)+(ableEnd-arrivalB(i))+responseAble(i);
            queueTime(i)= queueTime(i) + (ableEnd-arrivalB(i));
            ableEnd=ableEnd+responseAble(i);
            ableWork=ableWork+responseAble(i);
        else
            wait(i)=wait(i)+(bakerEnd-arrivalB(i))+responseBaker(i);
            queueTime(i)= queueTime(i) + (bakerEnd-arrivalB(i));
            bakerEnd=bakerEnd+responseBaker(i);
            bakerWork=bakerWork+responseBaker(i);
        end
    end
end
TotalRunTime = max(bakerEnd,ableEnd);
jacobAverageServiceTime=sum(responseJacob)/100;
jacobOccupation= jacobWork/TotalRunTime;

ableAverageServiceTime=ableWork/100;
ableOccupation= ableWork/TotalRunTime;

bakerAverageServiceTime=bakerWork/100;
bakerOccupation= bakerWork/TotalRunTime;

AverageWaitingTime=sum(queueTime)/100;
