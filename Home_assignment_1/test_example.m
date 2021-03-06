% Creates automata P1 and P2

P1 = create_automaton(...
        {'p11','p12'},...       % States
        'p11',...               % Initial state
        {'a', 'b'},...          % Events (Alphabet)
        {'p11', 'a', 'p12';
         'p12', 'b', 'p11'},... % Transitions (source, event, target)
        {'p11','p12'});         % Marked states   
fig(P1, 'P1');
P2 = create_automaton(...
        {'p21','p22'},...       % States
        'p21',...               % Initial state
        {'c', 'd', 'e'},...     % Events (Alphabet)
        {'p21', 'c', 'p22';
         'p22', 'd', 'p21';
         'p22', 'e', 'p21'},... % Transitions (source, event, target)
        {'p21','p22'});         % Marked states
fig(P2, 'P2');
P1P2 = synch(P1,P2);
fig(P1P2,'P1')
%% Petri net
syms p11 p12 p21 p22 s11 s12 s21 s22 t1 t2 t3 t4 t5
P = [p11 p12 p21 p22 s11 s12 s21 s22];
T = [t1 t2 t3 t4 t5];
Ap=[0 1 0 0 0;
    1 0 0 0 0;
    0 0 0 1 1;
    0 0 1 0 0;
    0 0 1 0 0;
    0 1 0 0 0;
    0 0 0 1 0;
    0 0 1 0 0];
Am=[1 0 0 0 0;
    0 1 0 0 0;
    0 0 1 0 0;
    0 0 0 1 1;
    0 1 0 0 0;
    0 0 1 0 0;
    0 0 1 0 0;
    0 0 0 1 0];
m0=[1 0 1 0 1 0 1 0].';

%% 
P1 = create_automaton(...
        {'p11','p12'},...       % States
        'p11',...               % Initial state
        {'a', 'b'},...          % Events (Alphabet)
        {'p11', 'a', 'p12';
         'p12', 'b', 'p11'},... % Transitions (source, event, target)
        {'p11','p12'});         % Marked states   
fig(P1, 'P1');
P2 = create_automaton(...
        {'p21','p22'},...       % States
        'p21',...               % Initial state
        {'c', 'd', 'e'},...     % Events (Alphabet)
        {'p21', 'c', 'p22';
         'p22', 'd', 'p21';
         'p22', 'e', 'p21'},... % Transitions (source, event, target)
        {'p21','p22'});         % Marked states
fig(P2, 'P2');
S1 = create_automaton(...
        {'s11','s12'},...       % States
        's11',...               % Initial state
        {'b', 'c'},...     % Events (Alphabet)
        {'s11', 'b', 's12';
         's12', 'c', 's11'},... % Transitions (source, event, target)
        {'s11'});         % Marked states
S2 = create_automaton(...
        {'s21','s22'},...       % States
        's21',...               % Initial state
        {'c', 'd'},...     % Events (Alphabet)
        {'s21', 'c', 's22';
         's22', 'd', 's21'},... % Transitions (source, event, target)
        {'s21'});         % Marked states

S = synch(synch(P1,P2),synch(S1,S2));
Sc = coreach(S.marked,S.trans);
Sr = reach({S.init},S.trans);
s_states = intersect(Sc,Sr);
S.states = s_states;
fig(S,'P1')