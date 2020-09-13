%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. вер 2020 20:33
%%%-------------------------------------------------------------------
-module(p04).
-author("gregory").

%% API
-export([len/1]).


len(List) ->
  len(List, 0).

len([], N) ->
  N;
len([_|List], N) ->
  len(List, N + 1).
