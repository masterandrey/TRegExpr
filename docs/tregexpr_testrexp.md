Die Demo ist ein einfaches Programm, um mit den Regulären Ausdrücken zu
spielen, sie kennenzulernen und eigene Ausdrücke zu testen Es ist im
Quelltext vorhanden im Projekt TestRExp.dpr) und als TestRExp.exe.

Beachte, dass es einige VCL-Eigenschaften verwendet, die nur in Delphi 4
oder höher vorhanden sind. Wenn Du es unter Delphi 2 oder 3 übersetzst,
wirst Du Fehlermeldungen erhalten über unbekannte Eigenschaften. Du
kannst diese Meldungen ignorieren – diese Eigenschaften werden nur fürs
Anpassen der Komponenten auf dem Formular beim Ändern der Grösse des
Formulars verwendet.

Mit Hilfe dieses Programmens kannst Du unter anderem leicht die Anzahl
der Teilausdrücke eines komplexeren regulären Ausdruckes bestimmen. Du
kannst zu jedem dieser Teilausdrücke springen, sowohl im Eingabe- wie
auch im Zielstring, kannst mit den Funktionen Substitute, Replace und
Split functions etc. spielen.

Darüberhinaus sind im Demo-Projekt zahlreiche Beispiele – benutze sie
als Lernobjekte, um entweder die Syntax der regulären Ausdrücke oder
TRegExpr kennenzulernen

Example: Hyper Links Decorator
==============================
* [DecorateURLs](#decorateurls)  
* [DecorateEMails](#decorateemails)

Funktionen um reine URLs in HTML-Anker (aka Links) umzuwandeln.

Beispiel: Ersetze 'http://regexpstudio.com' mit
href="https://regexpstudio.com"'

oder 'anso@mail.ru' mit '<a
href="mailto:anso@mail.ru">anso@mail.ru</a>'.

<a name="decorateurls"></a>
### Funktionen DecorateURLs

Findet URLs wie 'http://...' or 'ftp://..', aber auch solche, die mit
'www.' Beginnen. E-Mailadressen werden mit der Function
[DecorateEMails](#hyperlinksdecorator.html#decorateemails) umgewandelt.

function DecorateURLs (const AText : string; AFlags :
TDecorateURLsFlagSet = \[durlAddr, durlPath\]) : string;

Beschreibung

Gibt den Eingabetext AText mit umgewandelten URLs zurück

AFlags welche gefundenen Teile der URL müssen in den sichtbaren Teil.
Beispiel: Wenn \[durlAddr\] dann wird die URL
'http://anso.da.ru/index.htm' zu '<a
href="http://anso.da.ru/index.htm">anso.da.ru</a>'

type

 TDecorateURLsFlags = (durlProto, durlAddr, durlPort, durlPath,
durlBMark, durlParam);

 TDecorateURLsFlagSet = set of TDecorateURLsFlags;

Beschreibung

Dies sind die möglichen Werte:

Benennung        Bedeutungen

------------------------------------------------------------------------

durlProto        Protokoll (wie 'ftp://' or 'http://')

durlAddr        TCP Adresse oder Domain-Name (wie 'anso.da.ru')

durlPort                Port falls angeben (wie ':8080')

durlPath        Pfad zum Dokument (wie 'index.htm')

durlBMark        Bookmark (wie '\#mark')

durlParam        URL Parameters (wie '?ID=2&User=13')
 
<a name="decorateemails"></a>
### Funktionen DecorateEMails
Ersetzt alle korrekten E-Mails-URLs mit '<a
href="mailto:ADDR">ADDR</a>' Beispiel: Ersetze 'anso@mail.ru'
mit '<a href="mailto:anso@mail.ru">anso@mail.ru</a>'.

function DecorateEMails (const AText : string) : string;

Beschreibung

Gibt den Eingabetext AText mit umgewandelten E-Mail-Links zurück

