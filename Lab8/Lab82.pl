% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space

% Your program goes here

move(point(X, Y), point(ToX, ToY)):-
    X >= 2, Y >= 3, ToX is X - 1, ToY is Y - 2; % 1
    X >= 2, Y =< 6, ToX is X - 1, ToY is Y + 2; % 4
    
    X =< 7, Y >= 3, ToX is X + 1, ToY is Y - 2; % 8
    X =< 7, Y =< 6, ToX is X + 1, ToY is Y + 2; % 5
    
    X >= 3, Y >= 2, ToX is X - 2, ToY is Y - 1; % 2
    X >= 3, Y =< 7, ToX is X - 2, ToY is Y + 1; % 3
    
    X =< 6, Y >= 2, ToX is X + 2, ToY is Y - 1; % 7
    X =< 6, Y =< 7, ToX is X + 2, ToY is Y + 1. % 6

solve(Visited, Solution):-
    length(Visited, 64), !, Solution = Visited.
solve([Last|Other], Solution):-
    move(Last, To),
    \+ member(To, Other),
    solve([To, Last|Other], Solution).
