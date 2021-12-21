:- use_module(library(pce)).

%Окно старта игры
menu():-
    new(Main, dialog('Крестики-нолики')),
    new(Start,button('Начать игру', message(@prolog, game))),
    new(Exit,button('Выход', message(Main, destroy))),
    send(Main, append, Start),
    send(Main, append, Exit),
    send(Main, open).

%Окно игры
game() :-
    new(Game, dialog('Игра')),
    new(Field1, button('X')),
    new(Field2, button('X')),
    new(Field3, button('X')),
    new(Field4, button('X')),
    new(Field5, button('X')),
    new(Field6, button('X')),
    new(Field7, button('X')),
    new(Field8, button('X')),
    new(Field9, button('X')),

    new(GameButton1,button('1', message(@prolog, change, Field1, Field1, Field2, Field3, Field4, Field5, Field6, Field7, Field8, Field9))),
    new(GameButton2,button('2', message(@prolog, change, Field2, Field1, Field2, Field3, Field4, Field5, Field6, Field7, Field8, Field9))),
    new(GameButton3,button('3', message(@prolog, change, Field3, Field1, Field2, Field3, Field4, Field5, Field6, Field7, Field8, Field9))),
    new(GameButton4,button('4', message(@prolog, change, Field4, Field1, Field2, Field3, Field4, Field5, Field6, Field7, Field8, Field9))),
    new(GameButton5,button('5', message(@prolog, change, Field5, Field1, Field2, Field3, Field4, Field5, Field6, Field7, Field8, Field9))),
    new(GameButton6,button('6', message(@prolog, change, Field6, Field1, Field2, Field3, Field4, Field5, Field6, Field7, Field8, Field9))),
    new(GameButton7,button('7', message(@prolog, change, Field7, Field1, Field2, Field3, Field4, Field5, Field6, Field7, Field8, Field9))),
    new(GameButton8,button('8', message(@prolog, change, Field8, Field1, Field2, Field3, Field4, Field5, Field6, Field7, Field8, Field9))),
    new(GameButton9,button('9', message(@prolog, change, Field9, Field1, Field2, Field3, Field4, Field5, Field6, Field7, Field8, Field9))),

    send(Game, append, Field1),
    send(Game, append, Field2, right),
    send(Game, append, Field3, right),
    send(Game, append, GameButton1, below),
    send(Game, append, GameButton2, right),
    send(Game, append, GameButton3, right),
    send(Game, append, Field4, below),
    send(Game, append, Field5, right),
    send(Game, append, Field6, right),
    send(Game, append, GameButton4, below),
    send(Game, append, GameButton5, right),
    send(Game, append, GameButton6, right),
    send(Game, append, Field7, below),
    send(Game, append, Field8, right),
    send(Game, append, Field9, right),
    send(Game, append, GameButton7, below),
    send(Game, append, GameButton8, right),
    send(Game, append, GameButton9, right),

    send(Game, open),
    game1([Field1, Field2, Field3, Field4, Field5, Field6, Field7, Field8, Field9]).

%Начально состояние
game1(ListField) :-
    change_field(ListField, [0,0,0,0,0,0,0,0,0]).

%0 - Незанятое поле
symbol_to_numb(0, ' ').
%1 - крестик
symbol_to_numb(1, 'X').
%2 - нолик
symbol_to_numb(2, 'O').

%Изменение состояния полей FieldN
change_field(ListField, State) :-
    get_element(State, 0, SymbA),
    get_element(State, 1, SymbB),
    get_element(State, 2, SymbC),
    get_element(State, 3, SymbD),
    get_element(State, 4, SymbE),
    get_element(State, 5, SymbF),
    get_element(State, 6, SymbG),
    get_element(State, 7, SymbH),
    get_element(State, 8, SymbI),
    symbol_to_numb(SymbA, NumbA),
    symbol_to_numb(SymbB, NumbB),
    symbol_to_numb(SymbC, NumbC),
    symbol_to_numb(SymbD, NumbD),
    symbol_to_numb(SymbE, NumbE),
    symbol_to_numb(SymbF, NumbF),
    symbol_to_numb(SymbG, NumbG),
    symbol_to_numb(SymbH, NumbH),
    symbol_to_numb(SymbI, NumbI),
    get_element(ListField, 0, A),
    get_element(ListField, 1, B),
    get_element(ListField, 2, C),
    get_element(ListField, 3, D),
    get_element(ListField, 4, E),
    get_element(ListField, 5, F),
    get_element(ListField, 6, G),
    get_element(ListField, 7, H),
    get_element(ListField, 8, I),
    send(A, name, NumbA),
    send(B, name, NumbB),
    send(C, name, NumbC),
    send(D, name, NumbD),
    send(E, name, NumbE),
    send(F, name, NumbF),
    send(G, name, NumbG),
    send(H, name, NumbH),
    send(I, name, NumbI).

