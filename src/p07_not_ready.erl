%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 0:45
%%%-------------------------------------------------------------------
-module(p07_not_ready).
-author("gregory").

%% API
%% p07:flatten([a,[b,[c,d],e]]).
%% [a,b,c,d,e]
%% cd("d:/IT/JAVA/Git/git-repo/erlang_trainee/1/src/").
-export([flatten/1]).


flatten(List) ->
  flatten(List, []).

flatten([], List) ->
  List;
flatten([H|T], List) ->
  flatten(T, flatten(T, List)).
