clear all
P1 = create_automaton(...
        {'p11','p12'},...       % States
        'p11',...               % Initial state
        {'a', 'b'},...          % Events (Alphabet)
        {'p11', 'a', 'p12';
         'p12', 'b', 'p11'},... % Transitions (source, event, target)
        {'p11','p12'});         % Marked states   
P2 = create_automaton(...
        {'p21','p22'},...       % States
        'p21',...               % Initial state
        {'c', 'd', 'e'},...     % Events (Alphabet)
        {'p21', 'c', 'p22';
         'p22', 'd', 'p21';
         'p22', 'e', 'p21'},... % Transitions (source, event, target)
        {'p21','p22'});         % Marked states
S1 = create_automaton(...
        {'s11','s12'},...       % States
        's11',...               % Initial state
        {'b', 'c'},...     % Events (Alphabet)
        {'s11', 'b', 's12';
         's12', 'c', 's11'},... % Transitions (source, event, target)
        {'s11','s12'});         % Marked states
S2 = create_automaton(...
        {'s21','s22'},...       % States
        's21',...               % Initial state
        {'c', 'd'},...     % Events (Alphabet)
        {'s21', 'c', 's22';
         's22', 'd', 's21'},... % Transitions (source, event, target)
        {'s21','s22'});         % Marked states
aut1 = synch(P1,P2); aut2 = synch(S1,S2);
S = synch(aut1,aut2);
trans = S.trans;
start_states = S.init;
reach_states = [start_states]; % Initiate reachable cell array
i = 1;
while i <= max(size(reach_states(:,1))) % Step through reachable queue
    reach_temp = filter_trans_by_source(trans, reach_states(i,:));
    target_states = reach_temp(:,3);
    for j = 1:length(target_states)
        if not(ismember(target_states(j),reach_states))
            reach_states = [reach_states;
                            target_states(j)];
        end
    end
    %reach_states = unique(reach_states)
    i = i+1;
end