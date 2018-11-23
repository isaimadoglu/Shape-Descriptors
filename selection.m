function [parent1, parent2]=selection(population)

length_population=length(population.Chromosomes(:));

if any([population.Chromosomes(:).fitness]<0)
    disp(['There are values less than zero']);
    % Fitness scaling   f_scaled=a*f+b
    a=1;
    b=min([population.Chromosomes(:).fitness]);
    b=abs(b);
    
    scaled_fitness=a*[population.Chromosomes(:).fitness]+b +1;
    normalized_fitness = [scaled_fitness] ./ sum([scaled_fitness]);
    
else % No negative fitness values
    if(sum([population.Chromosomes(:).fitness])==0)
        for( i = 1:length([population.Chromosomes(:).fitness]) )
            % set each element to 0
            [population.Chromosomes(i).fitness] = 0;
        end
        normalized_fitness=[(population.Chromosomes(:).fitness)];
    else
        normalized_fitness=[population.Chromosomes(:).fitness] ./ sum([population.Chromosomes(:).fitness]);
    end
end

[sorted_fitness_values, sorted_idx] =sort(normalized_fitness, 'descend');

for i=1:length(population.Chromosomes)
    temp_population.Chromosomes(i).Gene=population.Chromosomes(sorted_idx(i)).Gene;
    temp_population.Chromosomes(i).fitness=population.Chromosomes(sorted_idx(i)).fitness;
    temp_population.Chromosomes(i).normalized_fitness=normalized_fitness(sorted_idx(i));
end

cumsum=zeros(1,length_population);

for i=1:length_population
    for j=i:length_population
        cumsum(i)=cumsum(i)+temp_population.Chromosomes(j).normalized_fitness;
    end
end

% Step 3: to select one of the individuals
R=rand();  % in [0,1]

parent1_idx= length_population;
for i=1:length(cumsum)
    if R>cumsum(i)
        parent1_idx=i-1;
        break;
    end
end

parent2_idx=parent1_idx;

while parent2_idx==parent1_idx
    R=rand();  % in [0,1]
    %    disp(R);
    for i=1 : length(cumsum)
        if R>cumsum(i)
            parent2_idx=i-1;
            %            disp(parent2_idx);
            break;
        end
    end
end

% parent1_idx
% parent2_idx

parent1=temp_population.Chromosomes(parent1_idx);
parent2=temp_population.Chromosomes(parent2_idx);


end

