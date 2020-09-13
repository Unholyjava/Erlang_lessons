%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. вер 2020 19:03
%%%-------------------------------------------------------------------
-module(p01).
-author("gregory").

%% API
-export([last/1]).

last([Element]) ->
  Element;
last([_|Element]) ->
  last(Element).