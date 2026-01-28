function main(ProblemFunction, DisplayFlag,RandSeed)
clc
clear all 
ProblemFunction=@WindEnergyCont;
clc;
X = input('Enter 1 for Mode 1 and  2 for Mode 2      ');
% if(X~=1 || X~=2)
%     X = 3;
% end
switch(X)
   case 1 
       for Farm_Radius = 500
%           Farm_Radius = 500
       for Number_Turb =2:1:2
%            Number_Turb=10;
        disp(['Results For Farm Radius = ' num2str(Farm_Radius),'  and Number of Turbine =  ' num2str(Number_Turb)]);
        %disp('-----------------------        ---------------------');
%        [MinCost] = BBO(Farm_Radius,Number_Turb);
       [MinCost] = BBO(Farm_Radius,Number_Turb);
        end
     end
   case 2 
       Farm_Radius = input('Please Enter Farm radius : ');
       disp('                                            ');
       Number_Turb = input('Please Enter Number of Turbines : ');
       [MinCost] = BBO(Farm_Radius,Number_Turb);
   case 3 
      disp('Please Enter the Correct Choice either 1 or 2' );  
end

xlswrite('classlist',main)