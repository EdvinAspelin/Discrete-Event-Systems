function S = supervisor(P,Sp,sigma_u)
%SUPERVISOR This function returns a supervisor S, given a plant,
%specification and uncontrollable events.
%   P is the plant which we want to control
%   Sp is the specification of P
%   Sigma_u is uncontrollable events
%   returns S, which is the supervisor
i = 0
S = synch(P,Sp); % Synchs our plant and specification
while true % Iterate through given steps to create supervisor
    Sb = nonBlocking(S); % Identify blocking states and forbid them
    Sc = control(S,P,Sp,sigma_u); % Identify uncontrollable states and forbid them
    S = Sc; % Update supervisor to match latest change for next loop
    i = i + 1
    if compare(Sb,Sc) % Check if algorithm made any change to the supervisor
       break;         % If not: done!
    end
end