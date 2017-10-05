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
        {'c', 'd', 'e'},...     % Events (Alphabet)
        {'s21', 'c', 's22';
         's22', 'd', 's21'
         's22', 'e', 's21'},... % Transitions (source, event, target)
        {'s21'});         % Marked states

%S = synch(synch(P1,P2),synch(S1,S2)); %only for test
%Sc = coreach(S.marked,S.trans,S.forbidden); %only for test
%Sr = reach({S.init},S.trans,S.forbidden); %only for test
%s_states = intersect(Sc,Sr); %only for test
%% Supervisor creation
clc
P1 = create_automaton(...
        {'p11','p12'},...       % States
        'p11',...               % Initial state
        {'a', 'b'},...          % Events (Alphabet)
        {'p11', 'a', 'p12';
         'p12', 'b', 'p11'},... % Transitions (source, event, target)
        {'p11','p12'});         % Marked states   
%fig(P1, 'P1');
P2 = create_automaton(...
        {'p21','p22'},...       % States
        'p21',...               % Initial state
        {'c', 'd', 'e'},...     % Events (Alphabet)
        {'p21', 'c', 'p22';
         'p22', 'd', 'p21';
         'p22', 'e', 'p21'},... % Transitions (source, event, target)
        {'p21','p22'});         % Marked states
%fig(P2, 'P2');
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
    sigma_u={'b'};
P=synch(P1,P2);
S0=synch(S1,S2);
S3=synch(P,S0);
S = supervisor(P,S0,sigma_u);
fig(S,'P4');
%% Supervisor creation
clc
P1 = create_automaton(...
        {'p1','p2','p3','p4','p5','p6','p7','p8'},...       % States
        'p1',...               % Initial state
        {'a', 'b','c','d'},...          % Events (Alphabet)
        {'p1', 'a', 'p2';
         'p1', 'c', 'p3';
         'p2', 'b', 'p4';
         'p2', 'd', 'p5';
         'p3', 'd', 'p4';
         'p5', 'a', 'p6';
         'p6', 'b', 'p4';
         'p6', 'd', 'p7';
         'p7', 'd', 'p8'},... % Transitions (source, event, target)
        {'p4'});         % Marked states   
%fig(P1, 'P1');
S1 = create_automaton(...
        {'s1','s2','s3','s4','s5','s6','s7'},...       % States
        's1',...               % Initial state
        {'a','b','c','d'},...     % Events (Alphabet)
        {'s1', 'a', 's2';
         's1', 'c', 's3';
         's2', 'b', 's4';
         's2', 'd', 's5';
         's3', 'd', 's4';
         's5', 'a', 's6';
         's6', 'b', 's4';
         's6', 'd', 's7';},... % Transitions (source, event, target)
        {'s4'});         % Marked states
sigma_u={'d'};
S = supervisor(P1,S1,sigma_u);
fig(S,'P4');