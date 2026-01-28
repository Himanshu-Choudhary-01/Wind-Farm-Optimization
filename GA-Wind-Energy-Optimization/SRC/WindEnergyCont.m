function [InitFunction, CostFunction] = WindEnergyCont
InitFunction = @WindEnergyInit;
CostFunction = @WindEnergyCost;
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [MaxParValue, MinParValue, Population, OPTIONS,PositionMatrix] = WindEnergyInit(OPTIONS,Farm_Radius)
MinParValue = -Farm_Radius;
MaxParValue = Farm_Radius;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for popindex = 1 : OPTIONS.popsize
    p = (OPTIONS.numVar)/2;
    A=zeros(p,2);
    chrom = MinParValue + (MaxParValue - MinParValue) * rand(1,OPTIONS.numVar);
    Population{popindex}{1} = chrom;
    j = 1;
    for i =1:p
        A(i,1) = chrom(j);
        A(i,2) = chrom(j+1);
        PositionMatrix{popindex}{1}(i,:) = [A(i,1), A(i,2)];
        j = j + 2;  
    end
end    

OPTIONS.OrderDependent = true;

return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Population] = WindEnergyCost(Population,PositionMatrix,Farm_Radius)
% Compute the cost of each member in Population
for popindex = 1 : length(Population)
%   Population(popindex).cost = 0;
    Population{popindex}{2}  = Eval_Obj_Fun(PositionMatrix{popindex}{1},Farm_Radius); 
    
end
    return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

