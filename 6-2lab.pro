domains
    file=output
    charlist=char*
predicates
    nondeterm main
    stringinlist(string,charlist)
    glas(char, integer)
    check_str1(integer, string)
    getword(string, string, string, string)
    max(integer, string, integer, string, integer, string)
    process1(string, integer, string) 
    check_equal_ab(string)
clauses
    stringinlist("",[ ]):-!.
    stringinlist(A,[B | L]):-frontchar(A,B,C),stringinlist(C,L).

    glas('a',1):-!.
    glas('b',1):-!.
    glas(_,0).
  
    getword(InputStr,Word,Buf,Tail):-
        frontchar(InputStr,Char,StrTail),
        Char <> ' ', !,
        str_char(CharStr,Char),
        concat(Word,CharStr,NewStr),
        getword(StrTail,NewStr,Buf,Tail).
    getword(InputStr,Word,Word,Tail):-
        frontchar(InputStr,_,Tail), !.
    getword(InputStr, Word, Word, InputStr).
  
    check_str1(0, ""):-!.
    check_str1(N, Str):-
        frontchar(Str, X, Str1),
        upper_lower(X, X1),
        glas(X1, M),
        check_str1(N1, Str1),
        N=M+N1.
 
    max(N1, S1, N2, _, N1, S1) :- N1 > N2, !.  
    max(_, _, N2, S2, N2, S2).
  
    process1("", 0, "") :- !.
    process1(Str, MaxN, MaxW) :-
        getword(Str, "", Word, Rest),
        process1(Rest, RestN, RestW),
        check_str1(N, Word),
        max(N, Word, RestN, RestW, MaxN, MaxW).

    check_equal_ab(Word) :-
        check_str1(MaxN, Word),  
        write("Word: "), write(Word), write(", MaxN: "), write(MaxN), nl.  

    main :-
        openwrite(output, "C:/Users/konaz/OneDrive/Рабочий стол/text_output.txt"),
        writedevice(output),
        file_str("C:/Users/konaz/OneDrive/Рабочий стол/text_input.txt", X),

        process1(X, MaxN, _),
        write("Words with the maximum proportion of 'a' and 'b': "), nl,
        check_equal_ab(X),  
        closefile(output),
        writedevice(screen).

goal
    main.
