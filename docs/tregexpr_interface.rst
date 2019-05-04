Public Methoden und Eigenschaften von TRegExpr: 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    class function VersionMajor: integer;
    class function VersionMinor: integer;

Sie geben die grosse und kleine Versionsummer zurück, Beispiel 0.944
ergibt: VersionMajor = 0 und VersionMinor = 944

::

    property Expression : string

Regulärer Ausdruck

Aus Optimierungsgründen übersetzt TRegExpr den regulären Ausdruck in den
P-Code, den Du kannst ihn sehen mittels der Methode Dump. Der P-Code
wird in den internen Strukturen gespeichert.

Eine [Neu]Übersetzung findet nur statt, wenn sie wirklich benötigt wird,
beim Aufruf von Exec, ExecNext, Substitute, Dump etc. und auch dann nur,
wenn der reguläre Ausdruck oder eine ihn betreffende Eigenschaft
geändert wurde seit der letzten [Neu]Übersetzung.

Falls ein Übersetzungsfehler auftaucht, wird die Methode Error
aufgerufen. Diese erzeugt standardmässig eine Ausnahme vom Typ ERegExpr
– siehe unten

::

    property ModifierStr : string

Setze / hole die Standardwerte für die
`Modifikatoren <regular_expressions.html#about_modifiers>`__. Modifikatoren in
Regulären Ausdrücken
`(?ismx-ismx) <regular_expressions.html#inline_modifiers>`__ ersetzen diese
Standardwerte. Falls Du nicht unterstützte Modifikatoren setzst, wird
die Methode Error aufgerufen, die standardmässig eine Ausnahme vom Typ
EregExpr erzeugt.

::

    property ModifierI : boolean

Modifikator /i – Gross- oder Kleinschreibweise wird nicht
berücksichtigt. Standardmässig False

::

    property ModifierR : boolean

Modiifikator /r – benutze die für Russen erweiterte Syntax.
Standardmässig True. (war die Eigenschaft ExtSyntaxEnabled in früheren
Versionen)

property ModifierS : boolean

`Modifikator /s <regular_expressions.html#modifier_s>`__ - '.' findet jedes
beliebige Zeichen (sonst wie [^\n]). Standardmässig True.

property ModifierG : boolean

`Modifikator /g <regular_expressions.html#modifier_g>`__ – schaltet alle
Operatoren in den genügsamen Modus. Falls ModifierG False ist, dann
arbeitet '*' als '*?', und '+' als '+?' und so weiter. Standardmässig
True.

property ModifierM : boolean

`Modifikator /m <regular_expressions.html#modifier_m>`__ – Behandelt den
Zielstring als mehrzeiligen String. So finden "^" und "$" nicht mehr nur
den Anfang und das Ende des Zielstringes, sondern auch Zeilenseparatoren
innerhalb des Zielstrings. Standardmässig False.

property ModifierX : boolean

`Modifikator /x <regular_expressions.html#modifier_x>`__ – Erweiterte Syntax,
erlaubt das Formatieren des regulärenm Ausdruckes zur besseren
Lesbarkeit. Standardmässig False.

function Exec (const AInputString : string) : boolean;

Lässt einen Regulären Ausdruck auf einem Zielstring ablaufen. Exec
speichert AInputString in der Eigenschaft InputString

For Delphi 5 and higher available overloaded versions:

function Exec : boolean;

without parameter (uses already assigned to InputString property value)

function Exec (AOffset: integer) : boolean;

is same as ExecPos

function ExecNext : boolean;

Findet nächsten Treffer:

   ExecNext;

Arbeitet gleich wie

  if MatchLen [0] = 0 then ExecPos (MatchPos [0] + 1)

    else ExecPos (MatchPos [0] + MatchLen [0]);

ist aber viel einfacher!

Raises exception if used without preceeding successful call to

Exec\* (Exec, ExecPos, ExecNext). So You always must use something like

if Exec (InputString) then repeat { proceed results} until not ExecNext;

function ExecPos (AOffset: integer = 1) : boolean;

Findet einen Treffer im Zielstring, jedoch beginnend ab Position
Aoffset. (Hinweis: AOffset=1 – das erste Zeichen im Zielstring)

property InputString : string;

Gibt den aktuellen Zielstring zurück (vom letzten Exec-Aufruf oder der
letzten Zuweisung an diese Eigenschaft. Eine Zuweisung an diese
Eigenschaft löscht die Match*-Eigenschaften!

function Substitute (const ATemplate : string) : string;

Gibt ATemplate mit durch $& oder $0 ersetztem Regulären Ausdruck und
durch die Vorkommen von Regulären Unterausdrücken ersetzten $n zurück.
Seit Version v.0.929 wird das '$' anstelle des '\' verwendet (aus
Gründen der künfitgen Erweiterbarkeit und der besseren Kompatibilität zu
Perl) und es akzeptiert mehr als eine Ziffer. Falls Du die Zeichen $
oder \\ als Literale in einem Template verwenden möchtest, nutze das
vorangestellte Escape-Zeichen: Beispiel:

   '1\$ is $2\\rub\\' -> '1$ is <Match[2]>\rub\'

