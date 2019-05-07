.. include:: translation_help.rst

------------

Публични методи и свойства на TRegExpr:
---------------------------------------

::

    property Expression : string 

Представлява самият RE.

С цел оптимизация, присвоявате RE на това свойство, TRegExpr автоматично
го компилира в 'Р-код' (Може да го видите с помощта на метода Dump) и го
записва във  вътрешните си структури. Истинско [ре]компилиране се прави
само когато възникне нужда от това – при извикване на Exec[Next],
Substitute, Dump и т.н. и само ако самият израз или друго свойство,
влияещи върху Р-кода бъдат променени след последната [ре]компилация.

В случай на грешка при [ре]компилиране, се извиква методът Error (по
подразбиране методът Error предизвиква изключение – виж по-долу)

::

    property ModifierStr : string

За проверка/установяване на стойностите на модификаторите на RE.
Форматът на стринга е подобен на този при модификаторите (?ismx-ismx).
Например, ModifierStr := 'i-x' ще включи модификатора /i, ще изключи /x
и няма да промени останалите.

Ако се опитате да зададете непознат модификатор, ще се извика методът
Error (по подразбиране методът Error предизвиква изключение ERegExpr).

::

    property ModifierI : boolean

Модификатор /i – проверка без отчитане главни/малки букви. Приема
начална стойност от RegExprModifierI.

::

    property ModifierR : boolean

Модификатор /r – използване на диапазони за руски език. Приема начална
стойност от RegExprModifierR.

::

    property ModifierS : boolean

Модификатор /s - '.' съвпада с всеки символ (иначе не съвпада с
LineSeparators и LinePairedSeparator). Приема начална стойност от
RegExprModifierS.

::

    property ModifierG : boolean;

Модификатор /g - изключването на /g превключва всички операции в
"нежаден" стил така, че ако ModifierG = False, то всички '*' работят
като '*?', всички '+' като '+?' и т.н. Приема начална стойност от
RegExprModifierG.

::

    property ModifierM : boolean;

