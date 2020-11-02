%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 0:45
%%%-------------------------------------------------------------------
-module(bs02).
-author("gregory").

%% API
%% BinText = <<”Text with four words”>>.
%% <<”Text with four words”>>
%% bs02:words(BinText).
%% [<<”Text”>>, <<”with”>>, <<”four”>>, <<”words”>>
-export([words/1]).


words(Bin_text) ->
  words(Bin_text, <<>>, []).

words(<<>>, Last_word, Words) ->
  p05:reverse([Last_word|Words]);
words(<<Symbol, Rest/binary>>, Next_word, Words) ->
  case Symbol =:= $  of
    true -> words(Rest, <<>>, [Next_word|Words]);
    false -> words(Rest, <<Next_word/binary, Symbol>>, Words)
  end.