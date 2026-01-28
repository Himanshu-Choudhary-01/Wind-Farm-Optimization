function Conclude(DisplayFlag, OPTIONS, Population, MinCost, AvgCost)
% Output results of population-based optimization algorithm.
if DisplayFlag
    % Count the number of duplicates
    DupFlag = false(1, OPTIONS.popsize);
    for i = 1 : OPTIONS.popsize
        if DupFlag(i), continue, end
        if OPTIONS.OrderDependent
            Chrom1 = Population{i}{1};
        else
            Chrom1 = sort(Population{i}{1});
        end
        for j = i+1 : OPTIONS.popsize
            if OPTIONS.OrderDependent
                Chrom2 = Population{j}{1};
            else
                Chrom2 = sort(Population{j}{1});
            end
            if isequal(Chrom1, Chrom2)
                DupFlag(i) = true;
                DupFlag(j) = true;
            end
        end
    end  
    disp([num2str(sum(DupFlag)), ' duplicates in final population.']);
    % Display the best solution
    if OPTIONS.OrderDependent
        Chrom = Population{1}{1};
    else
        Chrom = sort(Population{1}{1});
    end
    disp(['Best chromosome = ', num2str(Chrom)]); 
    % Plot some results
%     close all;
%     plot(0:OPTIONS.Maxgen, AvgCost, 'r'); hold;
%     plot(0:OPTIONS.Maxgen, MinCost, 'b');
%     xlabel('Generation')
%     ylabel('Cost')
%     legend('Average Cost', 'Minimum Cost')
end