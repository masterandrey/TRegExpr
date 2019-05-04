      **This is very old and outdated translation.**
      *If you can read English or Russian please use up-to-date* `English version <http://regexpr.masterandrey.com>`_ *or* `Russian version <http://regexpr.masterandrey.com/ru/latest/>`_.

      *If you want to help to update the translation please* `contact me <https://github.com/masterandrey>`_.
      New translation is based on `GetText <https://en.wikipedia.org/wiki/Gettext>`_ and can be edited with `transifex.com <https://www.transifex.com/masterAndrey/tregexpr/dashboard/>`_.
      It is already machine-translated and need only proof-reading and may be some copy-pasting from here.

------------

Einfache Beispiele
~~~~~~~~~~~~~~~~~~

Falls Du nicht mit Regulären Ausdrücken bekannt bist, dann könntest Du
etwas unter dem Abschnitt `Syntax <regular_expressions.html>`__ dazulernen
oder schaue in ein gutes Perl oder Unix Buch.  

Globale Routinen verwenden
~~~~~~~~~~~~~~~~~~~~~~~~~~

Das ist zwar einfach, aber nicht besonders flexibel oder effektiv.

::

    ExecRegExpr ('\\d{3}-(\\d{2}-\\d{2}|\\d{4})', 'Phone: 555-1234');

Rückgabewert: True

::

    ExecRegExpr ('^\\d{3}-(\\d{2}-\\d{2}|\\d{4})', 'Phone: 555-1234');

Rückgabewert: False, weil es einige Zeichen vor der Telefonnummer hat
und weil wir das Metazeichen '^' benutzen (Bedeutung von '^':
BeginningOfLine)

::

    ReplaceRegExpr ('product', 'Take a look at product. product is the best!', 'TRegExpr');

Rückgabewert: 'Take a look at TRegExpr. TRegExpr is the best !'; ;)

Die TRegExpr-Klasse verwenden
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Damit hast Du alle Möglichkeiten der Bibliothek zur Verfügung.

{% highlight pascal linenos %} // Diese einfache Funktion extrahiert
alle E-Mail-Adressen aus dem InputString // und legt eine Liste dieser
Adressen in den Rückgabewert function ExtractEmails (const AInputString
: string) : string; const EmailRE =
'[_a-zA-Z\d\-\.]+@[_a-zA-Z\d\-]+(\.[_a-zA-Z\d\-]+)+' var   r : TRegExpr;
begin Result := ''; r := TRegExpr.Create; // Erzeuge Objekt try //
garantiere Speicherfreigabe        r.Expression := EmailRE;        //
der R.A. wird automatisch in die interne Struktur übersetzt        //
innerhalb der Zuweisung an diese Eigenschaft        if r.Exec
(AInputString) then                REPEAT                        Result
:= Result + r.Match [0] + ', ';                UNTIL not r.ExecNext;    
   finally r.Free; end; end begin  ExctractEmails ('My e-mails is
anso@mail.ru and anso@usa.net');  // gibt zurück: 'anso@mail.ru,
anso@usa.net, ' end. {% endhighlight %}

Beachte: Die Übersetzung eines Regulären Ausdruckes beansprucht etwas
Zeit während der Zuweisung. Wenn Du also diese Funktion öfters
ausführst, dann erzeugst Du damit unnötigen Aufwand. Wenn der Reguläre
Ausdruck also konstant bleibt, dann kannst Du dies beträchtlich
optimieren, indem Du diese Zuweisung nur während der
Initialisierungsphase Deines Projektes ausführst.

{% highlight pascal linenos %} // Dieses einfache Beispie extrahiert
Telefonnummern und // zerlegt sie in Teile (Stadt- und Landesvorwahl,
interne Nummer). // Danach ersetzt es diese Teile im Template. function
ParsePhone (const AInputString, ATemplate : string) : string; const
IntPhoneRE = '(\+\d \*)?(\(\d+\) \*)?\d+(-\d*)*'; var r : TRegExpr;
begin r := TRegExpr.Create; try        r.Expression := IntPhoneRE;      
 if r.Exec (AInputString)                then Result := r.Substitute
(ATemplate)                else Result := '';        finally r.Free;
end; end; begin  ParsePhone ('Phone of AlkorSoft (project PayCash) is
+7(812)329-44-69',  'Zone code $1, city code $2. Whole phone number is
$&.');  // Rückgabe: 'Zone code +7, city code (812) . Whole phone number
is +7(812) 329-44-69.' end. {% endhighlight %}

Etwas komplexere Beispiele 
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Du findest komplexere Beispiele für den Gebrauch von TRegExpr in den
Projekten `TestRExp.dpr <tregexpr_testrexp.html>`__ und
`HyperLinkDecorator.pas <hyperlinksdecorator.html>`__.

Beachte bitte auch meine kleinen
`Artikel <http://masterandrey.com/posts/en/text_processing_from_birds_eye_view.html>`__.

Ausführliche Erklärung

Bitte beachte dazu die
TRegExpr-Interface-\ `Beschreibung <tregexpr.html>`__.
