function [ uncontrollable_trans ] = get_uncontrollable(sigma_u,P)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
u_trans=filter_trans_by_events(P.trans,sigma_u);
uncontrollable_trans=filter_trans_by_target(u_trans,P.forbidden);
%returns all uncontrollable transitions that lead to a forbidden state
end

