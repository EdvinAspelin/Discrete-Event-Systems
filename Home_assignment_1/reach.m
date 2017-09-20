function reach_states = reach(start_states, trans)
% Returns the forward reachable states of a transition set
reach_states = filter_trans_by_source(trans, start_states); % Initiate reachable cell array
for i = 1:max(size(reach_states(:,1))) % Step through reachable queue
   from_state = reach_states(i,3);
   reach_temp = filter_trans_by_source(trans, from_state); % Check possible next states
   reach_states = [reach_states;reach_temp]; % Add new states to array
   %reachable = unique(reachable,'rows'); % Filter duplicates
end
reach_states = unique(reach_states(:,3)).';