-module(worktrack).
%-export([start/0]).
-compile(export_all).
-include("worktrack.hrl").

start() ->
    %% starts the program
    io:format("Starting worktrack ~n"),
    init(). % will be spawn

init() ->
    %% init the process
    ets:new(work, [bag, named_table]),
    main().
    
main() ->
    %% main loop
    Action = prompt("Task (type help for help) > "),
    dispatch(Action),
    main().

dispatch("add") ->
    add();
dispatch("help") ->
    help();
dispatch("all") ->
    display_all();    
dispatch("exit") ->
    exit();
dispatch(Action) ->
    io:format("Unknown action ~p ~n", [Action]).

%% private

add() ->
    %% ask for each field
    ItemName = prompt("Name of the item> "),
    Date = prompt("Date (dd-MM-yyyy)> "),
    WorkTime = prompt("Time worked on> "),
    Item = {item, ItemName, Date, WorkTime},
    add(Item).
    
add(Item) ->
    %% add to storage (dict, file, ets, mnesia ... something like that)
    ets:insert(work, Item).
    
display_all() -> % don't want to display all eventualy
    Work = ets:tab2list(work),
    lists:foreach(fun(W) -> io:format("~p ~n", [W]) end, Work).

help() ->
    throw(notimplemented).
    
exit() ->
    io:format("Exiting"),
    exit(normal).
    
%%% Utils
    
prompt(Prompt) ->
    %% displays prompt and let people type in an answer
    Input = io:get_line(standard_io, Prompt),
    % strip Input from newline
    string:strip(Input, both, $\n).
    
