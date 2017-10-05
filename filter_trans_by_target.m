function new_trans = filter_trans_by_target(trans, tostates)
% filter_trans_by_target  Returns transitions with given target states
    new_trans = filter_trans(trans, tostates, 3);
