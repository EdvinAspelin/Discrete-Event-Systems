function [ bool ] = compare( P1 , P2 )
%COMPARE compares two automatas if they are equal to eachother
%   Two automatas as input
%   Compares the two and checks if the state sets are equal
%   Returns logical 1 (true) if they are equal

bool = false;

if isequal(P1.states , P2.states) % Checks if states are equal
    if isequal(P1.forbidden , P2.forbidden) % Checks if forbidden is equal
        bool = true; % If so: return true
    end
end

end

