%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 23:12
%%%-------------------------------------------------------------------
-module(p09).
-author("gregory").

%% API
%% p09:pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%% [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]
-export([pack/1]).


pack(List) ->
 pack(List, []).

pack([], Nested_lists) ->
  Nested_lists;

pack([H,H|T], Nested_lists) ->
  pack([H|T], [H|Nested_lists]);
pack([H|T], Nested_lists) ->
  [[H|Nested_lists]|pack(T, [])].