Falls Du eine Ziffer als Literal hinter einem $n plazieren möchtest,
dann musst Du das n mit geschweiften Klammern {} begrenzen: Beispiel:

   'a$12bc' -> 'a<Match[12]>bc'

   'a${1}2bc' -> 'a<Match[1]>2bc'.

procedure Split (AInputStr : string; APieces : TStrings);

Zerlege AInputStr in die Einzelteile APieces mit den Treffern des
Regulären Ausdruckes als Trenner

function Replace (AInputStr : RegExprString;

 const AReplaceStr : RegExprString;

 AUseSubstitution : boolean = False) : RegExprString;

function Replace (AInputStr : RegExprString;

 AReplaceFunc : TRegExprReplaceFunction) : RegExprString;

function ReplaceEx (AInputStr : RegExprString;

 AReplaceFunc : TRegExprReplaceFunction)  : RegExprString;

Gibt AInputStr mit den Treffern des regulären Ausdruckes ersetzt durch
AReplaceStr. Wenn AUseSubstitution true ist, wird AReplaceStr genutzt
als Vorlage für die Ersetzungsmethoden.

Beispiel:

  Expression := '({-i}block|var)\s*\(\s*([^ ]*)\s*\)\s*';

  Replace ('BLOCK( test1)', 'def "$1" value "$2"', True);

   gibt zurück:  def 'BLOCK' value 'test1'

  Replace ('BLOCK( test1)', 'def "$1" value "$2"', False)

   gibt zurück:  def "$1" value "$2"

Ruft intern Exec[Next] auf.

Overloaded version and ReplaceEx operate with call-back function,

so You can implement really complex functionality.

property SubExprMatchCount : integer; // ReadOnly

Die Anzahl der Unterausdrücke, die beim letzten Exec-Aufruf gefunden
wurde. Falls keine Unterausdrücke gefunden wurden, aber der gesamte
Reguläre Ausdruck schon (Exec gab True zurück), ist dieser Wert 0. Falls
weder Unterausdrücke noch der gesamte Reguläre Ausdruck gefunden wurde
(Exec gab False zurück), dann ist dieser Wert –1. Beachte, dass einige
Unterausdrücke eventuell nicht gefunden werden können und für solche
Unterausdrücke gilt:

MathPos=MatchLen=-1 and Match=''.

Beispiel: Ausdruck := '(1)?2(3)?';

Exec ('123'): SubExprMatchCount=2, Match[0]='123', [1]='1', [2]='3'

Exec ('12'): SubExprMatchCount=1, Match[0]='23', [1]='1'

Exec ('23'): SubExprMatchCount=2, Match[0]='23', [1]='', [2]='3'

Exec ('2'): SubExprMatchCount=0, Match[0]='2'

Exec ('7') - ergibt False: SubExprMatchCount=-1

property MatchPos [Idx : integer] : integer; // ReadOnly

Position des Starts des Unterausdruckes mit der Nummer Idx, gefunden
beim letzten Exec-Aufruf. Der erste Unterausdruck hat Idx=1, der Letzte
– MatchCount. Der gesamte Reguläre Ausdruck hat Idx=0. Gibt –1 zurück,
wenn entweder der gewünschte Unterausdruck im Regulären Ausdruck nicht
vorhanden ist oder im Zielstring nicht gefunden wurde.

property MatchLen [Idx : integer] : integer; // ReadOnly

(\* Die Länge des Unterausdruckes mit der Nummer Idx. Numerierung und
Rückgabewert wie bei MatchPos. \*)

  property Match [Idx : integer] : string; // ReadOnly

== copy (InputString, MatchPos [Idx], MatchLen [Idx])

Gibt einen Leerstring zurück, wenn entweder der gewünschte Unterausdruck
im Regulären Ausdruck nicht vorhanden ist oder im Zielstring nicht
gefunden wurde

function LastError : integer;

Gibt die ID des letzten Fehler zurück, 0 für keinen Fehler. Nicht zu
verwenden, wenn die Error Methode eine Ausnahme erzeugt. Setzt den
internen Fehlerzustand zurück auf 0.

function ErrorMsg (AErrorID : integer) : string; virtual;

Gibt die Fehlermeldung zur Fehler-ID AErrorID zurück.

