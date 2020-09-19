%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. вер 2020 20:08
%%%-------------------------------------------------------------------
-module(p03).
-author("gregory").

%% API
-export([element_at/2]).


element_at([H|_], 1) ->
  H;
element_at([], 1) ->
  undefined;
element_at([_|T], N) when N > 1 ->
  element_at(T, N - 1).