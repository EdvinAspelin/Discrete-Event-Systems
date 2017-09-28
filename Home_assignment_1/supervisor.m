function S = supervisor(P,Sp,Sigma_u)
%SUPERVISOR This function returns a supervisor S, given a plant,
%specification and uncontrollable events.
%   P is the plant which we want to control
%   Sp is the specification of P
%   Sigma_u is uncontrollable events
%   returns S, which is the supervis
% 
% S = synch(P,Sp);
% 
% fEvents = [];
% uTrans = filter_trans_by_event(S.trans, Sigma_u); % (trans, events)
% uuTrans = filter_trans_by_target(S.trans, uTrans(1,:)); % All trans with uncontrollable target
% uStates = uuTrans(1,:);
% S.trans = S.trans\uuTrans; % Remove trans with uncontrollable target
% S.states = S.states\uStates; % Remove uncontrollable states
sTemp = synch(P,Sp);
uTrans = filter_trans_by_events(sTemp.trans, Sigma_u);
Qx = uTrans(1,:);

X = []; k=1;            % X should be a cell array, were every row is the
X(k) = Qx;              % union with Qpp. When Qpp no longer finds new
k=k+1;                  % states, we settled.
while X(k) ~= X(k-1)    %
    Qp = coreach(sTemp.marked, sTemp.trans, X(k-1));
    Qpp = coreach(sTemp.marked\Qp, uTrans, 0);
    for i = 1:length(Qpp)
        if not(ismember(Qpp(i),X))
            X = [X;
                 Qpp(i)];
        end
    end
    k=k+1;
end
S = sTemp.states\X(k);