property CompilerErrorPos : integer; // ReadOnly

Gibt die Position im Regulären Ausdruck zurück, wo der Compiler beim
Übersetzen stoppte. Nützlich bei der Fehlerdiagnose.

property SpaceChars : RegExprString

Beinhaltet die Zeichen, die für das Metazeichen \\s verwendet werden.
Anfänglich gefüllt mit der globalen Konstanten RegExprSpaceChars.

property WordChars : RegExprString

Beinhaltet die Zeichen, die für das Metazeichen \\w verwendet werden.
Anfänglich gefüllt mit der globalen Konstanten RegExprWordChars.

::

    property LineSeparators : RegExprString

Beinhaltet die Zeichen, die für Zeilenseparatoren wie \\n in UNIX
verwendet werden. Anfänglich gefüllt mit der globalen Konstanten
RegExprLineSeparators. Beachte auch
`Zeilenseparatoren <regular_expressions.html#syntax_line_separators>`__

property LinePairedSeparators : RegExprString

Beinhaltet die Zeichen, die paarweise für Zeilenseparatoren wie \\r\n in
DOS/Windows verwendet werden. Es müssen genau zwei oder gar keine
Zeichen sein. Anfänglich gefüllt mit der globalen Konstanten
RegExprLinePairedSeparators. Beachte auch
`Zeilenseparatoren <regular_expressions.html#syntax_line_separators>`__

Beispiel: Wenn Du den UNIX-Stil als Zeilenseparatoren haben möchtest,
dann weise LineSeparators := #$a (Newline Zeichen) und
LinePairedSeparator := '' (Leerstring) zu. Wenn Du als Zeilenseparatoren
nur genau \\x0D\x0A akzeptieren möchtest, jedoch nicht \\x0D oder \\x0A
aleine, dann weise LineSeparators := '' (Leerstring) und
LinePairedSeparator := #$d#$a zu.

Standardmässig ist der gemsichte Modus aktiv wie er definiert ist in den
globalen Konstanten RegExprLine[Paired]Separator[s]: LineSeparators :=
#$d#$a; LinePairedSeparator := #$d#$a. Das Verhalten dieses Modus wird
ausführlich im Abschnitt `Syntax
besprochen <regular_expressions.html#syntax_line_separators>`__.

class function InvertCaseFunction  (const Ch : REChar) : REChar;

Wandelt Ch in Grossschreibweise um, wenn er in Kleinschreibweise
vorliegt oder umgekehrt. Die aktuellen lokalen System-Einstellungen
werden dafür benutzt.

property InvertCase : TRegExprInvertCaseFunction;

Setze diese Eigenschaft, wenn Du die [Umwandlungsfunktion] zwischen der
Gross- oder Kleinschreibung durch eine eigene ersetzen möchtest.
Standardmässig auf InvertCaseFunction gesetzt.

procedure Compile;

Übersetzt den regulären Ausdruck [erneut]. Nützlich für das interaktive
Erstellen eines regulären Ausdruckes in einem Editor, zur Prüfung der
Gültigkeit aller Parameter, etc.

function Dump : string;

Gibt den übersetzten Regulären Ausdruck in knapp verständlicher Form
zurück.

Globale Konstanten
~~~~~~~~~~~~~~~~~~

EscChar = '\';  // 'Escape'-char ('\' in common r.e.) used for escaping
metachars (\w, \\d etc).

 // it's may be usefull to redefine it if You are using C++ Builder - to
avoide ugly constructions

 // like '\\w+\\\\\\w+\\.\\w+' - just define EscChar='/' and use
'/w+\/w+/./w+'

 Standardmässig für Modifikatoren

::

    RegExprModifierI : boolean = False;                // TRegExpr.ModifierI
    RegExprModifierR : boolean = True;                // TRegExpr.ModifierR
    RegExprModifierS : boolean = True;                // TRegExpr.ModifierS
    RegExprModifierG : boolean = True;                // TRegExpr.ModifierG
    RegExprModifierM : boolean = False;                //TRegExpr.ModifierM
    RegExprModifierX : boolean = False;                //TRegExpr.ModifierX

RegExprSpaceChars : RegExprString = ' '#$9#$A#$D#$C; // Standardbelegung
für die Eigenschaft SpaceChars

RegExprWordChars : RegExprString =     '0123456789'  +
'abcdefghijklmnopqrstuvwxyz'  + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ_';  //
Standardbelegung für die Eigenschaft WordChars

RegExprLineSeparators : RegExprString =  #$D#$A{$IFDEF
UniCode}#$B#$C#$2028#$2029#$85{$ENDIF};  // Standardbelegung für die
Eigenschaft LineSeparators

