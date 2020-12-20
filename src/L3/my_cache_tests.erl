%%%-------------------------------------------------------------------
%%% @author gregory
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. вер 2020 0:45
%%%-------------------------------------------------------------------
-module(my_cache_tests).
-author("gregory").

%% API
%% Создание таблички с кешем                            ok = my_cache:create().
%% Ключ, Значение, Время жизни записи                   ok = my_cache:insert(Key, Value, 600).
%% Получить значение по ключу,                          {ok, Value} = my_cache:lookup(Key)
%% должна доставать только НЕ устаревшие данные
%% Очистка утстаревших данных                           ok = my_cache:delete_obsolete()
%% cd("d:/IT/JAVA/Git/git-repo/erlang_trainee/Lesson_1/Erlang_lessons/src/L3/").
-include_lib("eunit/include/eunit.hrl").
-define(_assertMatch, macro_body).
-define(_assertEqual, macro_body).
-define(_assert, macro_body).


ets_test_() ->
  [test_create(),
    test_insert(),
    test_lookup_new_data(),
    test_pause(),
    test_lookup_old_data(),
    test_delete(),
    test_delete_per_time()].

test_pause() ->
  ?_assertEqual(ok, my_cache:pause(4)).

test_create() ->
  ?_assertEqual(table_cache, my_cache:create()).

test_insert() ->
  [?_assert(my_cache:insert(1, "Ivanov", 3)),
    ?_assert(my_cache:insert(1, "Petrov", 6000)),
    ?_assert(my_cache:insert(2, "Sidorov", 6000))].

test_lookup_new_data() ->
  [?_assertEqual([{ok,"Sidorov"}], my_cache:lookup(2)),
    ?_assertEqual([{ok,"Ivanov"},{ok,"Petrov"}], my_cache:lookup(1))].

test_lookup_old_data() ->
  [?_assertEqual([{ok,"Petrov"}], my_cache:lookup(1)),
    ?_assertEqual([["Ivanov",3],["Petrov",6000]], ets:match(table_cache,{1,'$1','$2','_'}))].

test_delete() ->
  [?_assert(1 == my_cache:delete_obsolete()),
    ?_assertEqual([["Petrov",6000]], ets:match(table_cache,{1,'$1','$2','_'}))].

test_delete_per_time() ->
  ?_assertMatch({ok,_}, my_cache:delete_obsolete_per_time(30)).