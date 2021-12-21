:- use_module(library(pce)).

% Запуск окна меню
menu():-
    new(Main, dialog('Меню')),
    new(Shell, button('Сортировка Шелла', message(@prolog, shell_win))),
    new(Bubble, button('Сортировка прямым выбором', message(@prolog, selection_win))),
    new(Domino, button('Задача "Пирамида из домино"', message(@prolog, domino_result))),
    new(Inser, button('Включение в список элементов другого списка', message(@prolog, insert_win))),
    new(Exit, button('Выход', message(Main, destroy))),
    send(Main, append, Shell),
    send(Main, append, Bubble, below),
    send(Main, append, Domino, below),
    send(Main, append, Inser, below),
    send(Main, append, Exit, below),
    send(Main, open).

% Запуск окна сортировки Шелла
shell_win() :-
    new(Shell, dialog('Сортировка Шелла')),
    new(List, text_item('Список')),
    new(ButtonSort,button('Сортировать', message(@prolog, shell_result, List))),
    send(Shell, append, List),
    send(Shell, append, ButtonSort),
    send(Shell, open).

%Сортировка введенного списка и вывод результата в новое окно.
shell_result(L) :-
    get(L, value, L1),
    new(Dialog, dialog("Отсортированный список")),
    new(F, text("Отсортированный список")),
    new(B, button(" ")),
    send(Dialog, append, F),
    send(Dialog, append, B),
    send(Dialog, open),
    (L1 \= '',
    (split_string(L1, " ", "", LTemp),
    convert(LTemp, ListToSort),
    shell_sort(ListToSort, Result),
    p(Result, ResultStr),
    send(B, name, ResultStr));
    (send(B, name, " "))).

% Запуск окна сортировки прямым выбором
selection_win() :-
   new(Bubble, dialog('Сортировка прямым выбором')),
   new(List1, text_item('Список')),
   new(ButtonSort1,button('Сортировать', message(@prolog, selection_result, List1))),
   send(Bubble, append, List1),
   send(Bubble, append, ButtonSort1),
   send(Bubble, open).

%Сортировка введенного списка и вывод результата в новое окно.
selection_result(L) :-
    get(L, value, L1),
    new(Dialog1, dialog("Отсортированный список")),
    new(F1, text("Отсортированный список")),
    new(B1, button(" ")),
    send(Dialog1, append, F1),
    send(Dialog1, append, B1),
    send(Dialog1, open),
    (L1 \= '',
    (split_string(L1, " ", "", LTemp),
    convert(LTemp, ListToSort),
    selection_sort(ListToSort, Result),
    p(Result, ResultStr),
    send(B1, name, ResultStr));
    (send(B1, name, " "))).

% Запуск окна-результа для решения задачи "Пирамида из домино"
domino_result() :-
    get_answer(Str1, Str2, Str3, Str4, Str5, Str6, Str7),
    new(Dialog2, dialog("Решение задачи")),
    new(F2, text("Решение задачи")),
    new(B27, button(" ")),
    new(B26, button(" ")),
    new(B25, button(" ")),
    new(B24, button(" ")),
    new(B23, button(" ")),
    new(B22, button(" ")),
    new(B21, button(" ")),

    send(Dialog2, append, F2),
    send(Dialog2, append, B27, below),
    send(Dialog2, append, B26, below),
    send(Dialog2, append, B25, below),
    send(Dialog2, append, B24, below),
    send(Dialog2, append, B23, below),
    send(Dialog2, append, B22, below),
    send(Dialog2, append, B21, below),
    send(Dialog2, open),

    p(Str7, ResultStr7),
    p(Str6, ResultStr6),
    p(Str5, ResultStr5),
    p(Str4, ResultStr4),
    p(Str3, ResultStr3),
    p(Str2, ResultStr2),
    p(Str1, ResultStr1),

    send(B27, name, ResultStr7),
    send(B26, name, ResultStr6),
    send(B25, name, ResultStr5),
    send(B24, name, ResultStr4),
    send(B23, name, ResultStr3),
    send(B22, name, ResultStr2),
    send(B21, name, ResultStr1).

