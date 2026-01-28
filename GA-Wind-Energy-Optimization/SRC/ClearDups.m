function [Population,PositionMatrix] = ClearDups(Population, OPTIONS, MaxParValue, MinParValue, CostFunction,PositionMatrix,Farm_Radius)
% Make sure there are no duplicate individuals in the population.
% This logic does not make 100% sure that no duplicates exist, but any duplicates that are found are
% randomly mutated, so there should be a good chance that there are no duplicates after this procedure.
% OPTIONS.OrderDependent says if the order of the features is important or not in the solution.
Number_Turb = (OPTIONS.numVar)/2; 
for i = 1 : numel(Population)
    a=1;
    for p = 1:Number_Turb
    Chrome1(p,:) = [Population{i}{1}(a),Population{i}{1}(a+1)];
    a = a + 2;
    end
    chrome11=Population{i}{1};
    for j = i+1 : numel(Population)
        b=1;
        for q = 1:Number_Turb
        Chrome2(q,:) = [Population{j}{1}(b),Population{j}{1}(b+1)];
        b = b + 2;
        end
        chrome22=Population{j}{1};
        for m = 1:Number_Turb
            for n = 1:Number_Turb 
                if m ~= n
                    if isequal(Chrome1(m,:), Chrome1(n,:))
                      parnum1 = ceil(2* rand);
                      Chrome1(n,parnum1) = MinParValue + (MaxParValue - MinParValue) * rand;
                      if parnum1 == 1
                      Population(i).chrom(2*n - 1) = Chrome1(n,parnum1);
                      PositionMatrix(i).A(n,1)=Population(i).chrom(2*n - 1);
                      end
                      if parnum1 == 2
                      Population{i}{1}(2*n) = Chrome1(n,parnum1);
                      PositionMatrix{i}{1}(n,2)=Population{i}{1}(2*n);
                      end 
                      Population = CostFunction(Population,PositionMatrix,Farm_Radius);
                    end    
                end  
            end
        end
        
% ***************************************************************************************************************************

        for m = 1:Number_Turb
            for n = 1:Number_Turb 
                if m ~= n
                    if isequal(Chrome2(m,:), Chrome2(n,:))
                      parnum1 = ceil(2* rand);
                      Chrome2(n,parnum1) = MinParValue + (MaxParValue - MinParValue) * rand;
                      if parnum1 == 1
                      Population(j).chrom(2*n - 1) = Chrome2(n,parnum1);
                      PositionMatrix{j}{1}(n,1)=Population{j}{1}(2*n - 1);
                      end
                      if parnum1 == 2
                      Population(j).chrom(2*n) = Chrome2(n,parnum1);
                      PositionMatrix{j}{1}(n,2)=Population{j}{1}(2*n);
                      end 
                      Population = CostFunction(Population,PositionMatrix,Farm_Radius);
                    end    
                end  
            end
        end
        
% ***************************************************************************************************************************        


% ***************************************************************************************************************************   
       if isequal(chrome11, chrome22)
          
             parnum = ceil(length(Population{j}{1}) * rand);
%             j
%             parnum
            Population{j}{1}(parnum) = MinParValue + (MaxParValue - MinParValue) * rand;
            A=zeros(Number_Turb,2);
          k = 1;
          for i =1:Number_Turb
             A(i,1) = Population{j}{1}(k);
             A(i,2) =Population{j}{1}(k+1);
             PositionMatrix{j}{1}(i,:) = [A(i,1), A(i,2)];
             k = k + 2;  
          end
            Population = CostFunction(Population,PositionMatrix,Farm_Radius);
        
         
        
            



%****************************************************************************************************************************
       end
    end
end