change(X, A, B, C, D, E, F, J, H, I) :-
    get(X, name, X1),
    symbol_to_numb(N, X1),
    N = 0,
    send(X, name, 'X'),
    get_state([A, B, C, D, E, F, J, H, I], State), !,
    not(check(State)),
    Symb is 2,
    potential_moves_o(State, X0, Y0),
    make_move(X0, Y0, State, Symb, NewState), !,
    change_field([A, B, C, D, E, F, J, H, I], NewState),
    not(check(NewState)).

%Получение состояния
get_state(ListField, [A, B, C, D, E, F, G, H, I]) :-
    get_element(ListField, 0, A2),
    get_element(ListField, 1, B2),
    get_element(ListField, 2, C2),
    get_element(ListField, 3, D2),
    get_element(ListField, 4, E2),
    get_element(ListField, 5, F2),
    get_element(ListField, 6, G2),
    get_element(ListField, 7, H2),
    get_element(ListField, 8, I2),
    get(A2, name, A1),
    get(B2, name, B1),
    get(C2, name, C1),
    get(D2, name, D1),
    get(E2, name, E1),
    get(F2, name, F1),
    get(G2, name, G1),
    get(H2, name, H1),
    get(I2, name, I1),
    symbol_to_numb(A, A1),
    symbol_to_numb(B, B1),
    symbol_to_numb(C, C1),
    symbol_to_numb(D, D1),
    symbol_to_numb(E, E1),
    symbol_to_numb(F, F1),
    symbol_to_numb(G, G1),
    symbol_to_numb(H, H1),
    symbol_to_numb(I, I1).


%Выполнение хода
make_move(X, Y, State, Symb, State_next) :-
    is_free(X, Y, State),
    N is Y*3+X,
    delete_element(State, N, State1),
    insert_element(State1, Symb, N, State_next).

%Проверка того, что поле свободно.
is_free(X, Y, State) :-
    N is (Y * 3 + X),
    get_element(State, N, A),
    A = 0.

%Проверка того, что победили крестики
check(State) :-
    win_x(StateX),
    member(State, [StateX]),
    new(Dialog, dialog("Результат")),
    new(F, text("Крестики победили")),
    send(Dialog, append, F),
    send(Dialog, open), !.

%Проверка того, что победили нолики
check(State) :-
    win_o(StateO),
    member(State, [StateO]),
    new(Dialog, dialog("Результат")),
    new(F, text("Нолики победили")),
    send(Dialog, append, F),
    send(Dialog, open), !.

%Проверка того, что игра закончилась ничьей
check(State) :-
    not(member(0, State)),
    new(Dialog, dialog("Ничья")),
    new(F, text("Ничья")),
    send(Dialog, append, F),
    send(Dialog, open),!.

%Варианты ситуаций игры, когда побеждают крестики
win_x([1,1,1,_,_,_,_,_,_]).
win_x([_,_,_,1,1,1,_,_,_]).
win_x([_,_,_,_,_,_,1,1,1]).
win_x([1,_,_,1,_,_,1,_,_]).
win_x([_,1,_,_,1,_,_,1,_]).
win_x([_,_,1,_,_,1,_,_,1]).
win_x([1,_,_,_,1,_,_,_,1]).
win_x([_,_,1,_,1,_,1,_,_]).

%Варианты ситуаций игры, когда побеждают нолики
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

%Ситуация при которой, данный ход является выигрышным
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

%Если центр занят, то занимает левый правый угл.
potential_moves_o([0, _,_, _, 1, _, _, _, _], 0, 0):- !.

%Если центр заняли мы (o), а игрок занял одну из угловых позиций
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

%Получение элемента по индексу
get_element([Head|_], 0, Head).
get_element([_|[Head1|Tail]], N, Element) :-
    N1 is (N - 1),
    get_element([Head1|Tail], N1, Element).

%Вставка элемента по индексу
insert_element([], Element, 0, [Element]).
insert_element([Head|Tail], Element, 0, [Element|[Head|Tail]]).
insert_element([Head|Tail], Element, N, [Head|Tail1]) :-
    (N1 is N - 1),
    insert_element(Tail, Element, N1, Tail1).

%Удаление элемента по индексу
delete_element([_|Tail], 0, Tail).
delete_element([Head|Tail], N, [Head|Tail1]) :-
    N1 is (N - 1),
    delete_element(Tail, N1, Tail1).
