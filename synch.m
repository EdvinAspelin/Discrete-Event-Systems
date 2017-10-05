function aut1aut2 = synch(aut1, aut2)
% Returns the synchronous composition of two automata
merged_states = cell(length(aut1.states),length(aut2.states));
for i = 1:length(aut1.states)       % Create a matrix of the cross product of the states in aut1 and aut2
    for j = 1:length(aut2.states)   %
        temp_state = merge_state(aut1.states{i},aut2.states{j});
        merged_states{i,j} = temp_state;
    end
end
merged_events = unique([aut1.events,aut2.events]); % Simplify our event array
merged_trans = [aut1.trans; % Create a singe array with all of the transitions
                aut2.trans];
unique_ID = size(merged_states);    % Variable used to step through the whole matrix
trans_map = cell(0,3);              % Map of all transitions
qA_true = [];
qB_true = [];
for i = 1:unique_ID(1)      % Stepping through all states
    for j = 1:unique_ID(2)  %
        q_temp = merged_states{i,j};
        q_middle = (length(q_temp)-1)/2 + 1;
        qA = q_temp(1,1:q_middle-1);
        qB = q_temp(1,q_middle+1:length(q_temp));
        qA_trans = [];
        aSize = size(aut1.trans);
        for k = 1:aSize(1)  % Fetch transitions related to qA
            if strcmp(aut1.trans{k,1},qA)
                qA_trans = [qA_trans;
                            aut1.trans(k,:)];
            end
        end
        qB_trans = [];
        bSize = size(aut2.trans);
        for k = 1:bSize(1)  % Fetch transitions related to qA
            if strcmp(aut2.trans{k,1},qB)
                qB_trans = [qB_trans;
                            aut2.trans(k,:)];
            end
        end
        for eventIndex = 1:length(merged_events)
            event = merged_events{eventIndex};
            if not(isempty(qA_trans))
                qA_true = ismember(event,qA_trans(:,2));
            else
                qB_true = false;
            end
            if not(isempty(qB_trans))
                qB_true = ismember(event,qB_trans(:,2));
            else
                qB_true = false;
            end
            if and(qA_true,qB_true) == true                 %if: Check if sigma is shared, or just included in one
                print = [i,j]
                indexA = strfind([qA_trans{:,2}], event);   %    Compute the transition accordingly.
                indexB = strfind([qB_trans{:,2}], event);
                transIndex = size(trans_map);
                trans_map(end+1,:) = {[qA, '.', qB],[event],[qA_trans{indexA,3},'.',qB_trans{indexB,3}]};
            elseif and(qA_true == true,not(ismember(event,aut2.trans))) 
                indexA = strfind([qA_trans{:,2}], event);
                trans_map(end+1,:) = {[qA, '.', qB],[event], [qA_trans{indexA,3}, '.', qB]};
            elseif and(qB_true == true,not(ismember(event,aut1.trans)))
                indexB = strfind([qB_trans{:,2}], event);
                trans_map(end+1,:) = {[qA, '.', qB],[event], [qA, '.', qB_trans{indexB,3}]};
            end
        end
    end
end
trans_map = sortrows(trans_map);
merged_marked = cell(length(aut1.marked),length(aut2.marked)); % Cross product of marked states
for i = 1:length(aut1.marked)
    for j = 1:length(aut2.marked)
        temp_marked = merge_state(aut1.marked{i},aut2.marked{j});
        merged_marked{i,j} = temp_marked;
    end
end
init_states=merge_state(aut1.init,aut2.init); %merge the initial states
reachable=reach({init_states},trans_map,''); %get the reachable states
coreachable=coreach(merged_marked.',trans_map,''); %get the coreachable states
trans_map=filter_trans_by_source(trans_map,merged_states);
% inboth=intersect(coreachable,reachable) %only for test
merged_forbidden=setdiff(merged_states,intersect(coreachable,reachable)); %Get the difference between 
%the intersect of reachable and coreachable and all states. These are the
%forbidden states due to being blocking or creating deadlocks.

aut1aut2 = create_automaton(... % Finally create new synched automata
        {merged_states{:,:}},...       % States
        merge_state(aut1.init,aut2.init),...               % Initial state
        {merged_events{:,:}},...          % Events (Alphabet)
        trans_map,... % Transitions (source, event, target)
        {merged_marked{:,:}},...        % Marked states
        merged_forbidden);