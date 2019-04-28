### Métodos públicos y propiedades de TRegExpr:

    función VersionMajor  : integer;
    función VersionMinor : integer;

Devuelve versiones mayor y menor, por ejemplo, para v. 0.944
VersionMajor = 0 y VersionMinor = 944

    propiedad Expression : string

Expresión regular.

Para optimización, TRegExpr la compilará automáticamente en 'P-code' (se
puede ver con el método Dump) y la almacena en estructuras internas. La
\[re\]compilación real ocurre sólo cuando es necesario - al llamar a
Exec\[Next\], Substitute, Dump, etc y sólo si Expression u otra
propiedad P-code fue modificada después de la última \[re\]compilación.

Si se produce cualquier error durante la \[re\]compilación de llama al
método Error (por defecto Error genera una excepción - ver abajo)

    propiedad ModifierStr : string

valores por defecto para los modificadores de e.r. El formato de la
cadena es similar a (?ismx-ismx). Por ejemplo ModifierStr := 'i-x'
activa el modificador /i, desactiva /x y deja sin cambios el resto.

Si se intenta cambiar un modificador inexistente, se llamará al
procedimiento Error (por defecto Error genera una excepción ERegExpr).

    propiedad ModifierI : boolean

Modificador /i <a name="modifier_i"></a> - ("insensible a mayúsculas"), inicializado por el valor
de RegExprModifierI.

    propiedad ModifierR : boolean

Modificador /r - <a name="#modifier_r"></a> ("Extensiones para Ruso"), inicializado con el valor de
RegExprModifierR.

 

propiedad ModifierS : boolean

Modificador /s - '.' funciona como cualquier char (no encuentra
Separadores de línea y LinePairedSeparator), inicializado con el valor
de RegExprModifierS.

 

propiedad ModifierG : boolean;

Modificador /g Desactiva el modificador /g cambiando todos los
operadores a estilo no voraz, entonces si ModifierG = False todos los
'\*' trabajan como '\*?', todos los '+' como '+?', etc, inicializado con
el valor de RegExprModifierG.

 

propiedad ModifierM : boolean;

