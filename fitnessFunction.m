function [fitness_value] = fitnessFunction(X)

    no_blades = X(1);
    length_blades = X(2);
%     disp(no_blades);
%     disp(length_blades);
    
    fitness_value= (no_blades+length_blades)*12.3*pi;
    
end