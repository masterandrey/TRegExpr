      **This is very old and outdated translation.**
      *If you can read English or Russian please use up-to-date* `English version <http://regexpr.masterandrey.com>`_ *or* `Russian version <http://regexpr.masterandrey.com/ru/latest/>`_.

      *If you want to help to update the translation please* `contact me <https://github.com/masterandrey>`_.
      New translation is based on `GetText <https://en.wikipedia.org/wiki/Gettext>`_ and can be edited with `transifex.com <https://www.transifex.com/masterAndrey/tregexpr/dashboard/>`_.
      It is already machine-translated and need only proof-reading and may be some copy-pasting from here.

------------

Q. Comment utiliser TRegExpr avec Borland C++ Builder?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

J'ai un problème depuis qu'il n'y a plus aucun fichier d'en-tête (.h or
.hpp) n'est pas disponible.

R.
^^

-  Ajouter RegExpr.pas au projet bcb.
-  Compiler le projet. Ceci génиre le fichier RegExpr.hpp.
-  Maintenant vous pouvez utiliser l'unité RegExpr.
-  Ne pas oublier d'inclure #include "RegExpr.hpp" au début de votre
   programme.

Q. Pourquoi TRegExpr retourne plus d'une ligne?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Par exemple l'e.r. ``<font .\*>`` retourne le premier ``<font``, et
ensuite le reste du fichier incluant le dernier ``</html>``.

R.
^^

Pour la compatibilité précédente le modifier /s est а ``On`` par défaut.

Le mettre а off et ensuite le ``.`` concordera а tout excepté les
séparateurs de ligne - comme voulu.

Mais je suggère aussi l'e.r. suivante ``<font (\[^\\n>\]\*)>``, dans
Match[1] sera l'url.

Q. Pourquoi TRegExpr retourne plus que prévu?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Par exemple l'e.r. ``<p>(.+)</p>`` appliqué а la chaîne
``<p>a</p><p>b</p>`` retourne ``a</p><p>b`` mais pas ``a`` comme prévu.

R.
^^

Par défaut tous les opérateurs fonctionne en mode "vorace", aussi il
correspond а compare le plus possible. Si vous voulez le mode
"non-vorace" vous pouvez utiliser les opérateurs ``+?`` et ainsi de
suite (nouveau dans la v. 0.940) ou changer tous les opérateurs en mode
"non-vorace" avec l'aide du modifier "g" (utiliser les propriétés
convenablement dans TRegExpr ou avec une inscription dans l'e.r. comme
``?(-g)``).

Q. Comment analyser des sources comme du HTML avec l'aide deTRegExpr
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

R.
^^

Désolé les gars, mais c'est pratiquement impossible!

Bien sur que vous pouvez utiliser TRegExpr pour extraire des
informations comme démontré dans mes exemples, mais si vous voulez faire
une analyse précise, vous devez utiliser un vrai analyseur, pas l'e.r.!

Vous pouvez lire les explications de Tom Christiansen et Nathan
Torkington dans le document ``Perl Cookbook``, par exemple. Pour faire
une histoire courte, il y a plusieurs expressions qui peuvent être
analyser facilement avec un vrai analyseur mais pas toutes par e.r., et
les vrai analyseurs sont PLUS rapide pour faire l'analyse, parce que
l'e.r. ne scanne pas l'entrée avant, il fait plutфt une optimisation de
recherche qui peut prendre beaucoup de temps.

Q. Est-ce qu'il y a une façon d'avoir une correspondance multiple d'un modèle sur TRegExpr?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

R.
^^

Vous pouvez faire une loupe et procéder comparaison par comparaison avec
la méthode ExecNext.

ça ne peut être plus fait plus facilement parce que delphi n'est pas un
interpréteur comme Perl (et les interpréteurs fonctionnent généralement
très lentement!).

Si vous voulez quelques exemples, svp visionner la méthode
TRegExpr.Replace. ou aux exemples dans
`HyperLinksDecorator.pas <#hyperlinksdecorator.html>`__.

Q. Je vérifie l'entrée d'utilisateur. Pourquoi TRegExpr retourne 'Vrai' pour une mauvaise chaîne d'entrée?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

R.
^^

Dans plusieurs cas de TRegExpr les utilisateurs oublient qu'une
expression régulière est pour chercher dans les chaînes d'entrées.
Aussi, si vous voulez faire que l'utilisateur entre seulement 4
caractères numérique et que vous utiliser l'expression ``\\d{4,4}``,
vous pouvez ignorer les mauvaises entrées comme ``12345`` ou 'n'importe
quel caractère 1234 et n'importe quoi'. Vous devez ajouter une
vérification pour le début et la fin de la ligne et vous assurer qu'il
n'y a rien d'autre comme dans l'expression suivante: ``^\\d{4,4}$``.

Q. Pourquoi que le mode non-vorace quelquefois fonctionne comme le mode vorace?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Par exemple, l'e.r. ``a+?,b+?`` appliqué а ``aaa,bbb`` retourne
``aaa,b``, mais normalement ne devrait-il pas retourner ``a,b`` а cause
de la nature non-vorace du premier itérateur ?

R.
^^

C'est une limite d'utilisation par la mathématique de TRegExpr (et
plusieurs autre comme Perl et Unix). E.r. effectue seulement une
'simple' optimisation de recherche, et ne tente pas d'obtenir la
meilleure optimisation. Dans plusieurs cas ce n'est pas bon, mais en
général cette limite est plutфt avantageuse, а cause des performances et
des prévisions de raison.

La règle générale est que premièrement e.r. essaie de trouver une
correspondance а partir de sa position actuelle et seulement si c'est
complètement impossible de trouver une correspondance alors il avance
d'un caractère et réessaie de nouveau а partir de cet emplacement. Aussi
si vous utiliser ``a,b+?`` il correspondra avec ``a,b``, mais dans le
cas de ``a+?,b+?`` ce 'n'est pas recommandé' (а cause du mode
non-vorace) mais possible de correspondre а plus d'un ``a``, aussi
TRegExpr le fait mais le résultat obtenu ne sera pas une correspondance
optimum. TRegExpr comme Perl ou les e.r. de Unix ne tente pas de bouger
en avant et vérifier qu'est-ce qu'il serait la meilleure correspondance.
De plus, il ne peut comparer en terme ``plus ou moins bon``.

SVP, lire le section `Syntaxe <regular_expressions.html>`__ du fichier d'aide
pour plus d'explication.
