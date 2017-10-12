%% Create automatas to test
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
%% Test compare
t1 = compare(P1,P1); % Should be true
t2 = compare(P2,P2); %

f = compare(P1,P2); % Should be false

if and(and(t1,t2),~f)
    disp('Compare is working properly!')
else
    disp('Compare is not working properly!')
end
%% Test synch
aut1 = synch(P1,P2); aut2 = synch(S1,S2);
S = synch(aut1,aut2);
fig(S, 'testSynch')
%% Test nonBlocking
P1 = create_automaton(...
        {'p0','p1','p2','p3','p4'},...       % States
        'p0',...               % Initial state
        {'a','b','c','d'},...          % Events (Alphabet)
        {'p0', 'a', 'p1';
         'p0', 'b', 'p2';
         'p1', 'c', 'p3';
         'p2', 'c', 'p3';
         'p2', 'd', 'p4'},... % Transitions (source, event, target)
        {'p3'});         % Marked states   
P2 = create_automaton(...
        {'p0','p1','p2','p3','p4'},...       % States
        'p0',...              % Initial state
        {'a','b','c','d'},... % Events (Alphabet)
        {'p0', 'a', 'p1';
         'p0', 'b', 'p2';
         'p1', 'c', 'p3';
         'p2', 'c', 'p3';
         'p2', 'd', 'p4'},... % Transitions (source, event, target)
        {'p3'},...            % Marked states
        {'p2'});              % Forbidden states
P1 = nonBlocking(P1);
P2 = nonBlocking(P2);
fig(P1, 'testNonBlocking1')
fig(P2, 'testNonBlocking2')
%% Test control
P = create_automaton(...
        {'p0','p1','p2','p3','p4','p5','p6','p7','p8'},...       % States
        'p0',...              % Initial state
        {'a','b'},... % Events (Alphabet)
        {'p0', 'a', 'p1';
         'p1', 'b', 'p2';
         'p2', 'a', 'p3';
         'p2', 'a', 'p4';
         'p3', 'b', 'p5';
         'p4', 'a', 'p5';
         'p4', 'b', 'p6';
         'p5', 'b', 'p7';
         'p5', 'b', 'p8';
         'p6', 'a', 'p8';
         'p6', 'a', 'p0'},... % Transitions (source, event, target)
        {'p0'},...            % Marked states
        {'p7'});              % Forbidden states
P_old = P;
while true
    P = control(P,P,{'b'});
    if compare(P,P_old)
        break;
    end
    P_old = P;
end
fig(P,'testControl')
%% Test Supervisor 1

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
fig(S1,'S1')
S2 = create_automaton(...
        {'s21','s22'},...       % States
        's21',...               % Initial state
        {'c', 'd'},...     % Events (Alphabet)
        {'s21', 'c', 's22';
         's22', 'd', 's21'},... % Transitions (source, event, target)
        {'s21'});         % Marked states
fig(S2,'S2')
sigma_u={'b'};
P=synch(P1,P2);
Sp=synch(S1,S2);
Super = supervisor(P,Sp,sigma_u);
fig(Super,'testSupervisor1');
%% Test Supervisor 2

P1 = create_automaton(...
        {'p1','p2','p3','p4','p5','p6'},...          % States
        'p1',...               % Initial state
        {'a', 'b','c','d'},...          % Events (Alphabet)
        {'p1', 'a', 'p2';
         'p1', 'c', 'p3';
         'p2', 'b', 'p4';
         'p2', 'd', 'p5';
         'p3', 'd', 'p4';
         'p5', 'd', 'p6';
         'p5', 'b', 'p4';},... % Transitions (source, event, target)
        {'p4'});         % Marked states   
%fig(P1, 'P1');
S1 = create_automaton(...
        {'s1','s2','s3','s4','s5'},...       % States
        's1',...               % Initial state
        {'a','b','c','d'},...     % Events (Alphabet)
        {'s1', 'a', 's2';
         's1', 'c', 's3';
         's2', 'b', 's4';
         's2', 'd', 's5';
         's3', 'd', 's4';
         's5', 'b', 's4'},... % Transitions (source, event, target)
        {'s4'});         % Marked states
sigma_u={'d'};
S = supervisor(P1,S1,{'d'});
fig(S,'testSupervisor2')

%% Test game

P1 = create_automaton(...
        {'p1','p2','p3','p4','p5','p6','p7','p8'},...       % States
        'p1',...               % Initial state
        {'a1', 'a2','b1','b2'},...          % Events (Alphabet)
        {'p1', 'a1', 'p2';
         'p1', 'b1', 'p3';
         'p2', 'a2', 'p4';
         'p2', 'b2', 'p5';
         'p3', 'b2', 'p4';
         'p5', 'a1', 'p6';
         'p6', 'a2', 'p4';
         'p6', 'b2', 'p7';
         'p7', 'b2', 'p8'},... % Transitions (source, event, target)
        {'p8'});         % Marked states   
%fig(P1, 'P1');
S1 = create_automaton(...
        {'s1','s2','s3','s4','s5','s6','s7'},...       % States
        's1',...               % Initial state
        {'a1','a2','b1','b2'},...     % Events (Alphabet)
        {'s1', 'a1', 's2';
         's1', 'b1', 's3';
         's2', 'a2', 's4';
         's2', 'b2', 's5';
         's3', 'b2', 's4';
         's5', 'a1', 's6';
         's6', 'a2', 's4';
         's6', 'b2', 's7';},... % Transitions (source, event, target)
        {'s7'});         % Marked states
sigma_u={'b1','b2'};
S = supervisor(P1,S1,sigma_u);
fig(S,'testGame');