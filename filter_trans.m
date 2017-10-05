function filtered_trans = filter_trans(trans, elems_to_keep, column)
% filter_trans  Returns subset of transitions based on set of events, source or target states
    filtered_trans = trans(ismember(trans(:, column), elems_to_keep), :);
