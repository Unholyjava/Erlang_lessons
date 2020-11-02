%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 0:45
%%%-------------------------------------------------------------------
-module(bs01).
-author("gregory").

%% API
%% BinText = <<”Some text”>>.
%% <<”Some Text”>>
%% bs01:first_word(BinText).
%% <<”Some”>>
%% cd("d:/IT/JAVA/Git/git-repo/erlang_trainee/Lesson_1/Erlang_lessons/src/L2/").
-export([first_word/1]).


first_word(Bin_text) ->
  first_word(Bin_text, <<>>).

first_word(<<Symbol, Rest/binary>>, First_Word) ->
  case Symbol =:= $  of
    true -> First_Word;
    false -> first_word(Rest, <<First_Word/binary, Symbol>>)
  end.
