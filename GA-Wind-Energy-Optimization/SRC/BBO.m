function [MinCost] = BBO(Farm_Radius,Number_Turb)
 ProblemFunction=@WindEnergyCont;
% Biogeography-based optimization (BBO) software for minimizing a continuous function
% INPUTS:  ProblemFunction = the handle of the function that returns the handles of the initialization and cost functions.
%          DisplayFlag = true or false, whether or not to display and plot results.
%          RandSeed = random number seed
% OUTPUTS: MinCost = array of best solution, one element for each generation

   if ~exist('DisplayFlag', 'var')
        DisplayFlag = true;
    end
    if ~exist('RandSeed', 'var')
        RandSeed = round(sum(100*clock));
    end
    OPTIONS.Maxgen = 50; % generation count limit 
    OPTIONS.popsize = 50; % population size
    OPTIONS.numVar = 2*Number_Turb; % number of variables in each population member (i.e., problem dimension)
    PMutate = 0.01; % mutation probability
    Keep = 2; % elitism parameter: how many of the best habitats to keep from one generation to the next

    % Initialization
    [MinCost, AvgCost, CostFunction, MaxParValue, MinParValue, Population, OPTIONS,PositionMatrix] = ...
        Init(DisplayFlag, ProblemFunction, RandSeed, OPTIONS,Farm_Radius);
    EliteSolution = zeros(Keep, OPTIONS.numVar);
    EliteCost = zeros(Keep, 1);
    Island = zeros(OPTIONS.popsize, OPTIONS.numVar);
    % Compute immigration and emigration rates.
    % lambda(i) is the immigration rate for habitat i.
    % mu(i) is the emigration rate for habitat i.
    % This assumes the population is sorted from most fit to least fit.
    mu = (OPTIONS.popsize + 1 - (1:OPTIONS.popsize)) / (OPTIONS.popsize + 1);
    lambda = 1 - mu;
    % Begin the optimization loop
for GenIndex = 1 : OPTIONS.Maxgen
    % Save the best habitats in a temporary array.
    for j = 1 : Keep
        EliteSolution(j,:) = Population{j}{1};
        EliteCost(j) = Population{j}{2};
    end
    % Use lambda and mu to decide how much information to share between habitats.
    for k = 1 : length(Population)
        % Probabilistically input new information into habitat i
        for j = 1 : OPTIONS.numVar
            if rand < lambda(k)
                % Pick a habitat from which to obtain a feature (roulette wheel selection)
                RandomNum = rand * sum(mu);
                Select = mu(1);
                SelectIndex = 1;
                while (RandomNum > Select) && (SelectIndex < OPTIONS.popsize)
                    SelectIndex = SelectIndex + 1;
                    Select = Select + mu(SelectIndex);
                end
                Island(k,j) = Population{SelectIndex}{1}(j);
            else
                Island(k,j) = Population{k}{1}(j);
            end
        end
    end
% Island
    % Mutation
    for k = 1 : length(Population)
        for parnum = 1 : OPTIONS.numVar
            if PMutate > rand                            
                Island(k,parnum) = MinParValue + (MaxParValue - MinParValue) * rand;
            end
        end
    end
    % Replace the habitats with their new versions.    
     for k = 1 : length(Population)
         A=zeros(Number_Turb,2);
         Population{k}{1} = Island(k,:);
         j = 1;
         for i =1:Number_Turb
             A(i,1) =Island(k,j);
             A(i,2) =Island(k,j+1);
             PositionMatrix{k}{1}(i,:) = [A(i,1), A(i,2)];
             j = j + 2;  
         end
%         Population(k).chrom = Island(k,:);
%         A(1,1) = Island(k,1);
%         A(1,2) = Island(k,2);
%         A(2,1) = Island(k,3);
%         A(2,2) = Island(k,4);
%         PositionMatrix(k).A(1,:) = [A(1,1), A(1,2)];
%         PositionMatrix(k).A(2,:) = [A(2,1), A(2,2)];
     end   
    % Calculate cost
    Population = CostFunction(Population,PositionMatrix,Farm_Radius);
    % Sort from best to worst
    [Population, PositionMatrix] = PopSort(Population,PositionMatrix);
    % Replace the current generation's worst individuals with the previous generation's elites.
    n = length(Population);
    for k = 1 : Keep
        Population{n-k+1}{1} = EliteSolution(k,:);
        j = 1;
         for i =1:Number_Turb
             A(i,1) =EliteSolution(k,j);
             A(i,2) =EliteSolution(k,j+1);
             PositionMatrix{n-k+1}{1}(i,:) = [A(i,1), A(i,2)];
             j = j + 2;  
         end 
%         A(1,1) = EliteSolution(k,1);
%         A(1,2) = EliteSolution(k,2);
%         A(2,1) = EliteSolution(k,3);
%         A(2,2) = EliteSolution(k,4);
%         PositionMatrix(n-k+1).A(1,:) = [A(1,1), A(1,2)];
%         PositionMatrix(n-k+1).A(2,:) = [A(2,1), A(2,2)];
        
        Population{n-k+1}{2} = EliteCost(k);
    end
    % Make sure the population does not have duplicates. 
%     display('position matrix and cost before cleardup');
%    for i=1:OPTIONS.popsize
%       PositionMatrix(i).A
%       Population(i).cost
%    end
    
   [Population,PositionMatrix] = ClearDups(Population, OPTIONS, MaxParValue, MinParValue, CostFunction,PositionMatrix,Farm_Radius);  
%    display('position matrix and cost after cleardup');
%    for i=1:OPTIONS.popsize
%       PositionMatrix(i).A
%       Population(i).cost
%    end
   [Population, PositionMatrix] = PopSort(Population,PositionMatrix);
   display('final position matrix and cost');
   for i=1:Keep
      PositionMatrix{i}{1}
      Population{i}{2}
   end
    
    
    % Display info to screen
    for i = 1:numel(Population)
         Pop_Cost(i) = Population{i}{2};
    end
    
    MinCost(GenIndex+1) = Population{1}{2};
    AvgCost(GenIndex+1) = mean([Pop_Cost]);
    if DisplayFlag
        disp(['The best and mean of Generation # ', num2str(GenIndex), ' are ',...
        num2str(MinCost(GenIndex+1)), ' and ', num2str(AvgCost(GenIndex+1))]);
         if (MinCost(GenIndex+1))< 0.001
           Conclude(DisplayFlag, OPTIONS, Population, MinCost, AvgCost);
           return
%            break
        end
    
    end
end
% Conclude(DisplayFlag, OPTIONS, Population, MinCost, AvgCost);
% return
%     end
% end