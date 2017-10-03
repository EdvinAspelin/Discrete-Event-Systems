function reach_states = reach(start_states, trans, forbidden)
% Returns the forward reachable states of a transition set
reach_states = [start_states.']; % Initiate reachable cell array
Qx = forbidden; % Array of forbidden states
if size(Qx) == [0 0]
   Qx = {''}; 
end
i = 1;
while i <= max(size(reach_states(:,1))) % Step through reachable queue
    reach_temp = filter_trans_by_source(trans, reach_states(i,1));
    target_states = reach_temp(:,3);
    for j = 1:length(target_states);
        if not(ismember(target_states(j),reach_states));
            reach_states = [reach_states;           % Checks if the target state already is part of reachable
                            target_states(j)];      % or if it is a forbidden state, acts accordingly
        end
    end
    i = i+1;
end