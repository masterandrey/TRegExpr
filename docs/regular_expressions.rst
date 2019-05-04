      **This is very old and outdated translation.**
      *If you can read English or Russian please use up-to-date* `English version <http://regexpr.masterandrey.com>`_ *or* `Russian version <http://regexpr.masterandrey.com/ru/latest/>`_.

      *If you want to help to update the translation please* `contact me <https://github.com/masterandrey>`_.
      New translation is based on `GetText <https://en.wikipedia.org/wiki/Gettext>`_ and can be edited with `transifex.com <https://www.transifex.com/masterAndrey/tregexpr/dashboard/>`_.
      It is already machine-translated and need only proof-reading and may be some copy-pasting from here.

------------

Introduction
------------

Les Expressions Régulières sont grandement utilisées pour spécifier des
type de recherches pour le texte. Les métacaractères spéciaux vous
permettent de spécifier, par exemple, qu'une chaîne particulière que
vous chercher se trouve au début ou а la fin d'une ligne, ou contient n
récurrence d'un certain caractère.

Les Expressions Régulières ressemblent vraiment а du charabia pour les
débutants, mais elles sont réellement simples (bien, habituellement), et
sont un outil pratique et puissant.

Je recommande fortement de vous amuser avec le demo Windows
`REStudio <https://github.com/masterandrey/TRegExpr/releases/download/0.952b/REStudio.exe>`__
- il vous aidera а comprendre le concept principal. De plus, il y a
plusieurs exemple prédéfinis avec des commentaires inclus dans TestRExp.

Commençons notre voyage d'apprentissage!

Simple comparaison
------------------

Un simple se compare а lui-même, sauf s'il est un métacaractère avec une
spécification spéciale décris plus bas.

Une série de caractère se compare а la même série de caractère dans la
chaîne de destination, aussi le gabarit ``bluh`` se compare а ``bluh``
dans la chaîne de destination. Relativement simple, n'est-ce pas ?

Vous pouvez obliger les métacaractères ou les Séquences d'échappements а
être interprétés littéralement avec un 'échappement' en les précédents
avec une barre oblique inverse ``\``, par exemple: le métacaractère
``^`` normalement se compare au début de ligne, mais "\^" se compare au
caractère ``^``, ``\`` se compare а ``\`` et ainsi de suite.

Exemples:
^^^^^^^^^

::

    foobar      compare la chaоne 'foobar'
    \^FooBarPtr     compare la chaоne '^FooBarPtr'

Séquences d'échappements
~~~~~~~~~~~~~~~~~~~~~~~~

Les caractères peuvent être spécifiés avec une Séquence d'échappement
comme celles utilisé dans le langage C et Perl: ``\n`` se compare а une
nouvelle ligne, ``\t`` а une tabulation, etc... Plus généralement,
``\xnn``, où nn est un nombre hexadécimal, se compare aux caractères
ASCII avec une valeur dans nn. Si vous avez besoin des caractères large
(wide, ou Unicode), vous pouvez utiliser ``\x{nnnn}``, d'où ``nnnn`` -
un nombre de plus ou moins 4 caractères numérique hexadécimal.

