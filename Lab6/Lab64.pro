domains
    int = integer
    list = integer*

predicates
% ??????? ???????? ? ?????? ??????
    nondeterm set(list, int, list)
% ?????????????? ?????
    nondeterm reverse(list, list, list)
% ???????????? ?????? ?????? ?? ???? ????????
% ????? ????????? ? ?????? ?????? ????????? ??????? ? ???????? ??????????
    nondeterm making(list, list, int, int, list, list)
% ????????? ?????????????? ?????? ????? ?????????????? ?????? ??????
    nondeterm main(list, list, int, list)
    
clauses
set(Old, C, [C | Old]).
    reverse([], L2, L2).

reverse([H1 | T1], L2, L3):-
    reverse(T1, [H1 | L2], L3).

making([], [], _, _, Res, Res):- !.

making([],_, _, _, Res, Res):- !.
	
making([H1 | T1], [], J, N, Res1, New):-
	set(Res1, H1, Res),
	N1 = N + 1, 
	making(T1, [], J, N1, Res, New).

making([H1 | T1], [H2 | T2], J, N, Res1, New):-
    N mod J <> 0,		 % ???????? ?? ??????????????? (false)
    set(Res1, H1, Res),
    N1 = N + 1,
    making(T1, [H2 | T2], J, N1, Res, New).

making([H1 | T1], [H2 | T2], J, N, Res1, New):-
    N mod J = 0, 		% ???????? ?? ??????????????? (false)
    set(Res1, H2, Res),
    N1 = N + 1,
    making([H1 | T1], T2, J, N1, Res, New).

main(List1, List2, J, Final):-
    making(List1, List2, J, 1, [], Result),
    reverse(Result, [], Final).

goal
    main([1,2,3,4], [5,6,7,8,9], 2, List).