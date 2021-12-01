domains
int = integer
il = int*

predicates
	nondeterm move_horse(int, int, int, int)
	nondeterm outborder(int)
	nondeterm move_rule(int, int)
	nondeterm contain_its(int, int, il)
	nondeterm run(il, il, int)

clauses
%факты о возможных перемещениях
move_rule(2, 1).
move_rule(2, -1).
move_rule(1, 2).
move_rule(1, -2).
move_rule(-1, 2).
move_rule(-1, -2).
move_rule(-2, 1).
move_rule(-2, -1).
%проверка на выход за края доски
outborder(X):- X > 0, X < 9.
contain_its (X, Y, [X, Y | _]).
contain_its (X, Y, [_, _ | Tail]):-
	contain_its (X, Y, Tail).
%сделать ход
move_horse(X, Y, X1, Y1):-
	move_rule(Dx, Dy),
	%запомнить смещение
	X1 = X + Dx,
	Y1 = Y + Dy,
	%проверка на выход за края доски
	outborder(X1),
	outborder(Y1).
run(List, List, 1):- !. %условие окончания рекурсии
run([X, Y | Past], Res, N):-
	move_horse(X, Y, X1, Y1),
	not(contain_its(X1, Y1, Past)),
	N1 = N - 1,
	run([X1, Y1, X, Y | Past], Res, N1).

goal
	run([1,1],Res, 64).
