function I=cal_scen1_sum(c,N)

Omega_Value = [0, 0.01, 0.01, 0.01, 0.01, 0.2, 0.6, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0];
speed=[3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14];
k=2;

lambda=140.86;
etta=-500;
P_rated=1500;
speed_cut_in=3.5;
speed_rated=14;
I=0;
for t=1:N
    first_sum=0;
    second_sum=0;
    third_sum=0;
    for j=1:21
        first_inner_sum=0; 
        for i=1:24
            first_inner_sum=first_inner_sum+ 15*Omega_Value(i) *(exp(-(speed(j)/c(i,t))^k)-exp(-(speed(j+1)/c(i,t))^k)) ;
        end 
        first_sum = first_sum + ((speed(j)+speed(j+1))/2)*first_inner_sum ;  
    end  
    for i=1:24
        second_sum=second_sum+15*Omega_Value(i)*(exp(-(speed_rated/c(i,t))^k));
        third_sum=third_sum+15*Omega_Value(i)*(exp(-(speed_cut_in/c(i,t))^k)-exp(-(speed_rated/c(i,t))^k));
    end
    I=I+lambda*first_sum+P_rated*second_sum+etta*third_sum;
end     
end
