%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. вер 2020 20:54
%%%-------------------------------------------------------------------
-module(p05).
-author("gregory").

%% API
-export([reverse/1]).


reverse(List) ->
  reverse(List, []).

reverse([], List_Reverse) ->
  List_Reverse;

reverse([H|T], List_Reverse) ->
  reverse(T, [H|List_Reverse]).