function [ S ] = nonBlocking( P )
%NONBLOCKING a function that adds blocking states to forbidden
%   Gets an automato as input and checks for all blocking states
%   The blocking states are identified by that they are coreachable with a
%   marked state.

% Declare initial variables
S = P;
Qm = S.marked; % Contains all marked states
Qa = S.marked; % Contains all reachable states, is updated in loop
Qx = S.forbidden; % Contains all forbidden states
Q = setdiff(S.states,union(Qm,Qx));

% Iterate through all states
for i = 1:length(Q)
    q = Q(i); % State to check
    Qr = reach(q, S.trans, Qx); % Reachable states from q
    nonBlocking = ismember(Qm,Qr); % Checks if marked is reachable
    nonBlocking = max(nonBlocking);
    
    if max(nonBlocking)
        Qx = union(Qx,q)   % Adds q to forbidden if blocking
    else
        Qa = union(Qa,q); % Adds q to c
    end
end
% Update automata
S.forbidden = Qx;
S.marked = setdiff(Qm,Qx); 

