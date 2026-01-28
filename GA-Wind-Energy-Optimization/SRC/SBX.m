function [child1, child2] = SBX(Parent1, Parent2, Farm_Radius, PCrossover,OPTIONS)
    x_min = -Farm_Radius;
    x_max = Farm_Radius;
    n_c = 10;
    if rand() < PCrossover
        for i = 1:OPTIONS.numVar
            u = rand();
            if rand() < 0.5
                beta = power((2*u), 1/(n_c + 1));
            else
                beta = power(1/(2*(1-u)),1/(n_c + 1));
            end
            child1(i) = 0.5*((Parent1(i) + Parent2(i)) - beta*abs(Parent2(i) - Parent1(i)));
            child2(i) = 0.5*((Parent1(i) + Parent2(i)) + beta*abs(Parent2(i) - Parent1(i)));
            
            if child1(i) < x_min || child1(i) > x_max
                child1(i) = x_min + (x_max - x_min)*rand();
            end
            if child2(i) < x_min || child2(i) > x_max
                child2(i) = x_min + (x_max - x_min)*rand();
            end                
        end
    else
       child1 = Parent1;
       child2 = Parent2;
    end
end