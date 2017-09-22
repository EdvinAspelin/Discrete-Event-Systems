function reach_states = reach(start_states, trans)
% Returns the forward reachable states of a transition set
reach_states = [start_states.']; % Initiate reachable cell array
i = 1;
while i <= max(size(reach_states(:,1))) % Step through reachable queue
    reach_temp = filter_trans_by_source(trans, reach_states(i,:));
    target_states = reach_temp(:,3);
    for j = 1:length(target_states)
        if not(ismember(target_states(j),reach_states))
            reach_states = [reach_states;
                            target_states(j)];
        end
    end
    %reach_states = unique(reach_states)
    i = i+1;
end