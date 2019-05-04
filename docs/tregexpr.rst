      **This is very old and outdated translation.**
      *If you can read English or Russian please use up-to-date* `English version <http://regexpr.masterandrey.com>`_ *or* `Russian version <http://regexpr.masterandrey.com/ru/latest/>`_.

      *If you want to help to update the translation please* `contact me <https://github.com/masterandrey>`_.
      New translation is based on `GetText <https://en.wikipedia.org/wiki/Gettext>`_ and can be edited with `transifex.com <https://www.transifex.com/masterAndrey/tregexpr/dashboard/>`_.
      It is already machine-translated and need only proof-reading and may be some copy-pasting from here.

------------

Méthodes et propriétés publique de TRegExpr:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    property Expression : string

Fonction
^^^^^^^^

Contient l'expression Régulière. Pour L'optimisation, TRegExpr va
automatiquement le compiler en 'P-code' (vous pouvez le voir avec l'aide
de la méthode Dump) et stocké dans sa structure interne. La vrai
[re]compilation survient quand c'est réellement le cas - en appellant
Exec[Next], Substitute, Dump, etc et seulement si l'expression ou un
autre P-code a affecté les propriétés qui ont été changées après la
dernière [re]compilation.

Erreur
^^^^^^

Si une erreur survient durant la [re]compilation, une méthode d'erreur
est appelée (par défaut une erreur d'exception est levée - voir plus
bas).

::

    property ModifierStr : string

Fonction
^^^^^^^^

Ajuste/récupère les valeurs par défaut des modifications d'e.r.. Le
format de chaîne est similaire а ``(?ismx-ismx)``. Par exemple si
``ModifierStr := 'i-x'`` va mettre а On le modifier ``/i``, а Off ``/x``
et laisser les autres inchangés.

Valeurs Possibles

::

    -i-s-m-x ou ismx ou,...

Valeurs par Défaut

::

    -i-s-m-x

Erreur
^^^^^^

Si vous essayez des modifications non supportées, une erreur sera
appelée (par défaut les erreurs lève une exception dans ERegExpr).

::

    property ModifierI : boolean

Fonction
^^^^^^^^

Modifier /i - ("casse des caractères ignorée"), initialisé avec la
valeur RegExprModifierI.

Valeur par Défaut False

::

    property ModifierR : boolean

Modifier /r - ("extension de syntaxe Russe"), initialisé avec la valeur
RegExprModifierR.

Valeur par Défaut True   property ModifierS : boolean

Fonction
^^^^^^^^

Modifier /s - '.' veut dire n'importe quel caractère (normalement il ne
comprend pas les LinesSeparators et LinePairedSeparator), initialisé
avec la valeur RegExprModifierS.

Valeur par Défaut True

::

    property ModifierG : boolean;

Fonction
^^^^^^^^

Modifier /g. En le mettant а Off tous les opérateurs fonctionne en mode
non-vorace, donc si ModifierG = Faux, alors '*' est comme '*?', tous les
'+' comme '+?' et ainsi de suite, initialisé avec la valeur
RegExprModifierG.

Valeur par Défaut True

::

    property ModifierM : boolean;

Fonction
^^^^^^^^

