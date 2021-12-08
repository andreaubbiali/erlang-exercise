% record definitions can be included in
% Erlang source code files or put in files with the extension .hrl , which are then
% included by Erlang source code files).
% Note that file inclusion is the only way to ensure that several Erlang modules
% use the same record definitions. This is similar to the way common definitions
% are defined in .h files in C and included by source code files.

-record(todo, {status=reminder,who=joe,text}).

% rr("records.hrl").                ->>rr = read records

% reminder, joe, undefined sono i valori di default

%se fai nella shell:
% X1 = #todo{status=urgent, text="Fix errata in book"}.
% #todo{status = urgent,who = joe,text = "Fix errata in book"}
%vengono modificati i valori indicati e lasciati invariati i valori di default se non modificati


%#todo{who=W, text=Txt} = X2.           --> pattern matching