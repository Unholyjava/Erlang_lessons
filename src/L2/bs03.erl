%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 0:45
%%%-------------------------------------------------------------------
-module(bs03).
-author("gregory").

%% API
%% BinText = <<”Col1-:-Col2-:-Col3-:-Col4-:-Col5”>>.
%% <<”Col1-:-Col2-:-Col3-:-Col4-:-Col5”>>
%% bs03:split(BinText, “-:-”).
%% [<<”Col1”>>, <<”Col2”>>, <<”Col3”>>, <<”Col4”>>, <<”Col5”>>
-export([split/2]).


split(Bin_text, Separator) ->
  split(size_in_BinText(Bin_text, Separator), Separator, <<>>, []).

split(<<_Symbol_Size>>, _Separator, Last_word, Words) ->
  p05:reverse([Last_word|Words]);

split(<<Symbol_Size, Symbols_Sep:Symbol_Size, Rest/binary>>, Separator, Next_word, Words) ->
  case <<Symbols_Sep:Symbol_Size>> =:= list_to_binary(Separator) of
    true -> split_word(<<Symbol_Size, Rest/binary>>, Separator, <<>>, [Next_word|Words]);
    false -> split_word(<<Symbol_Size, Symbols_Sep:Symbol_Size, Rest/binary>>, Separator, Next_word, Words)
  end;

split(<<Symbol_Size, Symbol_Sep_8, Rest/binary>>, Separator, Next_word, Words) ->
  split_word(<<Symbol_Size, Symbol_Sep_8, Rest/binary>>, Separator, Next_word, Words).


split_word(<<Symbol_Size, Symbol, Rest/binary>>, Separator, Next_word, Words) ->
  split(<<Symbol_Size, Rest/binary>>, Separator, <<Next_word/binary, Symbol>>, Words).


symbols_to_size(Separator) ->
  symbols_to_size(Separator, 0).

symbols_to_size([], N) ->
  N*8;
symbols_to_size([_|T], N) ->
  symbols_to_size(T, N + 1).

size_in_BinText(Bin_text, Separator) ->
  <<(symbols_to_size(Separator)), Bin_text/binary>>.