Модификатор /m - третира стринга като съставен от много редове. Т.е.
задава за \`^' и \`$' вместо да съвпадат със самото начало или край на
стринга, да съвпадат с началото и края на всяки ред вътре в самия
стринг. Приема начална стойност от RegExprModifierM.

::

    property ModifierX : boolean;

Модификатор /x – eXtended синтаксис. Приема начална стойност от
RegExprModifierX.

::

    function Exec (const AInputString : string) : boolean;

Проверка за съвпадение на RE  с входния стринг AInputString

!!! Exec запазва AInputString в свойството InputString

::

    function ExecNext : boolean;

търси за следващо съвпадение:

::

    Exec (AString); ExecNext;

работи по същия начин, както

::

    Exec (AString);
    if MatchLen \[0\] = 0
     then ExecPos (MatchPos \[0\] + 1)
     else ExecPos (MatchPos \[0\] + MatchLen \[0\]);

но е доста по-просто за разбиране !

::

    function ExecPos (AOffset: integer = 1) : boolean;

Търси за съвпадение на RE с входния стринг, започвайки от позиция
AOffset

(AOffset=1 – първият символ на InputString)

::

    property InputString : string;

текущият входен стринг (присвоен явно или от последния Exec).

сяко присвояване на стринг на това свойство изтрива стойностите на
свойствата Match\* !

::

    function Substitute (const ATemplate : string) : string;

Връща стринга Atemplate, в който '$&' или '$0' е заменено с целия RE, а
'$n' се заменя с подизраза с номер n.

След версия v.0.929 се използва '$' вместо '\' (за бъдещи разширения и
за по-голяма Perl-съвместимост) и приема повече от една цифра.

Ако искате да запишете просто символите '$' или '\', запишете пред тях
'\'

Пример: '1\$ is $2\rub\' -> '1$ is <Match[2]>\rub\'

Ако искате да запишете обикновена цифра след '$n', ще трябва да
заградите n с фигурни скоби '{}'.

Пример: 'a$12bc' -> 'a<Match[12]>bc', a${1}2bc' -> 'a<Match[1]>2bc'.

::

    procedure Split (AInputStr : string; APieces : TStrings);

Разделя AInputStr на парчета в APieces според срещането на RE. Използва
Exec [Next].

::

    function Replace (AInputStr : RegExprString;  const AReplaceStr :

RegExprString;  AUseSubstitution : boolean = False) : RegExprString;

Връща AinputStr, в който срещанията на RE са заменени с AreplaceStr. Ако
AUseSubstitution е true, тогава AReplaceStr ще се използва като шаблон
за методите Substitution.

Пример:
^^^^^^^

::

    Expression := '({-i}block|var)\\s\*\\(\\s\*(\[^ \]\*)\\s\*\\)\\s\*';
    Replace ('BLOCK( test1)', 'def "$1" value "$2"', True);

  ще върне:  ``def 'BLOCK' value 'test1'``

::

    Replace ('BLOCK( test1)', 'def "$1" value "$2"', False)

  ще върне:  ``def "$1" value "$2"``

Използва Exec[Next]

::

    function ReplaceRegExpr (const ARegExpr, AInputStr, AReplaceStr :

string; AUseSubstitution : boolean = False) : string;

Връща AinputStr, в който срещанията на RE са заменени с AreplaceStr. Ако
AUseSubstitution е true, тогава AReplaceStr ще се използва като шаблон
за методите Substitution.

Пример:
^^^^^^^

::

    ReplaceRegExpr ('({-i}block|var)\\s\*\\(\\s\*(\[^ \]\*)\\s\*\\)\\s\*', 'BLOCK( test1)', 'def "$1" value "$2"', True)

   ще върне:  ``def 'BLOCK' value 'test1'``

::

    ReplaceRegExpr ('({-i}block|var)\\s\*\\(\\s\*(\[^ \]\*)\\s\*\\)\\s\*', 'BLOCK( test1)', 'def "$1" value "$2"')

   ще върне:  ``def "$1" value "$2"``

::

    property SubExprMatchCount : integer; // ReadOnly

Връща броя на подизразите, намерени при последното извикване на Exec*.

Ако няма подизрази, а е намерен само целият израз (Exec\* е върнала
True), то SubExprMatchCount=0, а ако не са намерени нито подизрази, нито
целия  RE (Exec\* е върнала false), то ``SubExprMatchCount=-1``.

Забележете, че някои подизрази може и да не бъдат намерени и за тях
``MathPos=MatchLen= -1`` и ``Match=''``.

Пример:
^^^^^^^

::

    Израз := '(1)?2(3)?';
    Exec ('123'): SubExprMatchCount=2, Match\[0\]='123', \[1\]='1', \[2\]='3'
    Exec ('12'): SubExprMatchCount=1, Match\[0\]='12', \[1\]='1'
    Exec ('23'): SubExprMatchCount=2, Match\[0\]='23', \[1\]=", \[2\]='3'
    Exec ('2'): SubExprMatchCount=0, Match\[0\]='2'
    Exec ('7') - връща False: SubExprMatchCount=-1

. property MatchPos [Idx : integer] : integer; // ReadOnly

позиция на намерения подизраз. #Idx е номера на подизраза в последния
стринг на Exec*. Първият подизраз има Idx=1, последния - MatchCount,
целия израз има Idx=0.

Връща -1 ако в израза няма такъв подизраз или ако той не е намерен.

::

    property MatchLen \[Idx : integer\] : integer; // ReadOnly

дължина на намерения подизраз. #Idx е номера на подизраза в последния
стринг на Exec*. Първият подизраз има Idx=1, последния - MatchCount,
целия израз има Idx=0.

Връща -1 ако в израза няма такъв подизраз или ако той не е намерен.

::

    property Match \[Idx : integer\] : string; // ReadOnly

== copy (InputString, MatchPos [Idx], MatchLen [Idx])

Връща '' ако в израза няма такъв подизраз или ако той не е намерен.

::

    function LastError : integer;

Връща номера на последната грешка или 0 ако няма грешки (неизползваем
ако методът Error генерира изключение) и установява вътрешния статус в 0
(няма грешки).

::

    function ErrorMsg (AErrorID : integer) : string; virtual;

Връща съобщение за грешка с номер = AErrorID.

::

    property CompilerErrorPos : integer; // ReadOnly

Връща позицията в израза, където компилаторът е спрял.

Полезно при диагностика на грешки

::

    property SpaceChars : RegExprString

Съдържа символите, третирани като \\s (инициализира се с глобалната
константа RegExprSpaceChars.

::

    property WordChars : RegExprString;

Съдържа символите, третирани като \\w (инициализира се с глобалната
константа   RegExprWordChars.

 

::

    property LineSeparators : RegExprString

разделителите на редове (като \\n в Unix), (инициализира се с глобалната
константа RegExprLineSeparators.

Виж също за разделителите

::

    property LinePairedSeparator : RegExprString

сдвоени разделители на редове (като \\r\n в DOS и Windows).

Трябва да съдържа точно два символа или да не съдържа нищо (инициализира
се с глобалната константа RegExprLinePairedSeparator).

Виж също за разделителите

Например, ако имате нужда от Unix-стил, задайте
``LineSeparators := \#$a`` (символ за нов ред) и
``LinePairedSeparator := ''`` (празен стринг), а ако искате да
обработвате разделителя ``\x0D\x0A``, но не ``\x0D`` или ``\x0A``,
задайте ``LineSeparators := ''`` (празен стринг) и
``LinePairedSeparator := \#$d\#$a``.

По подразбиране се използва 'смесен' режим (дефиниран в глобалните
константи
``RegExprLine\[Paired\]Separator\[s\]): LineSeparators := \#$d\#$a; LinePairedSeparator := $\#d\#$a``.
Действието на този режим е подробно обяснено в раздела, касаещ
синтаксиса.

::

    class function InvertCaseFunction  (const Ch : REChar) : REChar;

Конвертира Ch в горен регистър (ако е бил в долен) или в долен регистър
(ако е бил в горен), като използва системните настройки.

::

    property InvertCase : TRegExprInvertCaseFunction;

Ако искате да работите със зависимост от регистъра на символите,
установете това свойство да сочи RegExprInvertCaseFunction (по
подразбиране сочи InvertCaseFunction)

::

    procedure Compile;

[Ре]компилира RE. Полезна за редактори, използващи RE в GUI (за проверка
на валидността на всички свойства).

::

    function Dump : string;

показва компилираният израз в по-подробен вид.

::

    class function VersionMajor: integer;
    class function VersionMinor: integer;

Връщат главната и второстепенната версия, например за v. 0.944
VersionMajor = 0 и VersionMinor = 944

Глобални константи 
-------------------

 Стойности по подразбиране на модификаторите:

::

    RegExprModifierI : boolean = False;                // TRegExpr.ModifierI
    RegExprModifierR : boolean = True;                // TRegExpr.ModifierR
    RegExprModifierS : boolean = True;                // TRegExpr.ModifierS
    RegExprModifierG : boolean = True;                // TRegExpr.ModifierG
    RegExprModifierM : boolean = False;                //TRegExpr.ModifierM
    RegExprModifierX : boolean = False;                //TRegExpr.ModifierX

    RegExprSpaceChars : RegExprString = ' '\#$9\#$A\#$D\#$C; // стойност по подразбиране за свойството SpaceChars

 

::

    RegExprWordChars : RegExprString =  '0123456789'
     + 'abcdefghijklmnopqrstuvwxyz'
     + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ\_';
    // стойност по подразбиране за свойството WordChars

    RegExprLineSeparators : RegExprString =
       \#$d\#$a{$IFDEF UniCode}\#$b\#$c\#$2028\#$2029\#$85{$ENDIF};
    // стойност по подразбиране за свойството LineSeparators

    RegExprLinePairedSeparator : RegExprString = \#$d\#$a;
    // стойност по подразбиране за свойството LinePairedSeparator

    RegExprInvertCaseFunction : TRegExprInvertCaseFunction = TRegExpr.InvertCaseFunction;
    // стойност по подразбиране за свойството InvertCase

Полезни глобални функции
------------------------

::

    function ExecRegExpr (const ARegExpr, AInputStr : string) : boolean;

връща истина ако в стринга AInputString се открие съвпадение на израза
ARegExpr

! ако в AregExpr има синтактични грешки, генерира изключение

::

    procedure SplitRegExpr (const ARegExpr, AInputStr : string; APieces : TStrings);

разделя AInputStr на парчета в APieces според срещанията на ARegExpr

::

    function ReplaceRegExpr (const ARegExpr, AInputStr, AReplaceStr : string) : string;

Връща AinputStr, като срещанията на израза ARegExpr са заменени с
AReplaceStr

::

    function QuoteRegExprMetaChars (const AStr : string) : string;

Заменя всички метасимволи с тяхната безопасна форма, например 'abc$cd.('
се конвертира в 'abc\$cd\.\('

Тази функция е полезна при автоматично генериране на изрази от
потребителски вход

::

    function RegExprSubExpressions (const ARegExpr : string;
        ASubExprs : TStrings; AExtendedSyntax : boolean = False) : integer;

Прави списък на подизразите, намерени в RE ARegExpr

В ASubExps всяка стойност представлява подизраз, от първия до последния,
във формат:

::

     String – текст на подизраза (без '()')
     low word на Object – стартова позиция в  ARegExpr, вкл. '(' ако съществува! (първата позиция е 1)
     high word на Object - дължината, вкл. '(' и ')' ако съществуват!  
     AExtendedSyntax – трябва да е True ако модификаторът /x е включен при използването на RE.

Полезна за редактори на RE в GUI и т.н. (Пример за използване има в
проекта `TestRExp.dpr <tregexpr_testrexp.html>`__)

Резултат                Значение

::

    0           Успех. Няма намерени небалансирани скоби.
    -1          няма достатъчно затварящи скоби ')'
    -(n+1)     на позиция n е намерена отваряща '\[' без съответстваща й затваряща '\]'
    n           на позиция n е намерена затваряща ')' без съответстваща й отваряща '('

ако резултатът е <> 0, то ASubExpr съдържа празни или некоректни
стрингове.

Клас 'изключение'
~~~~~~~~~~~~~~~~~

Той обработва грешките на TRegExpr:

::

    ERegExpr = class (Exception)
       public
          ErrorCode : integer; // код за грешка. Кодовете за грешка при компилиране са < 1000.
          CompilerErrorPos : integer; // Позиция в израза, където е възникнала грешката
    end;

 

Как да използваме Unicode
-------------------------

TRegExpr поддържа UniCode, но работи с него много бавно :(

Някой иска ли да го оптимизира ? ;)

Използвайте го само ако наистина ви трябва поддръжка на Unicode !

Премахнете ``'.'`` от ``{.$DEFINE UniCode}`` в ``regexpr.pas``. След
това всички стрингове ще бъдат третирани като ``WideString``.