::

     \xnn     caractère hexa avec le code nn.
     \x{nnnn} caractère hexa avec un code nnnn (un octet pour le texte ordinaire et 2 octets pour l'Unicode).
     \t       Tabulation horizontale (HT/TAB), même chose que \x09.
     \n       Nouvelle ligne (NL), même chose que \x0a.
     \r       Retour de chariot (CR), même chose que \x0d.
     \f       Avance page (FF), même chose que \x0c.
     \a       Alarme (bell) (BEL), même chose que \x07.
     \e       échappement (ESC), même chose que \x1b.

Exemples:
^^^^^^^^^

::

    foo\x20bar      Se compare а 'foo bar' (noter l'espace dans le milieu).
    \tfoobar        Se compare а 'foobar' prédéfinis avec une tabulation.

Classes de Caractères
---------------------

Vous pouvez spécifier une Classe de caractères, en insérant une liste de
caractères dans ``[]``, lequel comparera tous les caractères inclus dans
la liste.

Si le premier caractère après ``[`` est ``^``, la classe se compare
comme une négation en comparant tous les caractères qui ne sont pas dans
la liste.

Exemples:
^^^^^^^^^

::

    foob[aeiou]r        Trouve les chaоnes 'foobar', 'foober' etc... Mais pas 'foobbr', 'foobcr' etc...
    foob[^aeiou]r       Trouve les chaоnes 'foobbr', 'foobcr' etc. Mais pas 'foobar', 'foober' etc...

Dans une liste, le caractère ``-`` est utilisé pour spécifier une
distance (range), aussi a-z représente tous les caractères entre ``a``
et ``z``, inclusivement.

Si vous voulez que ``-`` soit membre de la classe, veuillez le mettre au
début ou а la fin de la liste, ou encore placer un échappement (``\``)
devant. Si vous voulez un ``]`` vous pouvez le placer au début de la
liste ou le placer avec un échappement ``\``.

Exemples:
^^^^^^^^^

::

    [-az]       Compare 'a', 'z' et '-.'
    [az-]       Compare 'a', 'z' et '-.'
    [a\-z]      Compare 'a', 'z' and '-.'
    [a-z]       Trouve tous les 26 petits caractиres de 'a' а 'z'.
    [\n-\x0D]       Trouve tous les #10,#11,#12,#13.
    [\d-t]      Trouve n'importe quel caractиre numérique, '-' ou 't'. 
    []-a]       Trouve n'importe quel caractиre de ']' а 'a'.

Métacaractères
--------------

Les Métacaractères sont des caractères spéciaux qui sont l'essence même
des expressions régulières. Il y a différents types de métacaractères,
décris plus bas.

Métacaractères - Séparateurs de ligne
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    ^       Au début.
    $       А la fin.
    \A      Début du texte.
    \Z      Fin du texte.
    .       N'importe quel caractиre dans une ligne.

Exemples:
^^^^^^^^^

::

    ^foobar     Trouve la chaоne 'foobar' seulement s'il est au début.
    foobar$     Trouve la chaоne 'foobar' seulement s'il est а la fin.
    ^foobar$        Trouve la chaоne 'foobar' seulement s'il y a ce mot.
    foob.r      Trouve les chaоnes comme 'foobar', 'foobbr', 'foob1r' et ainsi de suite.

Le métacaractère ``^`` par défaut garantie de trouver le mot seulement
s'il est au début de la chaîne ou du texte, le métacaractère ``$``
seulement а la fin. Les séparateurs de ligne inclus dans le texte ne
sont pas considérés comme valable par ``^`` ou ``$``, donc la condition
est fausse et la recherche n'est pas valide.

Vous pouvez, toutefois, désirer traiter une chaîne comme une chaîne de
plusieurs ligne de texte, de cette façon ``^``  sera valable après le
séparateur de ligne, et ``$`` sera valable avant un séparateur de ligne.
Vous pouvez faire ceci avec le modifier ``/m``.

Les métacaractères ``\A`` et ``\Z`` sont comme ``^`` et ``$``, excepté
qu'ils fonctionne seulement qu'une seule fois pour tout le texte quand
le modifier ``/m`` est en usage, pendant que ``^`` et ``$`` recherchera
а chaque séparateur de ligne.

Le métacaractère ``.`` par défaut se compare а n'importe quel caractère,
mais si vous mettez а off le modifier ``/s``, les séparateurs de ligne
ne seront plus inclus pour ``.``.

TRegExpr travaille avec les séparateurs de lignes comme recommandé au
site web
`www.unicode.org <http://www.unicode.org/unicode/reports/tr18/>`__:

``^`` est au début de la chaîne d'entrée, et si le modifier ``/m`` est а
On, aussi suivant immédiatement n'importe quelle occurrence de
``\x0D\x0A`` ou ``\x0A`` ou ``\x0D`` (si vous utiliser la Version
Unicode de TRegExpr, et ensuite ``\x2028`` ou  ``\x2029`` ou ``\x0B`` ou
``\x0C`` ou ``\x85``). Noter qu'il n'y a pas de ligne vide dans la
séquence ``\x0D\x0A``.

``$`` est а la fin de la chaîne d'entrée, et si le modifier ``/m`` est а
On, aussi précédant immédiatement n'importe quelle occurrence de
``\x0D\x0A`` ou ``\x0A`` ou ``\x0D`` (si vous utiliser la Version
Unicode de TRegExpr, et ensuite ``\x2028`` ou  ``\x2029`` ou ``\x0B`` ou
``\x0C`` ou ``\x85``). Noter qu'il n'y a pas de ligne vide dans la
séquence ``\x0D\x0A``.

