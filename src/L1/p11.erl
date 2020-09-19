%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 23:12
%%%-------------------------------------------------------------------
-module(p11).
-author("gregory").

%% API
%% P11 (**) Закодировать список с использованием модифицированого алгоритма RLE:
%%  p11:encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%%  [{4,a},b,{2,c},{2,a},d,{4,e}

-export([encode_modified/1]).
-import(p05, [reverse/1]).


encode_modified(List) ->
  reverse(encode_modified(List, [], 1)).

encode_modified([], List_not_double, _) ->
  List_not_double;
encode_modified([H], List_not_double, I) ->
  case I > 1 of
    true -> [{I,H}|List_not_double];
    false -> [H|List_not_double]
  end;
encode_modified([H, H|T], List_not_double, I) ->
  encode_modified([H|T], List_not_double, I + 1);
encode_modified([H, H1|T], List_not_double, I) ->
  case I > 1 of
    true -> encode_modified([H1|T], [{I,H}|List_not_double], 1);
    false -> encode_modified([H1|T], [H|List_not_double], 1)
  end.