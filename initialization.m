function [ population ] = initialization(M, N)

for i=1: M
    for j=1: N
        population.Chromosomes(i).Gene(j) = [ round(rand()) ];
    end
    while(sum(population.Chromosomes(i).Gene(:))==0)
        for j=1: N
            population.Chromosomes(i).Gene(j) = [ round(rand()) ];
        end
    end
end


end