RegExprLinePairedSeparators : RegExprString = ' '#$D#$A;  //
Standardbelegung für die Eigenschaft LinePairedSeparators

RegExprInvertCaseFunction : TRegExprInvertCaseFunction =
TRegExpr.InvertCaseFunction;

 // Standardbelegung für die Eigenschaft InvertCase

function RegExprSubExpressions (const ARegExpr : string;

ASubExprs : TStrings; AExtendedSyntax : boolean = False) : integer;

Erzeugt eine Liste der Teilausdrücke in einem regulären Ausdruck.

In ASubExps repräsentiert jeder String einen Teilausdruck, beginnend mit
dem ersten bis zum letzten, im Format:

 String – Teilausdruck-Text (ohne die Klammern '()')

 Low Word (TString.Object) - Startposition im ARegExpr, inklusive '('
falls einer existiert (die erste Position ist 1)

 High Word (TString.Object) – Länge, inklusive Start-'(' und End-')'
falls einer existiert.

AExtendedSyntax - must be True if modifier /x will be On while

using the r.e.

Nützlich für GUIs für Editoren für reguläre Ausdrücke etc. (Du findest
ein Beispiel davon im Projekt)

Result code        Meaning

--------------

0                Success. No unbalanced brackets was found;

-1                there are not enough closing brackets ')';

-(n+1)                at position n was found opening '[' without
corresponding closing ']';

n                at position n was found closing bracket ')' without
corresponding opening '('.

 

// Falls Result <> 0, dann könnten in ASubExprs auch leere Items
enthalten sein.

Nützliche globale Functionen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function ExecRegExpr (const ARegExpr, AInputStr : string) : boolean;

True, wenn in AInputString der Reguläre Ausdruck AregExpr gefunden wird.
Erzeugt eine Ausnahme, wenn es Syntaxfehler hat in AregExpr

procedure SplitRegExpr (const ARegExpr, AInputStr : string; APieces :
TStrings);

Zerlegt AInputStr in die Einzelteile APieces getrennt durch die Treffer
des Regulären Ausdruckes ARegExpr.

function ReplaceRegExpr (const ARegExpr, AInputStr, AReplaceStr :
string) : string;

Gibt AInputStr mit den Treffern des regulären Audruckes ersetzt durch
AReplaceStr. Wenn AUseSubstitution true ist, wird AReplaceStr genutzt
als Vorlage für die Ersetzungsmethoden.

Beispiel:

ReplaceRegExpr ('({-i}block|var)\s*\(\s*([^ ]*)\s*\)\s*',

  'BLOCK( test1)', 'def "$1" value "$2"', True)

gibt zurück:  def 'BLOCK' value 'test1'

ReplaceRegExpr ('({-i}block|var)\s*\(\s*([^ ]*)\s*\)\s*',

  'BLOCK( test1)', 'def "$1" value "$2"')

  gibt zurück:  def "$1" value "$2"

ReplaceRegExpr ('({-i}block|var)\s*\(\s*([^ ]*)\s*\)\s*',

  'BLOCK( test1)', 'def "$1" value "$2"', True)

gibt zurück:  def 'BLOCK' value 'test1'

ReplaceRegExpr ('({-i}block|var)\s*\(\s*([^ ]*)\s*\)\s*',

  'BLOCK( test1)', 'def "$1" value "$2"')

  gibt zurück:  def "$1" value "$2"

function QuoteRegExprMetaChars (const AStr : string) : string;

Ersetze alle Metazeichen durch deren sichere Repräsentationen. Beispiel:

 'abc$cd.(' wird gewandelt in 'abc\$cd\.\('

Diese Funktion ist nützlich, wenn ein Benutzer einen Regulären Ausdruck
selbst zusammenstellen darf, ohne sich um das Escaping kümmern zu
müssen.

Ausnahme Typ

Die standardmässige Fehlerbehandlungsroutine erzeugt folgende Ausnahme:

ERegExpr = class (Exception)

  public

   ErrorCode : integer; // Error-Code. Übersetzungsfehler haben Codes <
1000.

   CompilerErrorPos : integer; // Position im Regulären Ausdruck, wo der
Übersetzungsfehler auftauchte

 end;

 

Wie wird Unicode benutzt?
~~~~~~~~~~~~~~~~~~~~~~~~~

TRegExpr unterstützt nun UniCode, aber leider sehr langsam :(

Wer möchte dies optimieren? ;)

Benütze es nur, wenn Du wirklich nicht auf Unicode-Unterstützung
verzichten kannst!

Entferne '.' aus {.$DEFINE UniCode} in regexpr.pas. Danach werden alle
Strings als Delphis WideString (= Unicode) behandelt
