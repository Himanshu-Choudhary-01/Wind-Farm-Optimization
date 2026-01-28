function C =  VelocityDeficit(p,q,PositionMatrix,N)
R=38.5;  % Rotor radius   vv
K=0.075; % wake spreading constant
CT=0.8;  %thrust coefficient
d=zeros(N);
beta=zeros(N);
vel_defecit=zeros(N);
alpha = atan(K);
a=1-sqrt(1-CT);
b=K/R;
syms theta;

direction_bins = [p, q];
direction_bins_low = direction_bins(1);
direction_bins_high = direction_bins(2);
direction_mean=(direction_bins(1)+direction_bins(2))/2;

 for i=1:N
     vel_def =0;
      for j=1:N
             d(i,j)=abs((PositionMatrix(i,1) - PositionMatrix(j,1))*cos(direction_mean)+(PositionMatrix(i,2) - PositionMatrix(j,2))*sin(direction_mean));            
%              beta_mean(i,j)=acos((((PositionMatrix(i,1)-PositionMatrix(j,1))*cos(direction_mean)+(PositionMatrix(i,2)-PositionMatrix(j,2))*sin(direction_mean) + R/K)/(sqrt(PositionMatrix(i,1)-PositionMatrix(j,1)+(R/K)*cos(direction_mean))^2+(PositionMatrix(i,2)-PositionMatrix(j,2)+(R/K)*sin(direction_mean))^2)));
            beta_mean(i,j)=acos(((PositionMatrix(i,1)-PositionMatrix(j,1))*cos(direction_mean)+(PositionMatrix(i,2)-PositionMatrix(j,2))*sin(direction_mean) + R/K)/(sqrt((PositionMatrix(i,1)-PositionMatrix(j,1)+(R/K)*cos(direction_mean))^2+(PositionMatrix(i,2)-PositionMatrix(j,2)+(R/K)*sin(direction_mean))^2))); 
            vel_defecit(i,j) = a/(1+b*d(i,j))^2;         
        if  beta_mean(i,j) < alpha  && j~=i
          vel_def = vel_def  +(vel_defecit(i,j))^2;
        end
       
      end
    vel_def=sqrt(vel_def); 
    C(i) = vpa(13*(1 - vel_def)) ;
   
 end
end