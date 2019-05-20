%set the rule about tree
ancestor(X,Y) :-
	parent(X,Y).
ancestor(X,Y) :-
	parent(Z,Y),
	ancestor(X,Z).
	%parent(Z,Y).

%find lcb,fix one point and move another until find the lca
lca(MOVE,FIX) :-
	%if two node are same node
	MOVE == FIX -> write('LCA :'),write(MOVE),nl;
	%first ancestor find
	ancestor(MOVE,FIX) -> write('LCA :'),write(MOVE),nl;
	%move one node to its ancestor
	parent(PARENT,MOVE),
	lca(PARENT,FIX).

inloop(0).
inloop(NODE_NUMBER) :-
	NODE_NUMBER > 0,
	read(PARENT),
	read(CHILD),
	%set new rule
	assert(parent(PARENT,CHILD)),
	N_NODE_NUMBER is NODE_NUMBER-1,
	inloop(N_NODE_NUMBER).

outloop(0).
outloop(SEARCH_NUM) :-
	SEARCH_NUM > 0,
	read(NO1),
	read(NO2),
	nl,
	lca(NO1,NO2),
	write('\n'),
	N_SEARCH_NUM is SEARCH_NUM -1,
	outloop(N_SEARCH_NUM).

%main function
main :-
	write('Number of Node:'),
	read(I),
	writeln('Set Relation->"Parent. Child."'),
	inloop(I-1),
	write('Number of Queries '),
	read(J),
	outloop(J),
	halt.
:- initialization(main).