``.`` se compare а n'importe quel caractère, mais si le modifier /s est
a Off "." ne correspondra plus а ``\x0D\x0A`` et ``\x0A`` et ``\x0D``
(si vous utiliser la Version Unicode de TRegExpr, et ensuite ``\x2028``
et  ``\x2029`` et ``\x0B`` et ``\x0C`` et ``\x85``).

Noter que ``^.*$`` (un gabarit de ligne vide) ne correspond pas а une
chaîne vide, mais se compare а une chaîne vide contenant la séquence
``\x0A\x0D``.

Le traitement Multiligne peut facilement être ajusté selon vos besoins
avec l'aide des propriétés LineSeparators et LinePairedSeparator de
TregExpr. Vous pouvez utiliser le style Unix ``\n`` ou seulement le
style DOS/Windows ``\r\n`` ou un mélange des deux (comme décris plus
haut et utilisé par défaut) ou définir vos propres séparateurs!

Métacactères - classes prédéfinies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    \w      Un caractиre alphanumérique (incluant "_").
    \W      Un caractиre non alphanumérique.
    \d      Un caractиre numérique.
    \D      Un caractиre non numérique.
    \s      N'importe quel espace (mкme chose que [ \t\n\r\f]).
    \S      Tout ce qui n'est pas un espace.

Vous pouvez utiliser ``\w``, ``\d`` et ``\s`` а l'intérieur de la classe
de caractères.

Exemples:
^^^^^^^^^

::

    foob\dr     Trouve les chaоne comme 'foob1r', ''foob6r', ... Mais pas 'foobar', 'foobbr', ...
    foob[\w\s]r     Trouve les chaоne comme 'foobar', 'foob r', 'foobbr', ... Mais pas 'foob1r', 'foob=r', ...

TRegExpr utilise les propriétés SpaceChars et WordChars pour définir les
classes de caractères ``\w``, ``\W``, ``\s``, ``\S``, aussi vous pouvez
aisément les redéfinir.

Métacaractères - itérateurs
~~~~~~~~~~~~~~~~~~~~~~~~~~~

N'importe quel item d'une expression régulière peut-être suivi par un
autre type de métacaractère - les itérateurs. En utilisant ces
métacaractères vous pouvez spécifier le nombre de fois que le caractère
précédent sera représenté, métacaractères ou sous expression.

::

    *       Zéro ou plus ("vorace"), similaire а {0,}.
    +       Un ou plus ("vorace"), similaire а {1,}.
    ?       Zéro or un ("vorace"), similaire а {0,1}.
    {n}     Exactement n fois ("vorace").
    {n,}        Au moins n fois ("vorace").
    {n,m}       Au moins n fois mais pas plus de m fois ("vorace").
    *?      Zéro ou plus ("non-vorace"), similaire а {0,}?.
    +?      Un ou plus ("non-vorace"), similaire а {1,}?.
    ??      Zéro ou un ("non-vorace"), similaire а {0,1}?.
    {n}?        Exactement n fois ("non-vorace").
    {n,}?       Au moins n fois ("non-vorace").
    {n,m}?      Au moins n fois mais pas plus de m fois ("non-vorace").

Donc, les nombres dans les accolades de la forme ``{n,m}``, spécifie le
nombre de fois minimum avec la lettre n et le nombre maximum avec la
lettre ``m``. La forme ``{n}`` est équivalente а ``{n,n}`` et correspond
exactement а ``n`` fois. La forme ``{n,}`` correspond а n ou plus. Il
n'y a aucune limite quand а la grosseur de ``n`` et ``m``, mais les
grands nombres prendront beaucoup plus de mémoire et vont ralentir
l'exécution de l'e.r.

Si les accolades apparaissent dans un autre contexte, ils sont traitées
comme un caractère régulier.

Exemples:
^^^^^^^^^

::

    foob.*r     Se compare а 'foobar',  'foobalkjdflkj9r' et 'foobr'.
    foob.+r     Se compare а 'foobar', 'foobalkjdflkj9r' mais pas 'foobr'.
    foob.?r     Se compare а 'foobar', 'foobbr' et 'foobr', mais pas 'foobalkj9r'.
    fooba{2}r       Se compare а 'foobaar'.
    fooba{2,}r      Se compare а 'foobaar', 'foobaaar', 'foobaaaar', etc...
    fooba{2,3}r     Se compare а 'foobaar', ou 'foobaaar', mais pas 'foobaaaar'.

