game():-
    initial_state(State),
    next_move(State, 0).

%Вывод поля игры
show(State) :-
    get_element(State, 0, SymbA),
    get_element(State, 1, SymbB),
    get_element(State, 2, SymbC),
    get_element(State, 3, SymbD),
    get_element(State, 4, SymbE),
    get_element(State, 5, SymbF),
    get_element(State, 6, SymbG),
    get_element(State, 7, SymbH),
    get_element(State, 8, SymbI),
    symbol_to_numb(SymbA, A),
    symbol_to_numb(SymbB, B),
    symbol_to_numb(SymbC, C),
    symbol_to_numb(SymbD, D),
    symbol_to_numb(SymbE, E),
    symbol_to_numb(SymbF, F),
    symbol_to_numb(SymbG, G),
    symbol_to_numb(SymbH, H),
    symbol_to_numb(SymbI, I),
    writeln("  012"),
    write("0|"),
    write(A),
    write(B),
    writeln(C),
    write("1|"),
    write(D),
    write(E),
    writeln(F),
    write("2|"),
    write(G),
    write(H),
    writeln(I).

%Начальное состояние
initial_state([0,0,0,0,0,0,0,0,0]).

%0 - Незанятое поле
symbol_to_numb(0, ' ').
%1 - крестик
symbol_to_numb(1, 'x').
%2 - нолик
symbol_to_numb(2, 'o').

%Ход игрока
next_move(State, N) :-
    I is (N mod 2), I = 0,
    Symb is 1,
    show(State),
    writeln("Введите номер столбца Вашего хода"),
    read(X),
    writeln("Введите номер строки Вашего хода"),
    read(Y),
    make_move(X, Y, State, Symb, NewState), !,
    not(check_state(NewState)),
    N1 is (N + 1),
    next_move(NewState, N1).

%Следующий ход.
next_move(State, N) :-
    I is (N mod 2), I = 1,
    Symb is 2,
    potential_moves_o(State, X, Y),
    make_move(X, Y, State, Symb, NewState), !,
    not(check_state(NewState)),
    N1 is (N + 1),
    next_move(NewState, N1).

%Выполнение хода
make_move(X, Y, State, Symb, State_next) :-
    if_free_field(X, Y, State),
    N is (Y * 3 + X),
    delete_element(State, N, State1),
    insert_element(State1, Symb, N, State_next).

%Проверка того, что данное поле свободно
if_free_field(X, Y, State) :-
    N is (Y * 3 + X),
    get_element(State, N, A),
    A = 0.

%Проверка того, что победили крестики
check_state(State) :-
    win_x(StateX),
    member(State, [StateX]),
    show(State),
    writeln("Крестики победили"), !.

%Проверка того, что победили нолики
check_state(State) :-
    win_o(StateO),
    member(State, [StateO]),
    show(State),
    writeln("Нолики победили"), !.

%Проверка того, что игра закончилачь ничьей
check_state(State) :-
    not(member(0, State)),
    show(State),
    writeln("Ничья"), !.

%Варианты ситуаций игры когда побеждают крестики
win_x([1,1,1,_,_,_,_,_,_]).
win_x([_,_,_,1,1,1,_,_,_]).
win_x([_,_,_,_,_,_,1,1,1]).
win_x([1,_,_,1,_,_,1,_,_]).
win_x([_,1,_,_,1,_,_,1,_]).
win_x([_,_,1,_,_,1,_,_,1]).
win_x([1,_,_,_,1,_,_,_,1]).
win_x([_,_,1,_,1,_,1,_,_]).

%Варианты ситуаций игры когда побеждают нолики
win_o([2,2,2,_,_,_,_,_,_]).
win_o([_,_,_,2,2,2,_,_,_]).
win_o([_,_,_,_,_,_,2,2,2]).
win_o([2,_,_,2,_,_,2,_,_]).
win_o([_,2,_,_,2,_,_,2,_]).
win_o([_,_,2,_,_,2,_,_,2]).
win_o([2,_,_,_,2,_,_,_,2]).
win_o([_,_,2,_,2,_,2,_,_]).


