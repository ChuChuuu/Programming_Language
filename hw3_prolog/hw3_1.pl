%to examine is a prime or not
is_prime(2).
is_prime(N) :- 
	N mod 2 =\= 0, is_prime(N,3).%test next number
is_prime(N,TEST) :- %if no number can mode N,except N and 1,means it is a prime
	N =:= TEST.
%test + 1
is_prime(N,TEST) :-
	N > TEST,
	N mod TEST =\= 0,
	TEST2 is TEST + 1,
	is_prime(N,TEST2).
%find next prime number
next_prime(NOW,NEXT) :-
	NEXT is NOW +2,
	is_prime(NEXT),
	!.
%if NEXT is not prime than do this in order to find next number+2
next_prime(NOW,NEXT) :-
	TEMP is NOW +2,
	next_prime(TEMP,NEXT).

goldbach(4,[2,2]).
goldbach(INPUT,OUTPUT) :-
	%Input larger than 2 and it is a even number.
	INPUT > 3,
	INPUT mod 2 =:= 0,
	goldbach(INPUT,OUTPUT,3).

%to examine the combination is goldbach or not
goldbach(INPUT,[PRIME,O2],PRIME) :-
	O2 is INPUT - PRIME,
	%if now prime larger than input/2,means it has occur.
	PRIME =< INPUT/2,
	%to check if input - prime number is a prime number or not
	is_prime(O2),
	writeln([PRIME,O2]),
	fail.

goldbach(INPUT,OUTPUT,PRIME):-
	INPUT > PRIME,
	next_prime(PRIME,N_PRIME),
	goldbach(INPUT,OUTPUT,N_PRIME).

%main function
main :-
	write('Input : '),
	read(IN),
	writeln('Output:'),
	(
	 not(goldbach(IN,_L));
	(IN =:= 4)->writeln([2,2])
	),
	halt.

%enter point
:- initialization(main).
