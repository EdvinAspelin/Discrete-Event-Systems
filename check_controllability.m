function [ bool ] = check_controllability(state,P,Sp,sigma_u)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

P_check =false;
Sp_check = false;
state=state{1};
P_state{1}=state(1:(length(state)-1)/2);
Sp_state{1}=state(((length(state)+3)/2):length(state));
bool=true;
P_trans=filter_trans_by_events(P.trans,sigma_u);
Sp_trans=filter_trans_by_events(Sp.trans,sigma_u);
P_trans=filter_trans_by_source(P_trans,P_state);
Sp_trans=filter_trans_by_source(Sp_trans,Sp_state);
P_check=isempty(P_trans);
Sp_check=isempty(Sp_trans);
if and(~P_check, Sp_check)
    bool=false;
    return;
end


end