% Запуск окна "Вставка подсписка в список".
insert_win() :-
    new(Rever, dialog('Включение в список элементов другого списка')),
    new(List2, text_item('Исходный список')),
    new(SubList, text_item('Список')),
    new(Dig2, text_item('I')),
    new(ButtonAnswer,button('Изменить список', message(@prolog, insert_result, List2, SubList, Dig2))),
    send(Rever, append, List2),
    send(Rever, append, SubList),
    send(Rever, append, Dig2),
    send(Rever, append, ButtonAnswer),
    send(Rever, open).

%Запуск окна-результата задания 4.
insert_result(L, S, I) :-
    get(L, value, L1),
    new(Dialog3, dialog("Новый список")),
    new(F3, text("Новый список")),
    new(B3, button(" ")),
    send(Dialog3, append, F3),
    send(Dialog3, append, B3),
    send(Dialog3, open),
    get(I, value, I1),
    atom_number(I1, IRes),
    (L1 \= '',
    (split_string(L1, " ", "", LTemp),
    convert(LTemp, ListToWork),
    get(S, value, S1),
    (S1 \= '',
    (split_string(S1, " ", "", STemp),
    convert(STemp, SubListToWork),
    main(ListToWork, SubListToWork, IRes, Result),
    p(Result, ResultStr),
    send(B3, name, ResultStr));
    (main(ListToWork, [], IRes, Result),
    p(Result, ResultStr),
    send(B3, name, ResultStr))));
    (send(B3, name, " "))).

%Сортировка Шелла
%Пустой список
shell_sort([], []).
%Список из одного элемента
shell_sort([H], [H]).
shell_sort([H, H1|Tail], [H1, H]) :-
    length([H, H1|Tail], Length),
    Length = 2,
    H1 < H.
%Сортировка Шелла
shell_sort(List, Result) :-
    get_steps(List, Steps),
    shell_sort_steps(List, Steps, Result).

%Получение списка шагов
get_steps(List, Result) :-
    length_list(List, Length),
    get_steps_temp(Length, Result, [], 1, 1).
get_steps_temp(Length, Result, Result, _, Element) :-
    (Element * 3) > Length.
get_steps_temp(Length, Result, List, N, Element) :-
    get_step(N, Element1),
    N1 is (N + 1),
    insert_element_in_list(List, Element, 0, List3),
    get_steps_temp(Length, Result, List3, N1, Element1).

%Значение одного шага по методу Р. Седжвика
get_step(N, Result) :-
    get_step_temp(1, Result, 0, N).
get_step_temp(0, Result, Result, _).
get_step_temp(Length, Result, 0, N) :-
     Y is (N mod 2),
     Y = 1,
     pow_element(2, N, Result1),
     N3 is ((N+1) div 2),
     pow_element(2, N3, Result2),
     H is (8 * Result1 - 6 * Result2 + 1),
     Length1 is (Length - 1),
     get_step_temp(Length1, Result, H, N).
get_step_temp(Length, Result, 0, N) :-
     Y is (N mod 2),
     Y = 0,
     pow_element(2, N, Result1),
     N3 is (N div 2),
     pow_element(2, N3, Result2),
     H is (9 * Result1 - 9 * Result2 + 1),
     Length1 is (Length - 1),
     get_step_temp(Length1, Result, H, N).

%Проход по списку шагов
shell_sort_steps(Result, [], Result).
shell_sort_steps(List, [H|T], Result) :-
    shell_sort_step(List, H, List1),
    shell_sort_steps(List1, T, Result).

%Шаг сортировки Шелла
shell_sort_step(List, Step, Result) :-
    shell_sort_step_temp(List, Step, 0, Step, Result).

shell_sort_step_temp(Result, Step, N1, _, Result) :-
length_list(Result, Length),
    Maximum is (N1 + Step),
    Maximum >= Length.
shell_sort_step_temp(List, Step, N1, N2, Result) :-
length_list(List, Length),
    N2 >= Length,
    N3 is (N1 + 1),
    N4 is (N3 + Step),
    shell_sort_step_temp(List, Step, N3, N4, Result).
shell_sort_step_temp(List, Step, N1, N2, Result) :-
    element_n(List, N1, Element1),
    element_n(List, N2, Element2),
    Element1 > Element2,
    swap_elements(List, N1, N2, List1),
    N3 is (N2 + Step),
    shell_sort_step_temp(List1, Step, N1, N3, Result).
