function aut1aut2 = synch(aut1, aut2)
% Returns the synchronous composition of two automata
merged_states = cell(length(aut1.states),length(aut2.states));
for i = 1:length(aut1.states)
    for j = 1:length(aut2.states)
        temp_state = merge_state(aut1.states{i},aut2.states{j});
        merged_states{i,j} = temp_state;
    end
end
merged_forbidden = cell(length(aut1.forbidden),length(aut2.forbidden));
for i = 1:length(aut1.forbidden)
    for j = 1:length(aut2.forbidden)
        temp_forbidden = merge_state(aut1.forbidden{i},aut2.forbidden{j});
        merged_forbidden{i,j} = temp_forbidden;
    end
end
merged_events = unique([aut1.events,aut2.events]);
merged_trans = [aut1.trans;
                aut2.trans];
unique_ID = size(merged_states);
trans_map = cell(0,3);
qA_true = [];
qB_true = [];
for i = 1:unique_ID(1)
    for j = 1:unique_ID(2)
        q_temp = merged_states{i,j};
        q_middle = (length(q_temp)-1)/2 + 1;
        qA = q_temp(1,1:q_middle-1);
        qB = q_temp(1,q_middle+1:length(q_temp));
        qA_trans = [];
        aSize = size(aut1.trans);
        for k = 1:aSize(1)
            if strcmp(aut1.trans{k,1},qA)
                qA_trans = [qA_trans;
                            aut1.trans(k,:)];
            end
        end
        qB_trans = [];
        bSize = size(aut2.trans);
        for k = 1:bSize(1)
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
            if and(qA_true,qB_true) == true
                indexA = strfind([qA_trans{:,2}], event);
                indexB = strfind([qB_trans{:,2}], event);
                transIndex = size(trans_map);
                %if not(and(ismember(qA_trans{indexA,3},aut1.forbidden),ismember(qB_trans{indexB,3},aut2.forbidden)))
                    trans_map(end+1,:) = {[qA, '.', qB],[event],[qA_trans{indexA,3},'.',qB_trans{indexB,3}]};
                %end
            elseif and(qA_true == true,not(ismember(event,aut2.trans))) 
                indexA = strfind([qA_trans{:,2}], event);
                %if not(ismember(qA_trans{indexA,3},aut1.forbidden))
                    trans_map(end+1,:) = {[qA, '.', qB],[event], [qA_trans{indexA,3}, '.', qB]};
                %end
            elseif and(qB_true == true,not(ismember(event,aut1.trans)))
                indexB = strfind([qB_trans{:,2}], event);
                %if ismember(qB_trans{indexB,3},aut2.forbidden)
                    trans_map(end+1,:) = {[qA, '.', qB],[event], [qA, '.', qB_trans{indexB,3}]};
                %end
            end
        end
    end
end
trans_map = sortrows(trans_map);
merged_marked = cell(length(aut1.marked),length(aut2.marked));
for i = 1:length(aut1.marked)
    for j = 1:length(aut2.marked)
        temp_marked = merge_state(aut1.marked{i},aut2.marked{j});
        merged_marked{i,j} = temp_marked;
    end
end
aut1aut2 = create_automaton(...
        {merged_states{:,:}},...       % States
        merge_state(aut1.init,aut2.init),...               % Initial state
        {merged_events{:,:}},...          % Events (Alphabet)
        trans_map,... % Transitions (source, event, target)
        {merged_marked{:,:}});         % Marked states