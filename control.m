function [ S ] = control(S,P,Sp,sigma_u)
%CONTROL Idenifies all uncontrollable states and adds them to forbidden
%   Gets a automata and an uncontrollable language as input. Then finds all
%   uncontrollable transistions that lead to an uncontrollable event and
%   adds the sources as forbidden states in the automata.

Qm = S.marked; % Contains all marked states
Qx = S.forbidden;   % Contains all forbidden states
Qs = setdiff(S.states,Qx); % Contains all states except forbidden states
u = sigma_u; % Uncontrollable events

for i = 1:length(Qs) % Step trough all states
    q = Qs(i);
    qTrans = filter_trans_by_source(S.trans, q); % Get all transitions from q
    qUnctrl = filter_trans_by_events(qTrans, u); % Get all uncontrollable transitions from q
    qForbidden = filter_trans_by_target(qUnctrl, Qx); % Get uncontrollable transitions to forbidden states
    
    % Check if plant can make an uncontrollable transition
    p = q{1};
    p = p(1:ceil(end/2)-1); % Gets the specification state
    pTrans = filter_trans_by_source(P.trans, {p});
    pUnctrl = filter_trans_by_events(pTrans, sigma_u);
    % Check if specification can follow
    s = q{1};
    s = s(ceil(end/2)+1:end); % Gets the specification state
    sTrans = filter_trans_by_source(Sp.trans, {s});
    sUnctrl = filter_trans_by_events(sTrans, sigma_u);
    
    pEvents = unique(pUnctrl(:,2)); % Get unique uncontrollable events from q
    sEvents = unique(sUnctrl(:,2)); % Get unique uncontrollable events that Sp can follow
    
    isCtrl = true;
    for j = 1:length(pEvents)
        if ~ismember(pEvents(j), sEvents)
            isCtrl = false;
            break;
        end
    end
    
    if ~isempty(qForbidden)
        Qx = union(Qx,q);
    elseif ~isCtrl
        Qx = union(Qx,q);
    end
end

% Update automata
S.forbidden = Qx;
S.marked = setdiff(Qm,Qx);

