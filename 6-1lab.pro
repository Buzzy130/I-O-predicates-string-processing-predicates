domains
    file=output
    charlist=char*
predicates
    nondeterm main
    stringinlist(string,charlist)          %преобразование строки символов в список   
    glas(char, integer)
    check_str1(integer, string)
    getword(string, string, string, string)
    max(integer, string, integer, string, integer, string)
    process1(string, integer, string) 
clauses
    stringinlist("",[ ]):-!.
    stringinlist(A,[B | L]):-frontchar(A,B,C),stringinlist(C,L).

  glas('a',1):-!. glas('o',1):-!. glas('e',1):-!.
  glas('i',1):-!. glas('y',1):-!. glas('u',1):-!.
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

    main :-
        openwrite(output, "C:/Users/konaz/OneDrive/–абочий стол/text_output.txt"),
        writedevice(output),
        file_str("C:/Users/konaz/OneDrive/–абочий стол/text_input.txt", X),

        process1(X, N1, W1),
        write("—лово с наибольшим количеством гласных: ", W1, " (√ласные: ", N1, ")"), nl,
        
        % «адача б) найти все слова, в которых дол€ букв а, b максимальна
        

        % «адача в) в тех словах, которые оканчиваютс€ сочетанием букв ing, заменить это окончание на ed
       % replaceIngWithEd(Words, ReplacedWords),
        %write("Words with 'ing' replaced by 'ed': "), write(ReplacedWords), nl,

        closefile(output),
        writedevice(screen).

goal
    main.