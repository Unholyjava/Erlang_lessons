%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 23:12
%%%-------------------------------------------------------------------
-module(p15).
-author("gregory").

%% API
%% P15 (**) Написать функцию репликатор
%% всех элементов входящего списка:
%% p15:replicate([a,b,c], 3).
%% [a,a,a,b,b,b,c,c,c]

-export([replicate/2]).


replicate(List, N) ->
  case N > 0 of
    true -> p05:reverse(replicate(List, N, 1, []));
    false -> []
  end.


replicate([], _, _, List_Double) ->
  List_Double;
replicate([H|T], N, N1, List_Double) ->
  case N > 1 of
    true -> replicate([H|T], N - 1, N1 + 1, [H|List_Double]);
    false -> replicate(T, N1, N, [H|List_Double])
  end.