Une petite explication а propos de l'utilisation des termes "non-vorace"
et "vorace". "Vorace" prend autant que possible, "non-vorace" prend
aussi peu que possible. Par exemple, ``b+`` et ``b\*`` appliqué а la
chaîne ``abbbbc`` retourne ``bbbb``, ``b+?`` retourne ``b``, ``b\*?``
retourne une chaîne vide, ``b{2,3}?`` retourne ``bb``, ``b{2,3}``
retourne ``bbb``.

Vous pouvez changer tous les itérateurs en mode "non-vorace" en
utilisant le modifier ``/g``.

Métacaractères - Alternatifs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Vous pouvez spécifier des alternatifs pour le modèle en utilisant ``|``
pour les séparer, donc ``fee|fie|foe`` correspond а ``fee``, ``fie``, ou
``foe`` dans la chaîne de destination (comme ``f(e|i|o)e`` le ferait).
La première alternative inclus tout du délimiteur précédent (``(``,
``["``, ou le début du modèle) jusqu'au premier ``|``, et la dernière
alternative contient tout du dernier ``|`` jusqu'au dernier délimiteur.
Pour cette raison, il est de pratique courante d'inclure les
alternatives dans des parenthèses, pour minimiser le risque de confusion
pour savoir quand c'est le départ et quand c'est la fin.

Les alternatifs sont évalués de gauche а droite, donc la première
alternative trouvé pour la correspondance est celle qui est choisi. Ceci
signifie que les alternatives ne sont pas nécessairement vorace. Par
exemple : quand vous faites correspondre ``foo|foot`` а ``barefoot``,
seulement la partie ``foo`` correspond, comme c'est la première
alternative essayée, elle correspond exactement а la chaîne de
destination. (Ceci ne semble pas important, mais ceci le deviens quand
vous capturer du texte correspondant en utilisant les parenthèses.)

Aussi rappeler vous que ``|`` est interprété comme un littéral entre
``[]``, donc si vous écrivez ``[fee|fie|foe]`` Vous réellement
rechercher pour ``[feio|]``.

Exemples:
^^^^^^^^^

::

    foo(bar|foo) Trouve la chaîne 'foobar' ou 'foofoo'.

Métacaractères - sous expressions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Les parenthèses ``( ... )`` peuvent aussi être utilisées pour construire
des sous expression régulière. (après  l'analyse, vous pouvez trouver
les positions des sous expressions, longueurs et valeurs actuelles dans
MatchPos, MatchLen et les propriétés de Match dans TRegExpr, et les
substituer dans les chaînes du gabarit de TRegExpr.Substitute).

Les Sous expressions sont numérotés de gauche а droite selon les
ouvertures des parenthèses. La première sous expression а le numéro
``1`` (l'e.r. complète a le numéro ``0`` - vous pouvez le substituer
dans TRegExpr.Substitute comme ``$0`` ou ``$&``).

Exemples:
^^^^^^^^^

::

    (foobar){8,10}      Se compare aux chaоnes qui contiennent 8, 9 ou 10 instances de 'foobar'.
    foob([0-9]|a+)r     Trouve la chaоne 'foob0r', 'foob1r' , 'foobar', 'foobaar', 'foobaar', etc...

Métacaractères - Références Précédentes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Les Métacaractères ``\1`` jusqu'а ``\9`` sont interprétés comme des
références précédentes. ``\<n>`` compare la sous expression ``#<n>``
précédente trouvé.

Exemples:
^^^^^^^^^

::

    (.)\\1+         Trouve 'aaaa' et 'cc'.
    (.+)\\1+       Aussi se compare а 'abab' et '123123'.
    (\['"\]?)(\\d+)\\1 Trouve  '"13" (entre guillemets), ou '4' (en apostrophe) ou 77 (sans guillemet ou apostrophe), etc...

Modifier
--------

Les Modifier existe dans le but de changer le comportement de TRegExpr.

Il y a plusieurs façon d'ajuster ces modifier. N'importe quel de ces
modifier peuvent être incorporé dans l'expression régulière elle-même en
utilisant la construction de ``(?...)``.

Aussi, vous pouvez changer la propriété adéquate de TRegExpr (ModifierX
par exemple pour changer ``/x``, ou ModifierStr pour changer tous les
modificateurs ensemble). Les valeurs par défaut de la nouvelle instance
de l'objet TRegExpr sont définis dans les variables globales, par
exemple la variable globale RegExprModifierX définie la valeur
(ModifierX) d'une nouvelle instance de TRegExpr.

i
^

Faire des recherche sans égard а la casse des caractères (utilisant les
ajustements locaux définis dans votre système), voir aussi CasInversé.

m
^

Traite les chaînes comme des ligne multiples. Change la fonction de
``^`` et ``$`` pour chercher uniquement а partir du début ou de la fin
de la chaîne, ce sera maintenant а partir du début d'une ligne ou а la
fin de la ligne, voir aussi Séparateurs de Ligne.

s
^

Traite les chaînes comme une simple ligne de texte. Change la fonction
de ``.`` pour qu'il se compare а n'importe quel caractère, même un
séparateur de ligne (voir aussi Séparateur de Ligne), normalement il
ignorerait les sauts de ligne.

g
^

Modifier non standard. En le mettant а Off vous spécifier de mettre tous
les opérateurs en mode non-vorace (par défaut, ce modifier est а On).
Aussi, si le modifier ``/g`` est а Off, alors ``+`` fonctionne comme
``+?``, ``*`` comme ``*?`` et ainsi de suite...

x
^

étend la lisibilité du modèle en vous permettant des espaces et des
commentaires (voir l'explication plus bas).

r
^

Modificateur non standard. Si ajusté, les distances additionnelles de
``а-я`` inclus les lettres russe ``ё``, ``А-Я``  inclus
additionnellement ``Ё``, et ``а-Я`` inclus tous les symboles russe.

Désolé pour les utilisateurs de l'extérieur, mais ces valeurs sont
ajusté par défaut. Si vous voulez les mettre а off par défaut - changer
la valeur de la variable globale RegExprModifierR.

Le modifier ``/x`` requiert des explications. Il dit а TRegExpr
d'ignorer les espaces qui ne sont pas avec un échappement ou qui ne sont
pas dans une classe. Vous pouvez utiliser ceci pour casser l'expression
régulière en morceaux plus petit et plus lisible. Le caractère ``#`` est
aussi traité comme un métacaractère qui introduit les commentaires, par
exemple:

::

    (
    (abc) \# commentaire 1
      |   \# Vous ne pouvez pas utiliser les espaces pour formater l'e.r. -
    TRegExpr l'ignorera.
    (efg) \# commentaire 2
    )

Ceci signifie que si vous voulez avoir des espace ou des caractères
``#`` dans le modèle (а l'extérieur de la classe, où ils ne sont pas
affectés par ``/x``), que vous aurez а mettre des échappements ou les
encoder avec des valeurs octal ou hexadécimale. Pris ensemble, cette
option va plus loin pour l'écriture d'expressions régulière pour les
rendent plus lisible.

Extensions Perl
---------------

(?imsxr-imsxr)
~~~~~~~~~~~~~~

Vous pouvez l'utiliser dans les e.r. pour les modifier sur le champ. Si
la construction est encapsulé dans une sous expression, alors seulement
la sous expression sera affecté.

Exemples:
^^^^^^^^^

::

    (?i)Saint-Petersburg        Trouve 'Saint-petersburg' et 'Saint-Petersburg'.
    (?i)Saint-(?-i)Petersburg       Trouve 'Saint-Petersburg' mais pas 'Saint-petersburg'.
    (?i)(Saint-)?Petersburg     Trouve 'Saint-petersburg' et 'saint-petersburg'.
    ((?i)Saint-)?Petersburg     Trouve 'saint-Petersburg', mais pas 'saint-petersburg' .

.

(?#text)
~~~~~~~~

Un commentaire, le texte est ignoré. Veuillez noter que TRegExpr ferme
le commentaire aussitфt qu'il voit une parenthèse ``)``, Aussi il n'y a
aucune façon de placer une parenthèse dans le commentaire sans fermer
celui-ci.

N'oubliez pas de lire la `FAQ <faq.html>`__ (spécifiquement la section
'non-vorace' ou cette Question).
