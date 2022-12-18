T1 = terminale 1
T2 = terminale 2
(terminali aperti con uguale cookie per farli comunicare)

in T1 chiama server:start(nomeNodeTerminal2, nome) il quale fa partire server in T2
T1 chiama {nome, node2}!Messaggio  il quale invia messaggio al server
il messaggio viene stampato in T2