Modificador /m Tratamiento de cadenas como líneas múltiples. Esto es,
cambia \`^' y \`$' de encontrar sólo al inicio o final de la cadena al
inicio o final de cualquier salto de línea DENTRO de la cadena,
inicializado con el valor de RegExprModifierM.

 

propiedad ModifierX : boolean;

Modificador /x - ("sintaxis eXtendida"), inicializado con
RegExprModifierX.

 

función Exec (const AInputString : string) : boolean;

ejecuta el programa sobre la cadena AInputString. Exec guarda
AInputString en la propiedad InputString.

 

función ExecNext : boolean;

busca la siguiente coincidencia:

   Exec (AString); ExecNext;

funciona igual que

   Exec (AString);

   if MatchLen \[0\] = 0 then ExecPos (MatchPos \[0\] + 1)

    else ExecPos (MatchPos \[0\] + MatchLen \[0\]);

pero es más simple !

 

función ExecPos (AOffset: integer = 1) : boolean;

busca coincidencias en InputString comenzando el la posición AOffset

(AOffset=1 - primer caracter de InputString)

 

propiedad InputString : string;

devuelve la cadena corriente (desde la última llamada a Exec o la última
asignación a esta propiedad).

Cualquier asignación de esta propiedad limpia las propiedades Match\* !

 

función Substitute (const ATemplate : string) : string;

Devuelve ATemplate con '$&' o '$0' reemplazados por la ocurrencia
completa de la e.r. y '$n' reemplazado por la ocurrencia de la
subexpresión \#n.

Desde la v.0.929 '$' se usa en vez de '\\' (para ampliaciones futuras y
por mayor compatibilidad con Perl) y acepta más de un dígito.

Si es necesario incluir en la plantilla los símbolos '$' o '\\', usar el
prefijo '\\'

Ejemplo: '1\\$ es $2\\\\rub\\\\' -> '1$ es <Match\[2\]>\\rub\\'

Si hay que incluir un dígito después de '$n' se debe delimitar n con
llaves '{}'.

Ejemplo: 'a$12bc' -> 'a<Match\[12\]>bc', 'a${1}2bc' ->
'a<Match\[1\]>2bc'.

 

procedimiento Split (AInputStr : string; APieces : TStrings);

Parte AInputStr en APieces por las ocurrencias de la e.r.

Internamente llama a Exec\[Next\]

 

function Replace (AInputStr : RegExprString;

 const AReplaceStr : RegExprString;

 AUseSubstitution : boolean = False) : RegExprString;

Devuelve AInputStr con las ocurrencias de la e.r. reemplazadas por
AReplaceStr

Si AUseSubstitution es verdadero se usa AReplaceStr como plantilla para
métodos de sustitución.

Por ejemplo:

 Expression := '({-i}block|var)\\s\*\\(\\s\*(\[^ \]\*)\\s\*\\)\\s\*';

 Replace ('BLOCK( test1)', 'def "$1" value "$2"', True);

  devolverá:  def 'BLOCK' value 'test1'

 Replace ('BLOCK( test1)', 'def "$1" value "$2"', False)

  devolverá:  def "$1" value "$2"

Internamente llama a Exec\[Next\]

 

propiedad SubExprMatchCount : integer; // ReadOnly

Número de subexpresiones que han sido encontradas en la última llamada a
Exec\*.

Si no hay subexpresiones pero se encontró la expresión entera (Exec\*
devolvió True), entonces SubExprMatchCount=0, si no hay subexpresiones
ni expresión completa de la e.r. encontradas (Exec\* devolvió False)
entonces SubExprMatchCount=-1.

Por ejemplo: Expression := '(1)?2(3)?';

Exec ('123'): SubExprMatchCount=2, Match\[0\]='123', \[1\]='1',
\[2\]='3'

Exec ('12'): SubExprMatchCount=1, Match\[0\]='12', \[1\]='1'

Exec ('23'): SubExprMatchCount=2, Match\[0\]='23', \[1\]='', \[2\]='3'

Exec ('2'): SubExprMatchCount=0, Match\[0\]='2'

Exec ('7') - devuelve False: SubExprMatchCount=-1

 

propiedad MatchPos \[Idx : integer\] : integer; // ReadOnly

Ubicación de inicio de la subexpresión número \#Idx en la ejecución de
la última llamada a Exec\*. La primera subexpresión tiene Idx=1, la
última es igual a MatchCount, la e.r. completa tiene Idx=0.

Devuelve -1 si en la e.r. no hay subexpresiones o no se encontraron en
la cadena ingresada.

 

propiedad MatchLen \[Idx : integer\] : integer; // ReadOnly

Longitud de la cadena de la subexpresion número Idx en la ejecución de
la última llamada a Exec\*. La primera subexpresión tiene Idx=1, la
última es igual a MatchCount, la e.r. completa tiene Idx=0.

Devuelve -1 si en la e.r. no hay subexpresiones o no se encontraron en
la cadena ingresada.

 

propiedad Match \[Idx : integer\] : string; // ReadOnly

== Copy(InputString, MatchPos \[Idx\], MatchLen \[Idx\])

Devuelve -1 si en la e.r. no hay subexpresiones o no se encontraron en
la cadena ingresada.

 

función LastError : integer;

Devuelve el código de identificación del último error, 0 si no hay
errores (No se puede usar si el método Error genera una excepción) y
limpia el status interno a 0 (sin errores).

 

función ErrorMsg (AErrorID : integer) : string; virtual;

Devuelve el mensaje de error de código AErrorID.

 

propiedad CompilerErrorPos : integer; // ReadOnly

Devuelve la posición en la e.r. donde se detuvo el compilador.

Util para diagnosticar errores.

 

propiedad SpaceChars : RegExprString

Contiene los caracteres que son tratados como \\s (inicializada con la
constante global RegExprSpaceChars)

 

propiedad WordChars : RegExprString;

Contiene los caracteres que son tratados como \\w (inicializada con la
constante global RegExprWordChars)

<a name="line_separators"></a> 

    propiedad LineSeparators : RegExprString

Caracteres que son separadores de línea (como \\n en Unix), inicializada
con la constante global RegExprLineSeparators)

Ver separadores de línea

 

propiedad LinePairedSeparator : RegExprString

Pares de separadores de línea (como \\r\\n en DOS y Windows).

Debe contener exactamente dos caracteres o ninguno, inicializada con la
constante global RegExprLinePairedSeparator)

Ver separadores de línea

 

Por ejemplo, si se necesita comportamiento tipo Unix asignar a
LineSeparators := \#$a (caracter de línea nueva) y a LinePairedSeparator
:= '' (cadena vacía), si se quiere aceptar como separadores de línea
\\x0D\\x0A pero no \\x0D o \\x0A solos, entonces asignar LineSeparators
:= '' (cadena vacía) y a LinePairedSeparator := \#$d\#$a.

 

Por defecto se usa el modo 'mixto' (definido en las constantes globales
RegExprLine\[Paired\]Separator\[s\]): LineSeparators := \#$d\#$a;
LinePairedSeparator := \#$d\#$a. El comportamiento de este modo es
descripto con más detalle en la sección sintaxis.

 

función de clase InvertCaseFunction  (const Ch : REChar) : REChar;

Convierte Ch en mayúsculas si está en minúsculas o en minúsculas si está
en mayúsculas (usa la configuración local corriente)

 

propiedad InvertCase : TRegExprInvertCaseFunction;

Activar esta propiedad si se desea anular la funcionalidad de
insensibilidad a mayúsculas.

Create la inicializa a RegExprInvertCaseFunction (InvertCaseFunction por
defecto)

 

procedimiento Compile;

\[Re\]compila la e.r. Util para editores GUI de e.r. (para controlar la
validez de todas las propiedades).

 

función Dump : string;

Descarga una e.r. compilada en una forma vagamente comprensible.

### Constantes globales

Valores por defecto de los modificadores:

    RegExprModifierI : boolean = False;                // TRegExpr.ModifierI
    RegExprModifierR : boolean = True;                // TRegExpr.ModifierR
    RegExprModifierS : boolean = True;                // TRegExpr.ModifierS
    RegExprModifierG : boolean = True;                // TRegExpr.ModifierG
    RegExprModifierM : boolean = False;                //TRegExpr.ModifierM
    RegExprModifierX : boolean = False;                //TRegExpr.ModifierX

RegExprSpaceChars : RegExprString = ' '\#$9\#$A\#$D\#$C;

 // valor por defecto de la propiedad SpaceChars

 

RegExprWordChars : RegExprString =

   '0123456789'

 + 'abcdefghijklmnopqrstuvwxyz'

 + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ\_';

 // valor por defecto de la propiedad WordChars

 //NOTA AYUDA EN ESPAСOL

 // agregar áéíóúсС

 

RegExprLineSeparators : RegExprString =

  \#$d\#$a{$IFDEF UniCode}\#$b\#$c\#$2028\#$2029\#$85{DIF};

 // valor por defecto de la propiedad LineSeparators

 

RegExprLinePairedSeparator : RegExprString =

  \#$d\#$a;

 // valor por defecto de la propiedad LinePairedSeparator

 

RegExprInvertCaseFunction: TRegExprInvertCaseFunction =
TRegExpr.InvertCaseFunction;

 // valor por defecto de la propiedad

 

 

Funciones globales prácticas

 

función ExecRegExpr (const ARegExpr, AInputStr : string) : boolean;

True si la cadena AInputString es encontrada en la e.r. ARegExpr

Se genera una excepción si hay errores de sintaxis en ARegExpr

 

procedure SplitRegExpr (const ARegExpr, AInputSttStr : string; APieces :
TStrings);

Parte la cadena AInputStr en subcadenas APieces por las ocurrencia de la
e.r. ARegExpr

 

función ReplaceRegExpr (const ARegExpr, AInputStr, AReplaceStr : string;

AUseSubstitution : boolean = False) : string;

Devuelve AInputStr con las ocurrencias de la e.r. reemplazadas por
AReplaceStr

Si AUseSubstitution es verdadero AReplaceStr será usado como plantilla
para los métodos de sustitución.

Por ejemplo:

ReplaceRegExpr ('({-i}block|var)\\s\*\\(\\s\*(\[^ \]\*)\\s\*\\)\\s\*',

'BLOCK( test1)', 'def "$1" value "$2"', True)

devolverá:  def 'BLOCK' value 'test1'

ReplaceRegExpr ('({-i}block|var)\\s\*\\(\\s\*(\[^ \]\*)\\s\*\\)\\s\*',

'BLOCK( test1)', 'def "$1" value "$2"')

devolverá:  def "$1" value "$2"

 

 

función QuoteRegExprMetaChars (const AStr : string) : string;

Reemplaza todos los metacaracteres por su representación segura , por
ejemplo 'abc$cd.(' es convertida  en 'abc\\$cd\\.\\('

Esta función es práctica para autogeneración de e.r. a partir de datos
del usuario.

 

función RegExprSubExpressions (const ARegExpr : string;

ASubExprs : TStrings; AExtendedSyntax : boolean = False) : integer;

Genera una lista de subexpresiones encontradas en la e.r. ARegExpr

En ASubExps cada item representa una subexpresión, en el formato:

 String - texto de la subexpresión (sin '()')

 low word of Object - posición inicial en ARegExpr, incluyendo '(' si
existe! (la primera posición es 1)

 high word of Object - longitud, incluyendo el '(' inicial y el ')'
final si existen!

AExtendedSyntax - debe ser True si el modificador /x estará activado
mientras se usa la e.r.

Práctico para editores GUI de e.r., etc (se puede ver un ejemplo de uso
en el proyecto [TestRExp.dpr](#tregexpr_testrexp.html))

 

Resultado                Significado

 

 

0                                Exito. No se encontraron paréntesis
desbalanceados;

-1                                No hay suficientes paréntesis de
cierre ')';

-(n+1)                En la posición n se encontró un '\[' abriendo sin
el correspondiente '\]' de cierre;

n                                En la posición n se encontró un ')'
cerrando sin el correspondiente '(' de apertura.

 

Si el resultado es <> 0, entonces ASubExprs puede contener items
vacíos o ilegales

 

 

Exception type

 

El administrador de errores por defecto de TRegExpr genera una
excepción:

 

ERegExpr = class (Exception)

  public

   ErrorCode : integer; // código de error. Los errores de compilación
son menores a 1000.

   CompilerErrorPos : integer; // Posición en la e.r. donde se ocurrió
el error de compilación

 end;

 

 
<a name="unicode"></a>
### Cómo usar Unicode

 

TRegExpr ahora soporta UniCode, pero funciona muy lentamente :(

Quién quiere optimizarlo ? ;)

Usarlo exclusivamente si realmente se necesita soporte de Unicode !

Sacar el '.' en {.$DEFINE UniCode} en regexpr.pas. Después de ésto todas
las cadenas serán tratadas como WideString.

