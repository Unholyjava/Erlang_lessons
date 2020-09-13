%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. вер 2020 19:54
%%%-------------------------------------------------------------------
-module(p02).
-author("gregory").

%% API
-export([but_last/1]).


but_last([Penult, Last]) ->
  [Penult, Last];
but_last([_|Last]) ->
  but_last(Last).