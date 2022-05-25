:- use_module(library(jpl)).
start :-sleep(0.4),	
		write('Hello'),nl,
        powitanie.

    cechy(Kandydat, narkotyki) :- verify(Kandydat, "Czy brales kiedykolwiek narkotyki?").
    cechy(Kandydat, uzalezniony) :- verify(Kandydat, "Czy byles lub nadal jestes od czegos uzalezniony?").
    cechy(Kandydat, kategorie) :- verify(Kandydat, "Czy masz kategorie wojskowa A?").
    cechy(Kandydat, wiek) :- verify(Kandydat, "Czy masz wiecej niz 18 lat?").
    cechy(Kandydat, testp) :- verify(Kandydat, "Czy wyrazasz zgode na przeprowadzenie testu psychologicznego?").
    cechy(Kandydat, testf) :- verify(Kandydat, "Czy zgadzasz sie na przeprowadzenie testu sprawnosciowego?").
    cechy(Kandydat, patriota) :- verify(Kandydat, "Czy jestes patriota?").
    cechy(Kandydat, zainteresowanie) :- verify(Kandydat, "Czy interesujesz sie szeroko pojeta militaryzacja?").
    cechy(Kandydat, powinnosc) :- verify(Kandydat, "Czy czujesz wewnetrzny obowiazek obrony swojego panstwa?").
    cechy(Kandydat, smierc) :- verify(Kandydat, "Czy jestes gotowy zginac za swoj kraj?").

    wynik(Kandydat,idealny_zolnierz) :-
        cechy(Kandydat, kategorie),
        cechy(Kandydat, wiek),
        cechy(Kandydat, testp),
        cechy(Kandydat, testf),
        cechy(Kandydat, patriota),
        cechy(Kandydat, zainteresowanie),
        cechy(Kandydat, powinnosc),
        cechy(Kandydat, smierc).

    wynik(Kandydat, dobry_zolnierz) :-
        cechy(Kandydat, kategorie),
        cechy(Kandydat, wiek),
        cechy(Kandydat, testp),
        cechy(Kandydat, testf),
        cechy(Kandydat, patriota).

    wynik(Kandydat, moze_zolnierz) :-
        cechy(Kandydat, narkotyki),
        cechy(Kandydat, kategorie),
        cechy(Kandydat, wiek),
        cechy(Kandydat, testp),
        cechy(Kandydat, testf).

    wynik(Kandydat, nie_zolnierz) :-
        cechy(Kandydat, narkotyki),
        cechy(Kandydat, uzalezniony).

    wynik(_,"Nie potrafimy podjac teraz deycji, potrzebne beda dodatkowe badania.").

kd(Kandydat):-
    wynik(Kandydat, Decyzja),
    koniec(Kandydat, Decyzja),
    write(Kandydat),write(Decyzja),undo.


pytaj(Kandydat,Pytanie):-
    write(Kandydat),write(Pytanie),nl,
    wyswietl(Kandydat,Pytanie),
    write('Ladowanie...'),nl.

:- dynamic yes/1,no/1.	

verify(K, P) :-
    (yes(P) 
    -> 
    true ;
    (no(P) 
    -> 
    fail ;
    pytaj(K, P))).

undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.

powitanie :-
    jpl_new('javax.swing.JFrame', ['Chatbot'], F),
    jpl_new('javax.swing.JLabel',['Rozmowa na stanowisko wojskowe'],LBL),
    jpl_new('javax.swing.JPanel',[],Pan),
    jpl_call(Pan,add,[LBL],_),
    jpl_call(F,add,[Pan],_),
    jpl_call(F, setLocation, [200,50], _),
    jpl_call(F, setSize, [800,700], _),
    jpl_call(F, setVisible, [@(true)], _),
    jpl_call(F, toFront, [], _),
    jpl_new('javax.swing.JOptionPane', [], JOP),
    jpl_call('javax.swing.JOptionPane', showInputDialog, [F,'Prosze podaj swoje imie'], N),
    atomic_list_concat(['Witaj ', N ,' w elektronicznym systemie rekrutacji wojskowej. Zadamy Ci pare pytan, prosze odpowiadaj szczerze. '], Witaj),
    jpl_call(JOP, showMessageDialog, [F, Witaj], _),
    jpl_call(F, dispose, [], _), 

    (	N == @(null)
        ->	write('Przerwano'),fail
        ;	write(N),nl,kd(N)
    ).


wyswietl(Kandydat, Pytanie) :-
    atomic_list_concat([Kandydat,' ',Pytanie], Atom),
    jpl_new('javax.swing.JFrame', ['Chatbot'], F),
    jpl_new('javax.swing.JLabel',['Rozmowa na stanowisko wojskowe'],LBL),
    jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [200,50], _),
	jpl_call(F, setSize, [800,700], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
    jpl_new('javax.swing.JOptionPane', [], JOP),
	jpl_call('javax.swing.JOptionPane', showInputDialog, [F,Atom], N),
	jpl_call(F, dispose, [], _), 
    write(N),nl,
	( (N == yes ; N == y)
      ->
       assert(yes(Pytanie)) ;
       assert(no(Pytanie)), fail).


    
koniec(Kandydat, Decyzja) :-
    jpl_new('javax.swing.JFrame', ['Chatbot'], F),
    jpl_new('javax.swing.JLabel',['Rozmowa na stanowisko wojskowe'],LBL),
    jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [200,50], _),
	jpl_call(F, setSize, [800,700], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
    jpl_new('javax.swing.JOptionPane', [], JOP),
    atomic_list_concat([Kandydat,' twoj typ kandydata to: ',Decyzja], Atom),
    jpl_call('javax.swing.JOptionPane', showMessageDialog, [F,Atom], _),
    jpl_call(F, dispose, [], _).
