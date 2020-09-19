%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 23:12
%%%-------------------------------------------------------------------
-module(p08).
-author("gregory").

%% API
%% p08:compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%% [a,b,c,a,d,e]
-export([compress/1]).
-import(p05, [reverse/1]).


compress(List) ->
  reverse(compress(List, [])).

compress([], List_not_double) ->
  List_not_double;
compress([H], List_not_double) ->
  [H|List_not_double];
compress([H, H|T], List_not_double) ->
  compress([H|T], List_not_double);
compress([H, H1|T], List_not_double) ->
  compress([H1|T], [H|List_not_double]).