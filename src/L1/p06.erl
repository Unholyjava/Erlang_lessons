%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. вер 2020 23:22
%%%-------------------------------------------------------------------
-module(p06).
-author("gregory").

%% API
-export([is_palindrome/1]).
-import(p05, [reverse/1]).


is_palindrome(List) ->
  reverse(List) =:= List.