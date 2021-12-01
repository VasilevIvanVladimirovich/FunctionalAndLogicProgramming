domains
	lst = integer*
	int = integer

predicates
	nondeterm pow (int, int, int)			% ���������� � �������
	nondeterm step (int, int)			% ���������� ����
	nondeterm steps (int, lst, int)			% ���������� �����
	nondeterm size (lst, int)			% ������ ������
	nondeterm reverse (lst, lst, lst)		% ������������� ������
	nondeterm sublist (lst, lst, int, int)		% ����������� ��������� ������� � NUM � ����� STEP
	nondeterm subseq (lst, lst, lst, int, int)	% ������� ��������������������� � ������
	nondeterm ranking (lst, int, lst)		% ������� �������� � ������������� ������������������
	nondeterm insert (lst, lst)			% ���������� ������� ���������
	nondeterm subsort (lst, lst, int, int)		% ���������� ���� ����������������������
	nondeterm shellsort(lst, lst, lst)		% ���������� �����
	nondeterm sort (lst, lst)			% ����� ����������


clauses
pow(A, B, R):-
	R = exp(B * ln(A)).

step(S, Res):-
	trunc(S / 2) * 2 = S,  	%����� ����� �� �����, � � ���� integer
	pow(2, S, P1),
	S2 = S / 2,
	pow(2, S2, P2),
	Res = 9 * P1 - 9 * P2 + 1.
	step(S, Res):-
	NOT(trunc(S / 2) * 2 = S),
	pow(2, S, P1),
	S2 = (S + 1) / 2,
	pow(2, S2, P2),
	Res = 8 * P1 - 6 * P2 + 1.

steps(N, [], MAXS):-
	step(N, S),
	S > MAXS.
	steps(N, [S | T], MAXS):-
	step(N, S),
	S <= MAXS, K = N + 1,
	steps(K, T, MAXS).

size([], 0).
size([_ | T], S):-
	size(T, S1),
	S = S1 + 1.

reverse([], L2, L2).
reverse([H1 | T1], L2, L3):-
	reverse(T1, [H1 | L2], L3).

sublist([], [], _, _).
sublist([H1 | T1], L2, 1, Step):-
	sublist(T1, T2, Step, Step),
	L2 = [H1 | T2].
	sublist([_ | T1], L2, NUM, Step):-
	K = NUM - 1,
	K >= 1,
	sublist(T1, L2, K, Step).

subseq(L1, [], L1, _, _).
subseq([], _, [], _, _).
subseq([_ | T1], [H2 | T2], L3, 1, Step):-
	subseq(T1, T2, L4, Step, Step),
	L3 = [H2 | L4].
subseq([H1 | T1], L2, L3, NUM, Step):-
	K = NUM-1,
	K >= 1,
	subseq(T1, L2, L4, K, Step),
	L3 = [H1 | L4].

subsort([], [], _, _):-!.
subsort(List, List, NOW, Step):-
	NOW > Step, !.

subsort(List, List2, NOW, Step):-
	NOW <= Step,
	sublist(List, Sublist, NOW, Step),		% ����������� ���������
	insert(Sublist, Sublist_sort),
	subseq(List, Sublist_sort, List1, NOW, Step),	% ������� ��������������������� � ������
	K = NOW + 1, subsort(List1, List2, K, Step), !.

ranking([], Hnew, [Hnew]).
ranking([H | T], Hnew, T2):-
	Hnew >= H,
	ranking(T, Hnew, T3),
	T2 = [H | T3].
	ranking([H | T], Hnew, L2):-
	Hnew < H,
	L2 = [Hnew, H | T].

insert([], []).
insert([H | T], Sort):-
	insert(T, Sort1),
	ranking(Sort1, H, Sort).

shellsort(List, List, []).
shellsort(List, Sort, [Steps_H | Steps_T]):-
	subsort(List, List1, 1, Steps_H), 
	shellsort(List1, Sort, Steps_T).

sort(List, Sort):-
	size(List, Size),
	steps(0, Steps_rev, Size),
	reverse(Steps_rev, [], Steps),
	shellsort(List, Sort, Steps).	

goal
	%sort([2, 1, 2, 5, 3, 2, 1, 6, 5, 4, 3, 2, 1, 7, 6, 2, 1, 2, 5, 3, 2, 1], Res ).
	sort([10, 50, 25, 31, -15, -22, 7, 0], Res ).

