%%%-------------------------------------------------------------------
%%% @author home
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. січ 2021 21:21
%%%-------------------------------------------------------------------
-module(cache_server).
-author("gregory").

%% API
-export([start/0, insert/2, delete_item/2, delete_per_time/1,
  start_link/2, show_items/2, stop/1, loop/0, create/1, delete_obsolete/0]).
-include_lib("stdlib/include/ms_transform.hrl").


start() ->
  io:format("start client_part ~p~n", [self()]),
  spawn(?MODULE, loop, []).

create(Pid) ->
  call(Pid, {create}).

insert(Pid, Item) ->
  call(Pid, {add, Item}).

delete_item(Pid, Key) ->
  call(Pid, {remove, Key}).

delete_per_time(Pid) ->
  call(Pid, {remove_per_time}).

start_link(Pid, [{drop_interval, Drop_Interval}]) ->
  call(Pid, {remove_periodic_per_time, Drop_Interval}).

show_items(Pid, Key) ->
  call(Pid, {read, Key}).

stop(Pid) ->
  Pid ! stop,
  ok.

call(Pid, Msg) ->
  MRef = erlang:monitor(process, Pid),
  Pid ! {Msg, self(), MRef},
  receive
    {reply, MRef, Reply} ->
      erlang:demonitor(MRef, [flush]),
      Reply;
    {'DOWN', MRef, _, _, Reason} ->
      {error, Reason}
  after 2000 ->
    erlang:demonitor(MRef, [flush]),
    no_reply
  end.

loop() ->
  io:format("start cache_server ~p~n", [self()]),
  receive
    {{create}, From, Ref} ->
      io:format("Create table~n"),
      ets:new(table_cache, [bag, public, named_table]),
      From ! {reply, Ref, ok},
      ?MODULE:loop();

    {{add, {Key, Value, T_Life}}, From, Ref} ->
      io:format("Adds ~p into table~n", [{Key, Value, T_Life}]),
      ets:insert(table_cache, {Key, Value, T_Life, erlang:timestamp()}),
      From ! {reply, Ref, ok},
      ?MODULE:loop();

    {{read, Key_Table}, From, Ref} ->
      io:format("Read table, key: ~p~n", [Key_Table]),
      Time_Now = time_now(),
      Reply = ets:select(table_cache, ets:fun2ms(fun({Key_, Value_, T_Life_, {MegaSec,Sec,_}})
        when Key_ =:= Key_Table
          andalso Time_Now - (MegaSec * 1000000 + Sec) =< T_Life_ ->
          {ok, Value_} end)),
      From ! {reply, Ref, Reply},
      ?MODULE:loop();

    {{remove, Key}, From, Ref} -> {Reply} =
        case ets:delete(table_cache, Key) of
          true -> {ok};
          [] -> {error, not_exist}
        end,
      From ! {reply, Ref, Reply},
      ?MODULE:loop();

    {{remove_per_time}, From, Ref} ->
      delete_obsolete(),
      From ! {reply, Ref, ok},
      ?MODULE:loop();

    {{remove_periodic_per_time, Drop_Interval}, From, Ref} ->
      timer:apply_interval(Drop_Interval*1000, ?MODULE, delete_obsolete, []),
      From ! {reply, Ref, ok},
      ?MODULE:loop();

    stop -> ok;
    _Any -> ?MODULE:loop()
  end.

time_now() ->
  {MegaSecNow,SecNow,_MicroSecNow} = erlang:timestamp(),
  MegaSecNow * 1000000 + SecNow.

delete_obsolete() ->
  Time_Now = time_now(),
  ets:select_delete(table_cache, ets:fun2ms(fun({_, _, T_Life, {MegaSec,Sec,_}})
    when Time_Now - (MegaSec * 1000000 + Sec) > T_Life -> true end)),
  io:format("delete overdue items~n").




