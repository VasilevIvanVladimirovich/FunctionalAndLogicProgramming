predicates
    nondeterm selectionsort(lst, lst)		% алгоритм сортировки прямым выбором
    nondeterm smallest(lst, int, int)		% поиск наименьшего элемент
    nondeterm remove(lst, int, lst)		% удалить элемента из списка

clauses
selectionsort([],[]).
selectionsort([H | T], [Smallest|SortedList]) :-
	smallest(T, H, Smallest),
	remove([H | T], Smallest, NewList), !,
	selectionsort(NewList, SortedList).

smallest([], Smallest,Smallest).
smallest([H | T], CurrSmallest, Smallest) :- 
	H < CurrSmallest, smallest(T, H, Smallest).
smallest([_ | T], CurrSmallest, Smallest) :-
	smallest(T, CurrSmallest, Smallest).

remove([], _, []).
remove([H | T], H, T).
remove([H | T], Element, [H | NewList]) :- 
	remove(T, Element, NewList).
%goal
	%selectionsort([2, 1, 2, 5, 3, 2, 1, 0, 5, 4, 3, 2, 3, 7, 6, 2, 1, 2, 50, 3, 2, 1], Res ).
	%selectionsort([10, 50, 25, 31, -15, -22, 7, 0, 10, 15], Res ).