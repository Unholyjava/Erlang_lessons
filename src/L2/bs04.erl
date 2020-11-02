%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 0:45
%%%-------------------------------------------------------------------
-module(bs04).
-author("gregory").

%% API
%% BinXML = <<”<start><item>Text1</item><item>Text2</item></start>”>>.
%% <<”<start><item>Text1</item><item>Text2</item></start>”>>
%% bs04:decode_xml(BinXML).
%% {<<”start”>>, [], [
%%   {<<”item”>>, [], [<<”Text1”>>]},
%%   {<<”item”>>, [], [<<”Text2”>>]}
%% ]}
-export([decode_xml/1]).


decode_xml(Xml) ->
  decode_xml(Xml, {}, <<>>).

decode_xml(<<>>, Xml_decode, _Text) ->
  Xml_decode;

%%decode_xml(<<$>, $<, Rest/binary>>, Xml_decode, Text) ->
  %%decode_xml(Rest, {Xml_decode, Text}, <<>>);
%%decode_xml(<<$<, $/, Rest/binary>>, Xml_decode, Text) ->
  %%close_item(Rest, Xml_decode, Text);

decode_xml(<<Symbol, Rest/binary>>, Xml_decode, Text) ->
  if
    Symbol == $< -> decode_xml(Rest, {Xml_decode, [Text]}, <<>>);
    Symbol == $> -> decode_xml(Rest, {Xml_decode, Text}, <<>>);
    Symbol == $/ -> close_item(Rest, Xml_decode, Text);
    true -> decode_xml(Rest, Xml_decode, <<Text/binary, Symbol>>)
  end.

close_item(<<Symbol, Rest/binary>>, Xml_decode, Text) ->
  if Symbol == $> -> decode_xml(Rest, Xml_decode, Text);
    true -> close_item(Rest, Xml_decode, Text)
  end.

