domains
	strlst = string*
	wgc = wgc(string,strlst,strlst)
	history = wgc*
predicates
	nondeterm member(wgc, history) % ����������� �������������� ������
	nondeterm member(string, strlst)
	nondeterm move(wgc, string) % ����������� ����������� ��������
	initial_state(wgc) % ��������� ���������	
	final_state(wgc) % ������� ���������
	nondeterm update(wgc, string, wgc) % ����� ���������, ����������� �� ���������
	update_boat(string, string) % ��������� ��������������� �����
	nondeterm update_banks(string, string, strlst, strlst, strlst, strlst) % ���������
	nondeterm select(string, strlst, strlst) % ����� ����� ��� ���������
	nondeterm insert(string, strlst, strlst) % ������� ��������
	nondeterm precedes(string, string) %������� � ������ ������� ����������
	legal(wgc) % ������������ ���������
	nondeterm illegal(strlst)
	nondeterm solve_dfs(wgc, history, strlst) % ���������� ������������������ ���������
	start(strlst) % ����� � ����� ������� � �������
clauses
% ����������� �������������� ������
	member(H,[H|_]).
	member(Elem,[_|T]):-
	member(Elem,T).
%��������� � �������� ���������
	initial_state(wgc("����� �� ����� ������.",["����","����","�������"],[])).
	final_state(wgc("����� �� ������ ������.",[],["����","����","�������"])).
%����������� ����������� �������� �� ��������� � ���������
	move(wgc("����� �� ����� ������.",L,R),Cargo):-
	member(Cargo,L).
	move(wgc("����� �� ������ ������.",L,R),Cargo):-
	member(Cargo,R).
	move(wgc(B,L,R),"��� �����").
%����� ���������, ����������� �� ���������
	update(wgc(B,L,R),Cargo,wgc(B1,L1,R1)):-
	update_boat(B,B1),
	update_banks(Cargo,B,L,R,L1,R1).
%��������� ��������������� �����
	update_boat("����� �� ����� ������.","����� �� ������ ������.").
	update_boat("����� �� ������ ������.","����� �� ����� ������.").
%����� ����� ��� ���������
	select(X,[X|T],T).
	select(X,[H|T],[H|D]):-
	select(X,T,D).
%������� ����������
	precedes("����",X).
	precedes(X,"�������").
%������� �������� � ������
	insert(X,[Y|Ys],[X,Y|Ys]):-
	precedes(X,Y).
	insert(X,[Y|Ys],[Y|Zs]):-
	precedes(Y,X),insert(X,Ys,Zs).
	insert(X,[],[X]).
	update_banks("��� �����",B,L,R,L,R).
% ���������
	update_banks(Cargo,"����� �� ����� ������.",L,R,L1,R1):-
	select(Cargo,L,L1),insert(Cargo,R,R1).
	update_banks(Cargo,"����� �� ������ ������.",L,R,L1,R1):-
	select(Cargo,R,R1),insert(Cargo,L,L1).
%������������ ���������
	legal(wgc("����� �� ����� ������.",L,R)):-
	not(illegal(R)).
	legal(wgc("����� �� ������ ������.",L,R)):-
	not(illegal(L)).
	illegal(List):-
	member("����",List),
	member("����",List).
	illegal(List):-
	member("����",List),
	member("�������",List).
%���������� ������������������ ���������
	solve_dfs(State,History,[]):-
	final_state(State).
	solve_dfs(State,History,[Move|Moves]):-
	move(State,Move),
	update(State,Move,State1),
	legal(State1),
	not(member(State1,History)),
	solve_dfs(State1,[State1|History],Moves).
% ����� � ����� ������� � �������
	start(Moves):-
	initial_state(State),
	solve_dfs(State,[State],Moves),!.
goal
	start(Ans).

