domains
    list = integer*


predicates
    % Список полей имеющихся косточек, значение поля косточки,
    % значение поля косточки, список полей после взятия косточки
    nondeterm take(list, int, int, list).
    %  Список полей, сумма этих полей
    nondeterm sum_lst(list, int).
    % Число, квадрат этого числа
    nondeterm square(int, int).
    % Исходный список костяшек; следующие семь списков - строки получившейся пирамиды
    nondeterm pyramid(list, list, list, list, list, list, list, list).

clauses
%  Условия завершения рекурсии в следующем правиле, когда элементы A и B
% оказываются первыми в списке  L 
take([A, B | L], A, B, L).
take([A, B | L], B, A, L).
% Правило берет элементы A и B из списка L и составляет список L1
% без этих элементов
take([C, D | L], A, B, [C, D | L1]):-
    take(L, A, B, L1).
    
%  Правило суммирует элементы списка 
sum_lst([ ] ,0 ). 
sum_lst([H | T], S):-
    sum_lst(T, S1), 
    S = H + S1.

square(2,4). square(3,9). square(4,16). 
square(5,25). square(7,49).

% Правило заполняет строчки пирамиды, последовательно беря значения
% для полей косточек, входящих в строчки, из списка значений полей всех
% косточек, уменьшая при этом используемый список значений полей.

% Также суммирует значения всех полей для каждой строчки
% и проверяет соответствие этих сумм точному квадрату.
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

goal
    % Исходный список, полный набор костяшек 
    Domino=[0, 0, 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 
            1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6,  
            2, 2, 2, 3, 2, 4, 2, 5, 2, 6, 
            3, 3, 3, 4, 3, 5, 3, 6, 
            4, 4, 4, 5, 4, 6,  
            5, 5, 5, 6,  
            6, 6 ],  
            
    pyramid(Domino, Str1, Str2, Str3, Str4, Str5, Str6, Str7),
    
    write(Str7), nl, write(Str6), nl,
    write(Str5), nl, write(Str4), nl,
    write(Str3), nl, write(Str2), nl,
    write(Str1), nl, exit.
