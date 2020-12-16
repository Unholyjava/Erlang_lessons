%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 0:45
%%%-------------------------------------------------------------------
-module(my_cache).
-author("gregory").

%% API
%% Создание таблички с кешем                            ok = my_cache:create().
%% Ключ, Значение, Время жизни записи                   ok = my_cache:insert(Key, Value, 600).
%% Получить значение по ключу,                          {ok, Value} = my_cache:lookup(Key)
%% должна доставать только НЕ устаревшие данные
%% Очистка утстаревших данных                           ok = my_cache:delete_obsolete()
%% cd("d:/IT/JAVA/Git/git-repo/erlang_trainee/Lesson_1/Erlang_lessons/src/L3/").
-export([create/0, insert/3, lookup/1, delete_obsolete/0]).
-include_lib("stdlib/include/ms_transform.hrl").


create() ->
  ets:new(table_cache, [bag, named_table]).

insert(Key, Value, T_life) ->
  ets:insert(table_cache, {Key, Value, T_life, erlang:timestamp()}).

lookup(Key_Table) ->
  Time_Now = time_now(),
  ets:select(table_cache, ets:fun2ms(fun({Key, Value, T_Life, {MegaSec,Sec,_}})
    when Key =:= Key_Table andalso Time_Now - (MegaSec * 1000000 + Sec) =< T_Life -> {ok, Value} end)).

delete_obsolete() ->
  Time_Now = time_now(),
  ets:select_delete(table_cache, ets:fun2ms(fun({_, _, T_Life, {MegaSec,Sec,_}})
    when Time_Now - (MegaSec * 1000000 + Sec) > T_Life -> true end)).


time_now() ->
  {MegaSecNow,SecNow,_MicroSecNow} = erlang:timestamp(),
  MegaSecNow * 1000000 + SecNow.
