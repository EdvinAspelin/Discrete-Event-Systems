function aut1aut2 = synch(aut1, aut2)
% Returns the synchronous composition of two automata

shared12 = filter_trans_by_events(aut1.trans, aut2.trans(:,2)); % (trans, events
shared21 = filter_trans_by_events(aut2.trans, aut1.trans(:,2));
shared_trans = [shared12;shared21];
shared_events = shared_trans(:,2);
shared_states = unique([shared_trans(:,1),shared_trans(:,3)]);
shared_marked = intersect(aut1.marked,aut2.marked);

aut1aut2 = create_automaton(...
        {shared_states},...       % States
        [aut1.init, aut2.init],...               % Initial state
        {shared_events},...     % Events (Alphabet)
        {shared_trans},... % Transitions (source, event, target)
        {shared_marked});         % Marked states

end

