%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 23:12
%%%-------------------------------------------------------------------
-module(p12).
-author("gregory").

%% API
%% P12 (**) Написать декодер для модифицированого алгоритма RLE:
%% p12:decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]).
%% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

-export([decode_modified/1]).
-import(p05, [reverse/1]).


decode_modified(List) ->
  reverse(decode_modified(List, [])).

decode_modified([], List_decode) ->
  List_decode;
decode_modified([{N,Element}|T], List_decode) ->
  case N > 1 of
    true -> decode_modified([{N-1,Element}|T], [Element|List_decode]);
    false -> decode_modified(T, [Element|List_decode])
  end;
decode_modified([H, H1|T], List_decode) ->
  decode_modified([H1|T], [H|List_decode]).