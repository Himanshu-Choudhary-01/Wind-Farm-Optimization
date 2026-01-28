function [child] = Mutation(Parent, PMutation, Farm_Radius, OPTIONS)
    x_min = -Farm_Radius;
    x_max = Farm_Radius;
    n_m = 20;
    if rand() < PMutation
        for i = 1:OPTIONS.numVar
            u = rand();
            if rand() < 0.5
                delta = power((2*u), 1/(n_m + 1)) - 1;
                child(i) = Parent(i) + delta*(Parent(i) - x_min);
            else
                delta = 1 - power((2*(1-u)),1/(n_m + 1));
                child(i) = Parent(i) + delta*(x_max - Parent(i));
            end
            
            if child(i) < x_min || child(i) > x_max
                child(i) = x_min + (x_max - x_min)*rand();
            end       
        end
    else
       child = Parent;
    end
end