shell_sort_step_temp(List, Step, N1, N2, Result) :-
    element_n(List, N1, Element1),
    element_n(List, N2, Element2),
    Element1 =< Element2,
    N3 is (N2 + Step),
    shell_sort_step_temp(List, Step, N1, N3, Result).

%Получить элемент по индексу
element_n([H|_], 0, H).
element_n([_|[H1|T]], N, Element) :-
    N1 is (N - 1),
    element_n([H1|T], N1, Element).

%Вставка элемента в список
insert_element_in_list([], Element, 0, [Element]).
insert_element_in_list([H|T], Element, 0, [Element|[H|T]]).
insert_element_in_list([H|T], Element, N, [H|T1]) :-
    N1 is (N - 1),
    insert_element_in_list(T, Element, N1, T1) .

%Удалить элемент из списка по индексу
delete_element([_|T], 0, T).
delete_element([H|T], N, [H|T1]) :-
    N1 is (N - 1),
    delete_element(T, N1, T1).

%Перестановка элементов
swap_elements(List, N1, N2, NewList) :-
    element_n(List, N1, Element1),
    element_n(List, N2, Element2),
    delete_element(List, N1, List1),
    insert_element_in_list(List1, Element2, N1, List2),
    delete_element(List2, N2, List3),
    insert_element_in_list(List3, Element1, N2, NewList).

%Возвести число в степень
pow_element(Number, Degree, Result) :-
   pow_element_temp(Number, Degree, Result, 0, 1).

pow_element_temp(_, Degree, Result, Degree, Result).
pow_element_temp(Number, Degree, Result, Degree1, Result1) :-
    Degree2 is (Degree1 + 1),
    Result2 is (Result1 * Number),
    pow_element_temp(Number, Degree, Result, Degree2, Result2).

%Длина списка
length_list(List, Length):-
    length_list_temp(List, Length, 0).

length_list_temp([], Length, Length).
length_list_temp([_|T], Length, Length1) :-
    Length2 is (Length1 + 1),
    length_list_temp(T, Length, Length2).

p([]," ").
p([H|T],S):-
    p(T,SS),
    concat(" ",SS,SSS),
    concat(H,SSS,S).

convert([], []).
convert([H|T], [Elm|L]) :-
    atom_number(H, Elm),
    convert(T,L).

%Сортировка пузырьком
%Пустой список
selection_sort([], []).
%Список из одного элемента
selection_sort([H], [H]).
%Сортировка методом прямого выбора
selection_sort(List, SortList):-
  selection_sort(List, [], SortListTemp),
  reverse(SortListTemp, SortList).

selection_sort([], SortList, SortList) :- !.
selection_sort(UnSortPart, SortPart, SortList):-
  min_list(UnSortPart, MinElement),
  delete_single_element(UnSortPart, MinElement, UnSortTail),
  selection_sort(UnSortTail, [MinElement|SortPart], SortList).

%Удаления элемента с заданным значением
delete_single_element(List, Element, ListWithoutElement):-
    select(Element, List, ListWithoutElement), !.


%  Условия завершения рекурсии в следующем правиле, когда элементы A и B
% оказываются первыми в списке  L
take([A, B | L], A, B, L).
take([A, B | L], B, A, L).
% Правило берет элементы A и B из списка L и составляет список L1
% без этих элементов
take([C, D | L], A, B, [C, D | L1]):-
    take(L, A, B, L1).

%  Правило суммирует элементы списка
sum_lst([ ], 0).
sum_lst([H | T], S):-
    sum_lst(T, S1),
    S is (H + S1).

square(2,4). square(3,9). square(4,16).
square(5,25). square(7,49).

% Правило заполняет строчки пирамиды, последовательно беря значения
% для полей косточек, входящих в строчки, из списка значений полей всех
% косточек, уменьшая при этом используемый список значений полей.

% Также суммирует значения всех полей для каждой строчки
% и проверяет соответствие этих сумм точному квадрату.

domino([0, 0, 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6,
            1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6,
            2, 2, 2, 3, 2, 4, 2, 5, 2, 6,
            3, 3, 3, 4, 3, 5, 3, 6,
            4, 4, 4, 5, 4, 6,
            5, 5, 5, 6,
            6, 6 ]).

get_answer(Str1, Str2, Str3, Str4, Str5, Str6, Str7) :-
    domino(D),
    pyramid(D, Str1, Str2, Str3, Str4, Str5, Str6, Str7).



