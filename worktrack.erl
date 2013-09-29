-module(worktrack).
-export([start/0]).
-include("worktrack.hrl").

add() ->
    %% ask for each field
    ItemName = prompt("Name of the item: "),
    Date = prompt("Date (dd-MM-yyyy): "),
    WorkTime = prompt("Time worked on: "),
    Item = {item, ItemName, Date, WorkTime},
    add(Item).
    
add(Item) ->
    %% add to storage (dict, file, ets, mnesia ... something like that)
    throw(notimplemented).
    
prompt(Prompt) ->
    %% displays prompt and let people type in an answer