%Если центр не занят, то занимаем его
potential_moves_o([_, _,_, _, 0, _, _, _, _], 1, 1) :- !.

%Ситуации, при которых, данный ход является выигрышным, занимаем победную позицию.
potential_moves_o([0,2,2,_,_,_,_,_,_], 0, 0) :- !.
potential_moves_o([2,0,2,_,_,_,_,_,_], 1, 0) :- !.
potential_moves_o([2,2,0,_,_,_,_,_,_], 2, 0) :- !.
potential_moves_o([_,_,_,0,2,2,_,_,_], 0, 1) :- !.
potential_moves_o([_,_,_,2,0,2,_,_,_], 1, 1) :- !.
potential_moves_o([_,_,_,2,2,0,_,_,_], 2, 1) :- !.
potential_moves_o([_,_,_,_,_,_,0,2,2], 0, 2) :- !.
potential_moves_o([_,_,_,_,_,_,2,0,2], 1, 2) :- !.
potential_moves_o([_,_,_,_,_,_,2,2,0], 2, 2) :- !.
potential_moves_o([0,_,_,2,_,_,2,_,_], 0, 0) :- !.
potential_moves_o([2,_,_,0,_,_,2,_,_], 0, 1) :- !.
potential_moves_o([2,_,_,2,_,_,0,_,_], 0, 2) :- !.
potential_moves_o([_,0,_,_,2,_,_,2,_], 1, 0) :- !.
potential_moves_o([_,2,_,_,0,_,_,2,_], 1, 1) :- !.
potential_moves_o([_,2,_,_,2,_,_,0,_], 1, 2) :- !.
potential_moves_o([_,_,0,_,_,2,_,_,2], 2, 0) :- !.
potential_moves_o([_,_,2,_,_,0,_,_,2], 2, 1) :- !.
potential_moves_o([_,_,2,_,_,2,_,_,0], 2, 2) :- !.
potential_moves_o([0,_,_,_,2,_,_,_,2], 0, 0) :- !.
potential_moves_o([2,_,_,_,0,_,_,_,2], 1, 1) :- !.
potential_moves_o([2,_,_,_,2,_,_,_,0], 2, 2) :- !.
potential_moves_o([_,_,0,_,2,_,2,_,_], 2, 0) :- !.
potential_moves_o([_,_,2,_,0,_,2,_,_], 1, 1) :- !.
potential_moves_o([_,_,2,_,2,_,0,_,_], 0, 2) :- !.

%Ситуации, в которой нужно предотвратить выигрыш противника
potential_moves_o([0,1,1,_,_,_,_,_,_], 0, 0) :- !.
potential_moves_o([1,0,1,_,_,_,_,_,_], 1, 0) :- !.
potential_moves_o([1,1,0,_,_,_,_,_,_], 2, 0) :- !.
potential_moves_o([_,_,_,0,1,1,_,_,_], 0, 1) :- !.
potential_moves_o([_,_,_,1,0,1,_,_,_], 1, 1) :- !.
potential_moves_o([_,_,_,1,1,0,_,_,_], 2, 1) :- !.
potential_moves_o([_,_,_,_,_,_,0,1,1], 0, 2) :- !.
potential_moves_o([_,_,_,_,_,_,1,0,1], 1, 2) :- !.
potential_moves_o([_,_,_,_,_,_,1,1,0], 2, 2) :- !.
potential_moves_o([0,_,_,1,_,_,1,_,_], 0, 0) :- !.
potential_moves_o([1,_,_,0,_,_,1,_,_], 0, 1) :- !.
potential_moves_o([1,_,_,1,_,_,0,_,_], 0, 2) :- !.
potential_moves_o([_,0,_,_,1,_,_,1,_], 1, 0) :- !.
potential_moves_o([_,1,_,_,0,_,_,1,_], 1, 1) :- !.
potential_moves_o([_,1,_,_,1,_,_,0,_], 1, 2) :- !.
potential_moves_o([_,_,0,_,_,1,_,_,1], 2, 0) :- !.
potential_moves_o([_,_,1,_,_,0,_,_,1], 2, 1) :- !.
potential_moves_o([_,_,1,_,_,1,_,_,0], 2, 2) :- !.
potential_moves_o([0,_,_,_,1,_,_,_,1], 0, 0) :- !.
potential_moves_o([1,_,_,_,0,_,_,_,1], 1, 1) :- !.
potential_moves_o([1,_,_,_,1,_,_,_,0], 2, 2) :- !.
potential_moves_o([_,_,0,_,1,_,1,_,_], 2, 0) :- !.
potential_moves_o([_,_,1,_,0,_,1,_,_], 1, 1) :- !.
potential_moves_o([_,_,1,_,1,_,0,_,_], 0, 2) :- !.

