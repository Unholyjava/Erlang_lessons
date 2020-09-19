%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 23:12
%%%-------------------------------------------------------------------
-module(p10).
-author("gregory").

%% API
%% P10 (**) Закодировать список с использованием алгоритма RLE:
%% p10:encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%% [{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]

-export([encode/1]).
-import(p05, [reverse/1]).


encode(List) ->
  reverse(encode(List, [], 1)).

encode([], List_not_double, _) ->
  List_not_double;
encode([H], List_not_double, I) ->
  [{I,H}|List_not_double];
encode([H, H|T], List_not_double, I) ->
  encode([H|T], List_not_double, I + 1);
encode([H, H1|T], List_not_double, I) ->
  encode([H1|T], [{I,H}|List_not_double], 1).