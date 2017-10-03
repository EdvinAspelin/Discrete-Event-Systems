function coreach_states = coreach(start_states, trans, forbidden)
% coreach  Returns the coreachable (backward reachable) states of a transition set

coreach_states = reach(start_states, fliplr(trans), forbidden);
