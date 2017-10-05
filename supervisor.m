function S = supervisor(P,Sp,sigma_u)
%SUPERVISOR This function returns a supervisor S, given a plant,
%specification and uncontrollable events.
%   P is the plant which we want to control
%   Sp is the specification of P
%   Sigma_u is uncontrollable events
%   returns S, which is the supervisor
% 
% S = synch(P,Sp);
% 
% fEvents = [];
% uTrans = filter_trans_by_event(S.trans, Sigma_u); % (trans, events)
% uuTrans = filter_trans_by_target(S.trans, uTrans(1,:)); % All trans with uncontrollable target
% uStates = uuTrans(1,:);
% S.trans = S.trans\uuTrans; % Remove trans with uncontrollable target
% S.states = S.states\uStates; % Remove uncontrollable states

S = synch(P,Sp); %synchs our plant and specification
u_trans=get_uncontrollable(sigma_u,S);%gets all uncontrollable transitions
u_states = u_trans(:,1); %get uncontrollable states
c_states = setdiff(S.states,u_states); %get controllable states
temp=c_states;
for i=1:length(c_states)
    if ~(check_controllability(c_states(i),P,Sp,sigma_u))
        temp=setdiff(temp,c_states(i));
     
    end
end
c_states=temp;
S.trans = filter_trans_by_source(S.trans,c_states); %remove uncontrollable trans
u_trans=get_uncontrollable(sigma_u,S);

%S.trans=setdiff(S.trans,u_trans,'rows'); 
%removes all rows that are only included in S.trans but not unctrontrollable_trans
% i.e removes all uncontrollable transitions that lead to a forbidden state

S.forbidden=union(S.forbidden,u_states); %merge forbidden with u_states
S.states = c_states;
S.marked = intersect(S.states.',S.marked);
Qx = S.forbidden;
X = Qx;
Q_temp = {};
%X ={}; k=1;            % X should be a cell array, were every row is the
%X(1,:) = Qx.';              % union with Qpp. When Qpp no longer finds new
%X(2,:) = {''};
%k=k+1;                  % states, we settled.
%while ~(isempty(setdiff((X(k,:)),(X(k-1,:))))) %
while(~isempty(setdiff(X,Q_temp)))
   Q_temp = X;
   Qp = coreach(S.marked, S.trans, Q_temp).';
   Qpp = coreach(setdiff(S.states,Qp), u_trans, '').';
   X = union(X,Qpp);
end
S.forbidden = intersect(X,S.states.');
S.states=setdiff(S.states.',S.forbidden);
S.trans= filter_trans_by_target(S.trans,setdiff(S.states,S.forbidden));
S.trans=filter_trans_by_source(S.trans,S.states);




