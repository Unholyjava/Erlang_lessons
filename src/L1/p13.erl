%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 23:12
%%%-------------------------------------------------------------------
-module(p13).
-author("gregory").

%% API
%% P13 (**) Написать декодер для стандартного алгоритма RLE:
%% p13:decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]).
%% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

-export([decode/1]).
-import(p05, [reverse/1]).


decode(List) ->
  reverse(decode(List, [])).

decode([], List_decode) ->
  List_decode;
decode([{N,Element}|T], List_decode) ->
  case N > 1 of
    true -> decode([{N-1,Element}|T], [Element|List_decode]);
    false -> decode(T, [Element|List_decode])
  end.