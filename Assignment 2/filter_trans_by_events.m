function new_trans = filter_trans_by_events(trans, events)
% filter_trans_by_events  Returns transitions labeled by given events
    new_trans = filter_trans(trans, events, 2);
