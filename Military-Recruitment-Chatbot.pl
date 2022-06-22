:- use_module(library(jpl)).
startuj :-
        powitanie.

    cechy(Kandydat, narkotyki) :- zapytaj(Kandydat, "Czy brales kiedykolwiek narkotyki?").
    cechy(Kandydat, uzalezniony) :- zapytaj(Kandydat, "Czy byles lub nadal jestes od czegos uzalezniony?").
    cechy(Kandydat, kategorie) :- zapytaj(Kandydat, "Czy masz kategorie wojskowa A?").
    cechy(Kandydat, wiek) :- zapytaj(Kandydat, "Czy masz wiecej niz 18 lat?").
    cechy(Kandydat, testp) :- zapytaj(Kandydat, "Czy wyrazasz zgode na przeprowadzenie testu psychologicznego?").
    cechy(Kandydat, testf) :- zapytaj(Kandydat, "Czy zgadzasz sie na przeprowadzenie testu sprawnosciowego?").
    cechy(Kandydat, patriota) :- zapytaj(Kandydat, "Czy jestes patriota?").
    cechy(Kandydat, zainteresowanie) :- zapytaj(Kandydat, "Czy interesujesz sie szeroko pojeta militaryzacja?").
    cechy(Kandydat, powinnosc) :- zapytaj(Kandydat, "Czy czujesz wewnetrzny obowiazek obrony swojego panstwa?").
    cechy(Kandydat, smierc) :- zapytaj(Kandydat, "Czy jestes gotowy zginac za swoj kraj?").
    cechy(Kandydat, psychika) :- zapytaj(Kandydat, "Czy kiedykolwiek leczyles sie psychiatrycznie?").
    cechy(Kandydat, psychika2) :- zapytaj(Kandydat, "Czy masz lub miales stwierdzona chorobe psychiczna?").
    cechy(Kandydat, jedzenie) :- zapytaj(Kandydat, "Czy masz dobra tolerancje gastronomiczna?").
    cechy(Kandydat, odpornosc) :- zapytaj(Kandydat, "Czy posiadasz dobra odpornosc (chorowanie maksymalnie 2 razy do roku)?").

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
        cechy(Kandydat, narkotyki);
        cechy(Kandydat, uzalezniony);
        cechy(Kandydat, psychika);
        cechy(Kandydat, psychika2).

    wynik(Kandydat, ewentualnie) :-
        cechy(Kandydat, jedzenie),
        cechy(Kandydat, odpornosc).

    wynik(_, inne).
    

kd(Kandydat):-
    wynik(Kandydat, Decyzja),
    koniec(Kandydat, Decyzja),
    zmien.

pytaj(Kandydat,Pytanie):-
    wyswietl(Kandydat,Pytanie).

:- dynamic tak/1, nie/1.	

zapytaj(K, P) :-
    (tak(P) -> 
        true 
    ;
    (nie(P) -> 
        fail 
    ;
        pytaj(K, P))
    ).

zmien :- retract(tak(_)),fail. 
zmien :- retract(nie(_)),fail.
zmien.

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

    (N == @(null) ->	
        write('Przerwano'),
        fail
    ;	
        kd(N)
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
	jpl_call('javax.swing.JOptionPane', showConfirmDialog, [F,Atom], N),
	jpl_call(F, dispose, [], _), 
    write(N),nl,
	((N == 0) ->
       assert(tak(Pytanie)) 
    ;
       assert(nie(Pytanie)), fail).

    
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

    ((Decyzja == nie_zolnierz) ->
        Decyzja2 = 'Przykro nam ale nie spelniasz podstawowych kryteriow. Nie mozesz przejsc dalej. Zostajesz odrzucony.'
    ;(Decyzja == moze_zolnierz) ->
        Decyzja2 = 'Niestety ale nie zakwalifikowales sie w pierwszej turze ale wciaz nasz szanse w drugiej.'
    ;(Decyzja == dobry_zolnierz; Decyzja == idealny_zolnierz) ->
        Decyzja2 = 'Gratulacje! Idealnie nadajesz sie na zolnierza. Na pewno sie do Ciebie odezwiemy.'
    ;(Decyzja == inne) ->
        Decyzja2 = 'Niestety zostales odrzucony. Nie pasujesz do schematu zolnierza. Pamietaj takze, ze wyrazenie zgody na testy jest obowiazkowe by przejsc dalej.'
    ;(Decyzja == ewentualnie) ->
        Decyzja2 = 'Nie moglismy dopasowac twoich odpowiedzi do naszych wymagan dlatego zostaly Ci zadane dodatkowe pytania. Z twoich odpowiedzi wynika, ze zostaniesz powolany tylko w przypadku braku personelu.'
    ),
   
    jpl_call('javax.swing.JOptionPane', showMessageDialog, [F,Decyzja2], _),
    jpl_call(F, dispose, [], _).