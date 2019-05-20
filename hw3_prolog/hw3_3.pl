%if path(A,B) true -> A,B are reachable
path(A,B) :- 
	reachable(A,B,[]);
	A =:= B.
reachable(A,B,VISITED_LIST):-
	%find X
	edge(A,X),
	%if X has not visited
	not(member(X,VISITED_LIST)),
	%if X is another node B->reachable
	(B =:= X;
	%or put X in visited list,and find next node
	 reachable(X,B,[A|VISITED_LIST])
	).

inloop(0).
inloop(NUM_EDGE):-
	read(N1),
	read(N2),
	%set the rule
	assert(edge(N1,N2)),
	assert(edge(N2,N1)),
	N_NUM_EDGE is NUM_EDGE -1,
	inloop(N_NUM_EDGE).

outloop(0).
outloop(NUM_SEARCH):-
	read(N1),
	read(N2),
	(
	%if path->true,output 'yes',path->false, output 'no'
	path(N1,N2)->writeln('Yes');
	writeln('No')
	),
	nl,
	N_NUM_SEARCH is NUM_SEARCH -1,
	outloop(N_NUM_SEARCH).

main :-
	write('Input:'),
	read(_NUM_NODE),
	read(I),
	inloop(I),
	write('Number of Queries'),
	read(J),
	outloop(J),
	halt.
:- initialization(main).

