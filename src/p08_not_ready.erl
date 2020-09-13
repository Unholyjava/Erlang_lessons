%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 23:12
%%%-------------------------------------------------------------------
-module(p08_not_ready).
-author("gregory").

%% API
%% p08:compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%% [a,b,c,a,d,e
-export([compress/1]).


compress(List) ->
  compress(List, []).

compress([], List_out) ->
  List_out;
compress([H|T], List_out) ->
  compress(T, [H|List_out]).
compress([H|T], List_out) -> T == T1 ->
compress([T|T1], [List_out]).