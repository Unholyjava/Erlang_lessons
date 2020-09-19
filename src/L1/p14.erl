%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 23:12
%%%-------------------------------------------------------------------
-module(p14).
-author("gregory").

%% API
%% P14 (*) Написать дубликатор всех элементов входящего списка:
%% p14:duplicate([a,b,c,c,d]).
%% [a,a,b,b,c,c,c,c,d,d

-export([duplicate/1]).


duplicate(List) ->
  p07:flatten([[Element|[Element]] || Element <- List]).

%%duplicate(List) ->
%%  p05:reverse(duplicate(List, [])).
%%
%%duplicate([], List_Double) ->
%%  List_Double;
%%duplicate([H|T], List_Double) ->
%%  duplicate(T, [H|[H|List_Double]]).


