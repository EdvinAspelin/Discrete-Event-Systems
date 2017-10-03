function merged_state = merge_state(state1, state2)
% merge_state  Creates a new state label based on two states
    merged_state = [state1 '.' state2];