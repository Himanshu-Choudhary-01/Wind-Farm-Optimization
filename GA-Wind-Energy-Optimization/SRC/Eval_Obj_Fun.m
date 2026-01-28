function   wake_loss = Eval_Obj_Fun(PositionMatrix,Farm_Radius)
[Num_Tur, A ] = size(PositionMatrix);
w = [0,0.01,0.01,0.01,0.01,0.2,0.6,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0];
% disp('OUTPUTS');
% disp('*********')
% PositionMatrix
a = 1;
i = 0;
%OPTIONS.popsize=5;
r=Farm_Radius;  %farm radius
N=Num_Tur;    %no. of turbine
R=38.5; %Rotor radius
p=N;
%for m=1:OPTIONS.popsize
 for i = 0:15:345 
     j = i + 15;
     C_i = VelocityDeficit(i,j,PositionMatrix,N);
     final_C_i(a,:)= C_i;
     a = a + 1;
 end
E_P=cal_scen1_sum(final_C_i,N); 

wake_loss =(14045.7374*N) - E_P;
 
for i=1:N
    g(i)=PositionMatrix(i,1)^2 + PositionMatrix(i,2)^2 -r^2;
end  
for i=1:N
 for j= 1:N
      if j ~=i
          p=p+1;
          g(p) =-(PositionMatrix(i,1)-PositionMatrix(j,1))^2 -(PositionMatrix(i,2)-PositionMatrix(j,2))^2+ 64*R^2;
      end 
 end
end  
for i=1:N^2
   if(g(i)> 0 )
     c=1+power(10,10)*g(i);
     wake_loss= wake_loss+c*c ;      
   end
end