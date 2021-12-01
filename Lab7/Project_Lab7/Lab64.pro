predicates
% ������� �������� � ������ ������
    nondeterm set(list, int, list)
% �������������� �����
    nondeterm reverses(list, list, list)
% ������������ ������ ������ �� ���� ��������
% ����� ��������� � ������ ������ ��������� ������� � �������� ����������
    nondeterm making(list, list, int, int, list, list)
% ��������� �������������� ������ ����� �������������� ������ ������
    nondeterm main(list, list, int, list)
    
clauses
set(Old, C, [C | Old]).
    reverses([], L2, L2).

reverses([H1 | T1], L2, L3):-
    reverses(T1, [H1 | L2], L3).

making([], [], _, _, Res, Res):- !.

making([],_, _, _, Res, Res):- !.
	
making([H1 | T1], [], J, N, Res1, New):-
	set(Res1, H1, Res),
	N1 = N + 1, 
	making(T1, [], J, N1, Res, New).

making([H1 | T1], [H2 | T2], J, N, Res1, New):-
    N mod J <> 0,		 % �������� �� ��������������� (false)
    set(Res1, H1, Res),
    N1 = N + 1,
    making(T1, [H2 | T2], J, N1, Res, New).

making([H1 | T1], [H2 | T2], J, N, Res1, New):-
    N mod J = 0, 		% �������� �� ��������������� (false)
    set(Res1, H2, Res),
    N1 = N + 1,
    making([H1 | T1], T2, J, N1, Res, New).

main(List1, List2, J, Final):-
    making(List1, List2, J, 1, [], Result),
    reverses(Result, [], Final).

