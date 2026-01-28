function [Population,PositionMatrix] = PopSort(Population,PositionMatrix)
% Sort the population members from best to worst
popsize = numel(Population);
Cost = zeros(1, popsize);
Position_Matrix = PositionMatrix;

for i = 1 : popsize
    Cost(i) = Population{i}{2};
end
[Cost, indices] = sort(Cost, 2, 'ascend');
Chroms = zeros(popsize, length(Population{1}{1}));
for i = 1 : popsize
    Chroms(i, :) = Population{indices(i)}{1};
    Position_Matrix{i}{1} = PositionMatrix{indices(i)}{1};
end
for i = 1 : popsize
    Population{i}{1} = Chroms(i, :);
    Population{i}{2} = Cost(i);
    PositionMatrix{i}{1} = Position_Matrix{i}{1};
end
return