%Если центр занят, то занимает левый правый угол.
potential_moves_o([0, _,_, _, 1, _, _, _, _], 0, 0):- !.

%Если центр заняли мы (o), а игрок занял одну из угловых позиций, то занять следующию позицию
potential_moves_o([0, _, _, _, 2, _, _, _, 1], 0, 0):- !.
potential_moves_o([_, _, 1, _, 2, _, 0, _, _], 0, 2):- !.
potential_moves_o([_, _, 0, _, 2, _, 1, _, _], 2, 0):- !.
potential_moves_o([1, _, _, _, 2, _, _, _, 0], 2, 2):- !.

%В остальных случаях возможны следующие ходы
potential_moves_o(_, 0, 0).
potential_moves_o(_, 0, 2).
potential_moves_o(_, 2, 0).
potential_moves_o(_, 2, 2).
potential_moves_o(_, 0, 1).
potential_moves_o(_, 1, 0).
potential_moves_o(_, 1, 1).
potential_moves_o(_, 1, 2).
potential_moves_o(_, 2, 1).

%Если центр заняли мы (o), а игрок занял одну из угловых позиций
potential_moves_o([0, _, _, _, 2, _, _, _, 1], 0, 0):- !.
potential_moves_o([_, _, 1, _, 2, _, 0, _, _], 0, 2):- !.
potential_moves_o([_, _, 0, _, 2, _, 1, _, _], 2, 0):- !.
potential_moves_o([1, _, _, _, 2, _, _, _, 0], 2, 2):- !.
potential_moves_o([_, 0,_, _, 2, _, _, _, 1], 1, 0) :- !.
potential_moves_o([_, 0,1, _, 2, _, _, _, _], 1, 0) :- !.
potential_moves_o([_, 0,_, _, 2, _, 1, _, _], 1, 0) :- !.
potential_moves_o([1, 0,_, _, 2, _, _, _, _], 1, 0) :- !.

%В остальных случаях возможны следующие ходы
potential_moves_o(_, 0, 0).
potential_moves_o(_, 1, 0).
potential_moves_o(_, 2, 0).
potential_moves_o(_, 1, 0).
potential_moves_o(_, 1, 1).
potential_moves_o(_, 1, 2).
potential_moves_o(_, 2, 0).
potential_moves_o(_, 2, 1).
potential_moves_o(_, 2, 2).

%Получение элемента по индексу
get_element([Head|_], 0, Head).
get_element([_|[Head1|Tail]], N, Element) :-
    N1 is (N - 1),
    get_element([Head1|Tail], N1, Element).

%Вставка элемента по индексу
insert_element([], Element, 0, [Element]).
insert_element([Head|Tail], Element, 0, [Element|[Head|Tail]]).
insert_element([Head|Tail], Element, N, [Head|Tail1]) :-
    N1 is (N-1),
    insert_element(Tail, Element, N1, Tail1) .

%Удаление элемента по индексу
delete_element([_|Tail], 0, Tail).
delete_element([Head|Tail], N, [Head|Tail1]) :-
    N1 is (N - 1),
    delete_element(Tail, N1, Tail1).
