function newtrans = add_tran(trans, source, event, target)
% add_tran  Adds a transition to a transition set
    new_tran = {source, event, target};
    newtrans = [trans; new_tran];