Modifier /m Traite les chaînes comme des lignes multiples . Ceci fait,
changer \`^' et \`$' de correspondre au début ou а la fin de la chaîne,
а partir d'une nouvelle ligne ou а la fin d'une ligne, initialisé avec
la valeur RegExprModifierM.

Valeur par Défaut False

::

    property ModifierX : boolean;

Fonction
^^^^^^^^

Modifier /x - ("syntaxe étendue"), initialisé avec la
valeurRegExprModifierX.

Valeur par Défaut False

::

    function Exec (const AInputString : string) : boolean;

Fonction
^^^^^^^^

Compare une recherche а la chaîne AInputString.

Note
^^^^

La fonction Exec stocke AInputString dans la propriété InputString.

::

    function ExecNext : boolean;

Fonction
^^^^^^^^

Trouve l'occurrence suivante de Exec(AString);

Note
^^^^

fonctionne comme

::

    Exec (AString);

    if MatchLen \[0\] = 0 then ExecPos(MatchPos \[0\] + 1)
        else ExecPos (MatchPos \[0\] + MatchLen \[0\]);

mais est plus simple !

::

    function ExecPos (AOffset: integer = 1) : boolean;

Fonction
^^^^^^^^

Trouve une occurrence de recherche pour de départ de InputString а
partir de la position Aoffset (AOffset=1 - premier caractère de
InputString).

::

    property InputString : string;

Fonction
^^^^^^^^

Retourne le chaîne d'entrée courante (а partir du dernier appel de Exec
ou de la dernière désignation de cette propriété).

Note
^^^^

Une modification а cette propriété efface les propriétés Match\* !

::

    function Substitute (const ATemplate : string) : string;

Fonction
^^^^^^^^

Retourne ATemplate avec '$&' ou '$0' remplacé par l'occurrence complète
de l'e.r. et '$n' remplacé par l'occurrence de la sous expression #n.

Valeur de Retour
^^^^^^^^^^^^^^^^

Contient la chaîne avec les modification apportées.

Note
^^^^

Depuis la  v.0.929 '$' utiliser plutфt '\' (pour les futures extensions
et pour plus de compatibilité avec Perl) pour accepter plus d'un
caractère numérique.

Si vous voulez placer le gabarit dans le modèle '$' ou '\', utiliser le
préfixe '\'.

Exemple:
^^^^^^^^

::

    '1\\$ is $2\\\\rub\\\\' -> '1$ est <Match\[2\]>\\rub\\'

Si vous voulez placer un caractère numérique après '$n' vous devez
délimiter n avec des accolades '{}'.

Exemple:
^^^^^^^^

::

    'a$12bc' -> 'a<Match\[12\]>bc', 'a${1}2bc' -> 'a<Match\[1\]>2bc'.

    procedure Split (AInputStr : string; APieces : TStrings);

Fonction
^^^^^^^^

Divise AInputStr en pièces dans APieces par les occurrences de l'e.r.

Note
^^^^

Appelé au niveau interne Exec[Next].

::

    function Replace (AInputStr : string; const AReplaceStr : string) : string;

Fonction
^^^^^^^^

Retourne AInputStr avec les occurrences de l'e.r remplacé par
AReplaceStr

Note
^^^^

Appelé au niveau interne Exec[Next].

::

    property SubExprMatchCount : integer; // LectureSeulement

Fonction
^^^^^^^^

Le nombre de sous expressions qui a été trouvé dans la dernière
exécution de Exec*.

Valeur de Retour
^^^^^^^^^^^^^^^^

S'il n'y a aucune sous expression mais que l'expression complète а été
trouvé (Exec\* а retourné vrai), alors SubExprMatchCount=0, si aucune
sous expression et aucune e.r. complète a été trouvé (Exec\* retourne
Faux) alors SubExprMatchCount=-1.

Noter que quelques sous expressions peuvent ne pas être trouvées et pour
de telles sous expressions, MathPos=MatchLen=-1 and Match=''.

Par exemple:
^^^^^^^^^^^^

::

    L'Expression := '(1)?2(3)?';
    Exec ('123'): SubExprMatchCount=2, Match\[0\]='123', \[1\]='1', \[2\]='3'
    Exec ('12'): SubExprMatchCount=1, Match\[0\]='12', \[1\]='1'
    Exec ('23'): SubExprMatchCount=2, Match\[0\]='23', \[1\]='', \[2\]='3'
    Exec ('2'): SubExprMatchCount=0, Match\[0\]='2'
    Exec ('7') - return False: SubExprMatchCount=-1

    property MatchPos \[Idx : integer\] : integer; // LectureSeulement

Fonction
^^^^^^^^

La position d'entrée de la sous expression #Idx en test а la dernière
exécution de Exec*.

Paramètre
^^^^^^^^^

La première sous expression a une valeur de Idx=1, dernière -
MatchCount, l'e.r. a une valeur de Idx=0.

Valeur de Retour
^^^^^^^^^^^^^^^^

Retourne -1 si dans l'e.r. il n'y a pas de sous expression trouvée dans
la chaîne.

::

    property MatchLen \[Idx : integer\] : integer; // Lecture Seulement

Fonction
^^^^^^^^

La longueur d'entrée de la sous expression #Idx e.r. en test а la
dernière exécution de Exec*. La première sous expression a la valeur
Idx=1, dernière - MatchCount, l'e.r. entière a une valeur de Idx=0.

Valeur de Retour
^^^^^^^^^^^^^^^^

Retourne -1 si dans l'e.r. il n'y a pas de sous expression ou que cette
expression n'as pas été trouvé dans la chaîne.

::

    property Match \[Idx : integer\] : string; // Lecture Seulement

Fonction
^^^^^^^^

== copy (InputString, MatchPos [Idx], MatchLen [Idx])

Valeur de Retour
^^^^^^^^^^^^^^^^

Retourne '' si dans l'e.r. il n'y a pas de sous expression ou que la
sous expression n'as pas été trouvé dans la chaîne.

::

    function LastError : integer;

Fonction
^^^^^^^^

Retourne l'ID de la dernière erreur, 0 s'il y a aucune erreur
(inutilisable si l'erreur a générée une erreur d'exception) et efface la
valeur interne а 0 (pas d'erreur).

::

    function ErrorMsg (AErrorID : integer) : string; virtual;

Fonction
^^^^^^^^

Retourne un message d'erreur pour l'erreur avec ID = AErrorID.

::

    property CompilerErrorPos : integer; // Lecture Seulement

Fonction
^^^^^^^^

Retourne la position dans l'e.r. ou le compilateur a stoppé. Très
pratique pour diagnostiquer les erreurs.

::

    property SpaceChars : RegExprString

Fonction
^^^^^^^^

Contient les caractères  traités comme \\s (initialement remplit avec
les valeurs de la variable globale RegExprSpaceChars).

::

    property WordChars : RegExprString;

Fonction
^^^^^^^^

Contient les caractères traités comme  \w (initialement remplit avec les
valeurs de la variable globale RegExprWordChars).

::

    property LineSeparators : RegExprString

Fonction
^^^^^^^^

Les séparateurs de ligne (comme Unix \\n), initialement remplit avec les
valeurs de la variable globale RegExprLineSeparators). Voir aussi a
propos des séparateurs de ligne.

::

    property LinePairedSeparator : RegExprString

Fonction
^^^^^^^^

Paire de séparateur de ligne (pour le Dos et Windows \\r\n). Doit
contenir exactement deux caractères ou pas de caractères du tout,
initialement remplit avec les valeurs de la variable globale
RegExprLinePairedSeparato). Voir aussi a propos des séparateurs de
ligne.

Note
^^^^

Par exemple, si vous avez besoin du style Unix, assigner а
LineSeparators := #$a (caractère de nouvelle ligne) et
LinePairedSeparator := '' (chaîne vide), si par contre vous voulez
accepter les séparateurs "\x0D\x0A" mais pas "\x0D" ou "\x0A" seul,
alors assigner LineSeparators := '' (chaîne vide) et LinePairedSeparator
:= #$d#$a.

Par défaut le mode 'mixe' est utilisé (définit par défaut dans les
constantes globales RegExprLine[Paired]Separator[s]): LineSeparators :=
#$d#$a; LinePairedSeparator := #$d#$a. Le comportement de ce mode est
décris dans la section syntaxe.

::

    class function InvertCaseFunction  (const Ch : REChar) : REChar;

Fonction
^^^^^^^^

Convertit Ch en majuscule si c'est minuscule et vice-versa (en utilisant
les ajustement du système local).

::

    property InvertCase : TRegExprInvertCaseFunction;

Fonction
^^^^^^^^

Ajuster cette propriété si vous voulez éviter la fonctionnalité de
l'ignorance des minuscules/majuscules.

Note
^^^^

Crée une interdiction а la fonction RegExprInvertCaseFunction
(InvertCaseFunction par défaut).

::

    procedure Compile;

Fonction
^^^^^^^^

[Re]compile l'e.r. Très pratique pour les applications qui utilise les
éditeurs graphique pour vérifier la validité des propriétés.

::

    function Dump : string;

Fonction
^^^^^^^^

Crée pour le visionnement une e.r. compilée en une forme plus
compréhensive.

Constantes Globales
~~~~~~~~~~~~~~~~~~~

 Valeurs par défaut des Modifiers:

::

    RegExprModifierI : boolean = False;                // TRegExpr.ModifierI
    RegExprModifierR : boolean = True;                // TRegExpr.ModifierR
    RegExprModifierS : boolean = True;                // TRegExpr.ModifierS
    RegExprModifierG : boolean = True;                // TRegExpr.ModifierG
    RegExprModifierM : boolean = False;                //TRegExpr.ModifierM
    RegExprModifierX : boolean = False;                //TRegExpr.ModifierX

    RegExprSpaceChars : RegExprString = ' '\#$9\#$A\#$D\#$C;  // Valeur par défaut pour la propriété SpaceChars

    RegExprWordChars : RegExprString = '0123456789'
      + 'abcdefghijklmnopqrstuvwxyz'
      + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ\_';
      // Valeur par défaut pour la propriété WordChars

     RegExprLineSeparators : RegExprString =
       \#$d\#$a{$IFDEF UniCode}\#$b\#$c\#$2028\#$2029\#$85{$ENDIF};
      // Valeur par défaut pour la propriété LineSeparators

     RegExprLinePairedSeparator : RegExprString =   \#$d\#$a;
      // Valeur par défaut pour la propriété LinePairedSeparator

     RegExprInvertCaseFunction : TRegExprInvertCaseFunction =
    TRegExpr.InvertCaseFunction;
      // Valeur par défaut pour la propriété InvertCase

Fonctions globales pratiques
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    function ExecRegExpr (const ARegExpr, AInputStr : string) : boolean;

Fonction
^^^^^^^^

Retourne vrai si la chaîne AInputString concorde а l'expression
ARegExpr.

Note
^^^^

!Va lever une exception s'il y a une erreur de syntaxe dans ARegExpr.

::

    procedure SplitRegExpr (const ARegExpr, AInputStr : string; APieces : TStrings);

Fonction
^^^^^^^^

Sépare AInputStr en pièces dans APieces par les occurrences de l'e.r.
ARegExpr.

::

    function ReplaceRegExpr (const ARegExpr, AInputStr, AReplaceStr : string) : string;

Fonction
^^^^^^^^

Retourne AInputStr avec l'occurrence de l'e.r. remplacé par AReplaceStr.

::

    function QuoteRegExprMetaChars (const AStr : string) : string;

Fonction
^^^^^^^^

Remplace tous les métacaractères avec une représentation simple, par
exemple 'abc$cd.(' est converti en 'abc\$cd\.\('.

Note
^^^^

Cette fonction est très pratique pour l'autogénération d'e.r. а partir
d'entrée utilisateur.

::

    function RegExprSubExpressions (const ARegExpr : string; ASubExprs :
        TStrings; AExtendedSyntax : boolean = False) : integer;

Fonction
^^^^^^^^

Fabrique une liste de sous expression trouvé dans l'e.r. ARegExpr.

Note
^^^^

Dans ASubExps chaque item représente une sous expression, а partir de la
première jusqu'а la dernière, dans le format:

::

    Chaоne      -       texte de sous expression (sans les '()').
    bas mot de l'objet      -       position de dйpart dans ARegExpr, incluant  '(' s'il existe ! (la premiиre position est 1).
    haut mot de l'objet     -       La longueur, incluant le dйpart '(' et la fin ')' s'il existent!
    AExtendedSyntax     -       Doit кtre Vrai si le modifier /x est а On durant l'utilisation de l'e.r.

Utile pour les éditeurs avec interface graphique (Vous pouvez trouver un
exemple d'utilisation dans le projet
`TestRExp.dpr <tregexpr_testrexp.html>`__).

Code Résultat : Sens

0 : Succčs. Pas de parenthčse non balancées trouvé.

-1 : Il n'a pas assez de parenthčse de fermeture.

-(n+1) : Ŕ la position n était trouvé '[' sans fermeture ']'.

n : Ŕ la position n était trouvé ')' sans ouverture '('.

Si le résultat <> 0, alors ASubExprs peut contenir des items vide ou de
items illégaux.

Type d'exception
~~~~~~~~~~~~~~~~

Routine par Défaut des erreurs d'exception pour TRegExpr:

::

    ERegExpr = class (Exception)
       public
        ErrorCode : integer; // code d'erreur. Les erreurs de compilation du code sont avant 1000.
        CompilerErrorPos : integer; // Position dans l'e.r. où l'erreur est survenue.
      end;

Comment utiliser les Unicode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

TRegExpr supporte maintenant les UniCode, mais il travaille très
lentement.

Qui veut se risquer а l'optimiser ?

L'utiliser seulement si vous avez vraiment besoin du support des Unicode
!

Pour utiliser les WideString, enlever le '.' dans {.$DEFINE UniCode}
dans le fichier regexpr.pas.

 
