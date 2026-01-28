function[New_Pop] = Selection(Population, OPTIONS, Tournament_size)
    for i = 1:Tournament_size
        shuffled_index = randperm(OPTIONS.popsize);
        for j = 1:Tournament_size:OPTIONS.popsize
           K =  shuffled_index(j);
           for index = 1:Tournament_size-1
              if Population{shuffled_index(j + index)}{2} < Population{K}{2}
                 K =  shuffled_index(j + index);
              end
           end
           New_Pop{j + (i-1)}  = Population{K};
        end 
    end    
end