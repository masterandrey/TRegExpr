#### F. Wie kann ich TRegExpr mit Borland C++ Builder benutzen?
Ich habe ein Problem, weil offensichtlich die Header Datei fehlt (.h or
.hpp).

##### A.
* Füge RegExpr.pas zum BCB Projekt hinzu.
* Kompiliere das Projekt. Dies generiert die Header Datei RegExpr.hpp.
* Nun kann Programmcode geschrieben werden, der die RegExpr unit
benutzt.Nicht vergessen den Verweis auf die Header Datei (\#include
"RegExpr.hpp") einzufügen, wo dies nötig ist.
* Don`t forget to replace all `\\` in regular expressions with `\\\\`. 

#### F. Why many r.e. (including r.e. from TRegExpr help and demo) work wrong in Borland C++ Builder?

##### A.
Please, reread answer to previous question ;) Symbol `\\` has special
treting in C++, so You have to `escape` it (as described in
prev.answer). But if You don`t like r.e. like
`\\\\w+\\\\\\\\\\\\w+\\\\.\\\\w+` You can redefine constant EscChar
(RegExpr.pas), for example EscChar=`/` - then r.e. will be
`/w+\\/w+/./w+`, sligtly unusual but more readable..

#### F. Weshalb gibt TRegExpr mehr als eine Zeile zurück?
Beispiel sei der reguläre Ausdruck `<font .\*>`, der das erste
`<font` und danach den ganzen Rest des Eingabefiles zurückbringt
inklusive dem letzten `</html>`.

##### A.
Aus Grunden der Abwarstkompatibilitat ist der [Modifikator
/s](regexp_syntax.html#modifier_s) standardmassig eingeschaltet.

Schalte ihn aus und `.` findet alles ausser
[Zeilenseparatoren](regexp_syntax.html#syntax_line_separators) – Wie Du
es wunschst.

BTW Ich schlage vor, Du nimmst `<font (\[^\\n>\]\*)>`, dann
hast Du in Match\[1\] die URL.

#### F. Weshalb gibt TRegExpr mehr zurück als ich erwarte?
Beispiel sei der reguläre Ausdruck `<p>(.+)</p>`, angewandt
auf den Zielstring `<p>a</p><p>b</p>`, der
`a</p><p>b` zurückgibt, aber nicht nur das `a` wie erwartet.

##### A.
Standardmässig arbeiten alle Operatoren im "gierig" Modus. Sie finden
also soviel wie möglich.

Falls Du den "genügsamen" Modus benutzen möchtest, so geht das nun ab
Version 0.940. Da funktionieren Operatoren wie `+?` etc. in diesem
minimalen Match-Modus. Du kannst auch alle Operatoren standardmässig in
diesem Modus arbeiten lassen mit dem Einsatz des Modifikators `g`
(benutze dazu die entsprechenden TRegExpr-Eigenschaften oder
Inline-Konstrukte wie `?(-g)` im regulären Ausdruck).

#### F. Wie parse ich Quelltexte wie HTML mit Hilfe von TRegExpr?
##### A.
Sorry folks, aber das ist fast unmöglich!

Natürlich kann man TRegExpr benutzen, um Teile aus einem HTML-File zu
extrahieren, wie ich ja auch zeige in den Beispielen. Aber wenn effektiv
ein ganzes File geparsed (d.h. in seine Elemente erlegt werden soll),
dann braucht man einen ausgewachsenen Parser, nicht nur einen
Regulären-Ausdruck-Matcher. Eine umfassende Lektüre bietet
beispielsweise das `Perl Cookbook` von Tom Christiansen und Nathan
Torkington. In kurzen Worten, es gibt viele Konstruktionen, die ganz
leicht mit echten Parsern, aber nicht mit regulären Ausdrücken zerlegt
werden können. Zudem ist ein echter Parser viel schneller beim Zerlegen
des Files, weil ein Regulärer-Ausdruck-Matcher nicht nur den Eingabetext
liest, sondern ein optimiertes Suchmuster aufbaut, was viel Zeit in
Anspruch nehmen kann.

#### F. Gibt es einen Weg, mehrere Treffer eines Suchmusters zu erhalten?
##### A.
Du kannst eine Schleife mittels der ExecNext-Methode schreiben und so
einen Treffer nach dem anderen herausholen.

Leichter kann es nicht gemacht werden, weil Delphi nicht wie Perl ein
Interpreter ist. Als Compiler ist Delphi dafür schneller.

Falls Du ein Beispiel suchst, schaue Dir doch die Implementation von
TRegExpr.Replace an oder das Beispiel in
[HyperLinksDecorator.pas](#hyperlinksdecorator.html)

#### F. Ich überpfüfe die Eingabe des Benutzers. Weshalb gibt TRegExpr `True`
zurück für falsche Eingabestrings?
##### A.
In vielen Fällen vergessen die Benutzer von TRegExpr, dass er gemacht
ist zur Suche im Eingabestring. Wenn Du also den Benutzer dazubringen
möchtest, dass er nur 4 Ziffern eingibt und Du dazu den regulären
Ausdruck `\\d{4,4}` benutzst, so wird dieser Ausdruck schon die 4
Ziffern in Eingaben wie `12345` oder `irgendwas 1234 und nochwas`
erkennen. Eventuell hast Du nur vergessen, dass die 4 Ziffern alleine
vorkommen sollen. Du müsstest also den regulären Ausdruck so schreiben:
`^\\d{4,4}$`.

#### F. Weshalb arbeiten genügsame Operatoren manchmal wie ihre gierigen Gegenstücke?
Beispiel sei der reguläre Ausdruck `a+?,b+?` angewandt auf den String
`aaa,bbb` findet `aaa,b`. Sollte er nicht `a,b` finden wegen des
genügsamen ersten Iterators?

##### A.
Dies ist eine Einschränkung der von TRegExpr (und Perl und vielen
UNIXen) verwandten Mathematik – reguläre Ausdrücke verwenden nur
"einfache" Suchoptimierungen, nicht unbedingt die beste Optimierung. In
seltenen Fällen ist das nicht ausreichend, aber in den meisten Fällen
ist es wohl eher ein Vorteil denn ein Nachteil: Und zwar aus Gründen der
Performance und Vorhersagbarkeit des Resultats. Die Hauptregel ist: Die
regulären Ausdrücke versuchen zuerst, von der aktuellen Stelle im
Zielstring alle Varianten zu finden und nur wenn es absolut keinen
Treffer gibt, wird vom Zielstring ein Zeichen vorwärtsgelesen und alles
wiederholt. Wenn Du also `a,b+?` benutzst, dann findet es `a,b`. Im
Falle von `a+?,b+?` ist es zwar nicht wünschenswert (wegen der
genügsamen Iteratoren) aber möglich, mehrere `a`s zu finden, also findet
TRegExpr sie auch und gibt einen korrekten, aber nicht unbedingt
optimalen Treffer zurück. Genauso wie die regulären Ausdrücke Perl oder
UNIX geht TRegExpr nicht so weit, dass es nach einem Zeichen weitergeht
im Zielstring und erneut prüft, ob es einen "noch besseren Treffer"
gäbe. Zudem kann man hierbei überhaupt nicht von "schlechteren oder
besseren Treffern" sprechen. Bitte lies den Abschnitt  für
[Syntax](regexp_syntax.html) weitere Erläuterungen.
