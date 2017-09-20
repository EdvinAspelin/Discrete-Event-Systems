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
        {'p21','p22','p23'},...       % States
        'p21',...               % Initial state
        {'c', 'd', 'e','f'},...     % Events (Alphabet)
        {'p21', 'c', 'p22';
         'p22', 'd', 'p21';
         'p23', 'f', 'p21';
         'p22', 'e', 'p21'},... % Transitions (source, event, target)
        {'p21','p22'});         % Marked states
fig(P2, 'P2');

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


