      **This is very old and outdated translation.**
      *If you can read English or Russian please use* `up-to-date English <http://regexpr.masterandrey.com/en/latest/>`_ *or* `up-to-date Russian <http://regexpr.masterandrey.com/ru/latest/>`_.

      *If you want to help me to update the translation please* `contact me <https://github.com/masterandrey>`_.

------------

TRegExpr ist eine Sammlung von einfach zu benutzenden Routinen, um
mächtige, vorlagenbasierte Zeichenkettenvergleiche durchzuführen,
beispielsweise zur Prüfung von strukturierten Dateneingaben in
Datenbanken wie beispielsweise Telefonnummern mit Vorwahlen,
Sozialversicherungsnummern, Web-Applikationen, komplexere Suchen &
Ersetzen-Vorgänge, Werkzeuge zur Durchforstung von Dateibeständen nach
regelbasierenden Ausdrücken und so weiter.

Du kannst mit TRegExpr leicht und schnell die korrekte Syntax einer
E-Mail-Adresse prüfen, Telefonnummern in einem Text erkennen, URLs aus
Qelltexten von Web-Seiten extrahieren, unterschiedliche Schreibweisen
eines Ausdruckes finden und durch eine einzige ersetzen. Es bleibt
Deiner Fantasie überlassen, wozu Du TRegExpr noch benutzen kannst. Die
Suchvorlagen (im folgenden Templates genannt), können zur Laufzeit
geändert werden, ohne dass eine Neuübersetzung des Programmes notwendig
würde!

Diese Bibliothek, die ich hiermit in die Freeware lege, ist eine
Delphi-Portierung der Routinen, die Henry Spencer als V8-Routinen
herausbrachte, um damit eine Untermenge der `Regulären Ausdrücke von
Perl <regexp_syntax.html>`__ handhaben zu können.

Demgegenüber ist TRegExpr vollständig in einfachem Object-Pascal
geschrieben und wird mit dem ganzen Quelltext kostenlos zur Verfügung
gestellt.

Der originale C-Quelltext wurde verbessert, in eine Klasse
`TRegExpr <tregexpr_interface.html>`__ gekapselt und in einer einzigen
Datei gespeichert: RegExpr.pas.

Du brauchst also keine DLL mehr für Reguläre Ausdrücke!

Um die Bibliothek zu installieren, kopiere einfach RegExpr.pas in ein
Verzeichnis Deiner Wahl und/oder füge den Pfad zu diesem Verzeichnis in
Delphis Projekt-Manager hinzu.

Das ist schon alles!

Danach benutze einfach das TregExpr-Objekt oder die globalen Routinen in
Deinem Projekt (beachte die `Beispiele <demos.html>`__).

Schaue Dir mal die einfachen `Beispiele <demos.html>`__ an und studiere
die `Syntax <regexp_syntax.html>`__ der Regulären Ausdrücke (Du kannst
natürlich auch das `Demo-Projekt <tregexpr_testrexp.html>`__ für
Studienzwecke heranziehen und damit auch Deine eigenen Regulären
Ausdrücken ausarbeiten oder debuggen).

Du kannst sogar Unicode (d.h. Delphis WideString) benutzen – weiteres
unter "`Wie wird Unicode benutzt? <tregexpr_interface.html#unicode>`__".

Wirf auch einen Blick auf die `Was gibt's
Neues <http://regexpstudio.com>`__ web-Sektion für die neuesten
Änderungen.

Und natürlich sind Kommentare, Ideen, Vorschläge und sogar Bug Reports
`willkommen <#author.html>`__.

Danksagung
~~~~~~~~~~

-  Guido Muehlwitz - er fand und behob einen ärgerlichen Fehler bei der
   Bearbeitung von grossen Strings
-  Stephan Klimek - er testete in CPPB und schlug einige Features vorund
   implementierte sie auch gleich
-  Steve Mudford - er implementierte den Offset-Parameter
-  Martin Baur (`www.mindpower.com <http://www.mindpower.com>`__) -
   Deutsche Hilfe,nützliche Vorschläge
-  Yury Finkel - er implementierte die UniCode-Unterstützung, fand und
   behob einige Fehler
-  Ralf Junker - er implementierte einige Features, zahlreiche
   Optimierungsvorschläge
-  Simeon Lilov - Bulgarische Hilfe
-  Filip Jirsák und Matthew Winter (wintermi@yahoo.com) – Hilfe bei der
   Implementation des "genügsamen" Moduls
-  Kit Eason - Viele Beispiele un die Einführung im Hilfe-Abschnitt
-  Juergen Schroth - bug hunting and usefull suggestions
-  Martin Ledoux - French help
-  Diego Calp (mail@diegocalp.com), Argentinien – Spanische Hilfe

Und viele andere – für die grosse Arbeit des Fehlerfindens!

Documentation
-------------

.. toctree::
   :glob:
   :maxdepth: 2

   regexp_syntax
   tregexpr_interface
   faq
   demos
   tregexpr_testrexp