pyramid(D,
    % Str с 1 по 7
    [St1_0, St1_1, St1_1, St1_2, St1_2, St1_3, St1_3, St1_4, St1_4, St1_5, St1_5, St1_6, St1_6, St1_7],
    [St2_0, St2_1, St2_1, St2_2, St2_2, St2_3, St2_3, St2_4, St2_4, St2_5, St2_5, St2_6],
    [St3_0, St3_1, St3_1, St3_2, St3_2, St3_3, St3_3, St3_4, St3_4, St3_5],
    [St4_0, St4_1, St4_1, St4_2, St4_2, St4_3, St4_3, St4_4],
    [St5_0, St5_1, St5_1, St5_2, St5_2, St5_3],
    [St6_0, St6_1, St6_1, St6_2],
    [St7_0, St7_1]):-

    take(D, St1_0, St1_1, D1), take(D1, St1_1, St1_2, D2),
    take(D2, St1_2, St1_3, D3), take(D3, St1_3, St1_4, D4),
    take(D4, St1_4, St1_5, D5), take(D5, St1_5, St1_6, D6),
    take(D6, St1_6, St1_7, D7),
    sum_lst([St1_0, St1_1, St1_1, St1_2, St1_2, St1_3, St1_3, St1_4, St1_4, St1_5, St1_5, St1_6, St1_6, St1_7], S1),
    square(_,S1),

    take(D7, St2_0, St2_1, D8), take(D8, St2_1, St2_2, D9),
    take(D9, St2_2, St2_3, D10), take(D10, St2_3, St2_4, D11),
    take(D11, St2_4, St2_5, D12), take(D12, St2_5, St2_6, D13),
    sum_lst([St2_0, St2_1, St2_1, St2_2, St2_2, St2_3, St2_3, St2_4, St2_4, St2_5, St2_5, St2_6], S2),
    square(_,S2),

    take(D13, St3_0, St3_1, D14), take(D14, St3_1, St3_2, D15),
    take(D15, St3_2, St3_3, D16), take(D16, St3_3, St3_4, D17),
    take(D17, St3_4, St3_5, D18),
    sum_lst([St3_0, St3_1, St3_1, St3_2, St3_2, St3_3,St3_3,St3_4,St3_4,St3_5], S3),
    square(_,S3),

    take(D18, St4_0, St4_1, D19), take(D19, St4_1, St4_2, D20),
    take(D20, St4_2, St4_3, D21), take(D21, St4_3, St4_4, D22),
    sum_lst([St4_0, St4_1, St4_1, St4_2, St4_2, St4_3, St4_3, St4_4], S4),
    square(_,S4),

    take(D22, St5_0, St5_1, D23), take(D23, St5_1, St5_2, D24),
    take(D24, St5_2, St5_3, D25),
    sum_lst([St5_0, St5_1, St5_1, St5_2, St5_2, St5_3], S5),
    square(_,S5),

    take(D25, St6_0, St6_1, D26), take(D26, St6_1, St6_2, D27),
    sum_lst([St6_0, St6_1, St6_1, St6_2],  S6),
    square(_,S6),

    take(D27, St7_0, St7_1, _),
    sum_lst([St7_0, St7_1], S7),
    square(_,S7).


set(Old, C, [C|Old]).

reverse([], L2, L2).
reverse([H1 | T1], L2, L3):-
    reverse(T1, [H1 | L2], L3).

making([], [], _, _, Res, Res).
making([],_, _, _, Res, Res).
making([H1 | T1], [], J, N, Res1, New):-
	set(Res1, H1, Res),
	N1 is (N + 1),
	making(T1, [], J, N1, Res, New).
making([H1 | T1], [H2 | T2], J, N, Res1, New):-
    Check is (N mod J),
    Check \= 0,		 % проверка на целочисленность (false)
    set(Res1, H1, Res),
    N1 is (N + 1),
    making(T1, [H2 | T2], J, N1, Res, New).
making([H1 | T1], [H2 | T2], J, N, Res1, New):-
    Check is (N mod J),
    Check == 0,			% проверка на целочисленность (false)
    set(Res1, H2, Res),
    N1 is (N + 1),
    making([H1 | T1], T2, J, N1, Res, New).

main(List1, List2, J, Final) :-
    making(List1, List2, J, 1, [], Result),
    reverse(Result, [], Final).










