%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 0:45
%%%-------------------------------------------------------------------
-module(p07).
-author("gregory").

%% API
%% p07:flatten([a,[b,[c,d],e]]).
%% [a,b,c,d,e]
%% cd("d:/IT/JAVA/Git/git-repo/erlang_trainee/Lesson_1/Erlang_lessons/src/L1/").
-export([flatten/1]).
-import(p05, [reverse/1]).


flatten(List) ->
  reverse(flatten(List, [])).

flatten([], List) ->
  List;
flatten([H|T], List) ->
  case is_list(H) of
    true -> flatten(T, flatten(H, List));
    false -> flatten(T, [H|List])
  end.
