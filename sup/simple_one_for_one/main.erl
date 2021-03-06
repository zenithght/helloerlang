-module(main).
-export([start_link/0]).

start_link()->
    io:format("starting app...~n",[]),
    {ok,Supid}=   sup:start_link() ,
    {ok,WorkerPid}=supervisor:start_child(Supid,[" world"]),
    %% sup中init spec是
    %% {worker,start_link,[]}
    %% 所以supervisor:start_child(Supid,[" world"]),
    %% 使用apply(worker,start_link,[] ++[" world"]) 即worker:start_link("world") 因 [] ++["world"] = ["world"]

    erlang:monitor(process,WorkerPid),          %可以监测到worker pid  ,flush()  后Shell got {'DOWN',#Ref<0.0.0.79>,process,<0.49.0>,normal}

    supervisor:start_child(Supid,[" world2"])   %可以启动多个worker ,各个worker 完成自已的任务后自行退出.
        .
