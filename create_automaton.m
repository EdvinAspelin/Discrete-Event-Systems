function a = create_automaton(states, init, events, trans, marked, forbidden)
% create_automaton  Constructor for automata
    a.states = states;
    a.init = init;
    a.events = events;
    a.trans = trans;
    if nargin > 4
        a.marked = marked;
    else
        a.marked = states;
    end
    if nargin > 5
        a.forbidden = forbidden;
    else
        a.forbidden = {};
    end