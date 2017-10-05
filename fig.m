function [] = fig(automaton, filename_no_ext)
% fig  Generates a png-figure from an automaton.
%   Requires installation of Graphviz (http://www.graphviz.org).
%   Add Graphviz bin folder to the system path.
    if nargin < 2
        filename_no_ext = inputname(1);
    end
    fid = fopen([filename_no_ext '.dot'], 'w');
    fprintf(fid, 'digraph G {\n');
    for state = automaton.forbidden
        fprintf(fid, '\t"%s" [shape=box, color=red];\n', state{1});
    end
    for state = setdiff(automaton.marked,automaton.forbidden)
        fprintf(fid, '\t"%s" [shape=ellipse];\n', state{1});
    end
    for state = setdiff(automaton.states, union(automaton.marked,automaton.forbidden))
        fprintf(fid, '\t"%s" [shape=plaintext];\n', state{1});
    end
    for t = automaton.trans'
        fprintf(fid, '\t"%s" -> "%s" [label="%s"];\n', t{1}, t{3}, t{2});
    end
    fprintf(fid, '\tinit [shape=plaintext, label=""];\n');
    fprintf(fid, '\tinit -> "%s";\n', automaton.init);
    fprintf(fid, '}');
    fclose(fid);
    system(['dot -Tpng ' filename_no_ext '.dot -o ' filename_no_ext '.png']);
    delete([filename_no_ext '.dot']);