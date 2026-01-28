function [MinCost, AvgCost, CostFunction, MaxParValue, MinParValue, Population, OPTIONS,PositionMatrix] = ...
    Init(DisplayFlag, ProblemFunction, RandSeed, OPTIONS,Farm_Radius)
% Initialize population-based optimization software.
if ~exist('RandSeed', 'var')
    RandSeed = round(sum(100*clock));
end
rand('state', RandSeed); % initialize random number generator
if DisplayFlag
    disp(['random # seed = ', num2str(RandSeed)]);
end
% Get the addresses of the initialization, cost, and feasibility functions.
[InitFunction, CostFunction] = ProblemFunction();
% Initialize the population.
[MaxParValue, MinParValue, Population, OPTIONS,PositionMatrix] = InitFunction(OPTIONS,Farm_Radius);
% Compute cost of each individual  
Population = CostFunction(Population,PositionMatrix,Farm_Radius);
% Sort the population from most fit to least fit
[Population, PositionMatrix] = PopSort(Population,PositionMatrix);
% Display info to screen
MinCost = zeros(OPTIONS.Maxgen, 1);
AvgCost = zeros(OPTIONS.Maxgen, 1);
MinCost(1) = Population{1}{2};
for i = 1:numel(Population)
    Pop_Cost(i) = Population{i}{2};
end
AvgCost(1) = mean([Pop_Cost]);
if DisplayFlag
    disp(['The best and mean of Generation # 0 are ', num2str(MinCost(1)), ' and ', num2str(AvgCost(1))]);
end
return