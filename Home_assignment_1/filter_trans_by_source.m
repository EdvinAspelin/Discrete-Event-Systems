function new_trans = filter_trans_by_source(trans, fromstates)
% filter_trans_by_source  Returns transitions with given source states
    new_trans = filter_trans(trans, fromstates, 1);
