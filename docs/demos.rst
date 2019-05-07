.. include:: translation_help.rst

------------

Simple illustrations
~~~~~~~~~~~~~~~~~~~~

Si vous n'êtes pas familier avec les expressions régulières, svp, aller
au sujet `syntaxe <regular_expressions.html>`__.

Utiliser les routines globales

C'est simple mais pas une façon flexible et pratique.

::

    ExecRegExpr ('\\d{3}-(\\d{2}-\\d{2}|\\d{4})', 'Téléphone: 555-1234');

retourne Vrai

::

    ExecRegExpr ('^\\d{3}-(\\d{2}-\\d{2}|\\d{4})', 'Téléphone: 555-1234');

  retourne Faux, parce qu'il y a des symboles avant le numéro de
téléphone on utilise le métasymbole '^' (qui signifie début de ligne).

ReplaceRegExpr ('au produit', 'Tendez un regard au produit. TRegExpr est
le meilleur!', 'а TRegExpr');

  retourne 'Tendez un regard а TRegExpr. TRegExpr est le meilleur !'.

Utiliser la classe TRegExpr
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Vous avez tout le pouvoir de la librairie.

{% highlight pascal linenos %} // Cette simple fonction extrait tous les
e-mail de la chaîne d'entrée. // et place la liste de tous les e-mail
dans la chaîne sortante. function ExtractEmails (const AInputString :
string) : string; const          EmailRE =
'[_a-zA-Z\d\-\.]+@[_a-zA-Z\d\-]+(\.[_a-zA-Z\d\-]+)+' var          r :
TRegExpr; begin          Result := '';          r := TRegExpr.Create; //
Crée L'objet          try // s'assure de la relвche de mémoire en cas
d'erreurs d'exceptions.                          r.Expression :=
EmailRE;                          // Assigne le code source а l'e.r. Il
sera compilé quand ce sera nécessaire                          // (par
exemple quand Exec sera appelé). S'il y a des erreurs dans l'e.r.      
                   // Des exceptions seront levées durant la compilation
de l'e.r.                          if r.Exec (AInputString) then        
                                 REPEAT                                
                         Result := Result + r.Match [0] + ', ';        
                                 UNTIL not r.ExecNext;                  
       finally r.Free;          end; end; begin          ExctractEmails
('My e-mails is anso@mail.ru and anso@usa.net');          // retourne
'anso@mail.ru, anso@usa.net, ' end. // Noter: La compilation de l'e.r.
durant l'attribution de l'expression // prend quelque temps , si vous
voulez utiliser cette fonction plusieurs fois // ce sera du travail
inutile... // Pour l'optimiser de façon significative, créer TRegExpr //
et précompiler l'expression durant la phase d'initialisation du
programme. {% endhighlight %}   {% highlight pascal linenos %} // Ce
simple exemple extrait les numéros de téléphone et // l'analyse en
partie (code régional, ville, numéro interne). // Ensuite il substitut
les parties en gabarit. function ParsePhone (const AInputString,
ATemplate : string) : string; const          IntPhoneRE = '(\+\d
\*)?(\(\d+\) \*)?\d+(-\d*)*'; var          r : TRegExpr; begin        
 r := TRegExpr.Create; // Crée l'objet          try // s'assure de la
relвche de mémoire en cas d'erreursd'exceptions.                        
 r.Expression := IntPhoneRE;                          // Assigne le code
source а l'e.r. Il sera compilé quand nécessaire                        
 // (par exemple quand Exec sera appelé). S'il y a des erreurs dans
l'e.r.                          // Des exceptions seront levées durant
la compilation de l'e.r.                          if r.Exec
(AInputString)                                          then Result :=
r.Substitute (ATemplate)                                          else
Result := '';                          finally r.Free;          end;
end; begin          ParsePhone ('Phone of AlkorSoft (project PayCash) is
+7(812) 329-44-69',          'Zone code $1, city code $2. Whole phone
number is $&.');          // retourne 'Code Régional +7, Code de Ville
(812) . Téléphone complet +7(812) 329-44-69.' end. {% endhighlight %}

Ilustrations plus complexes
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Vous pouvez trouver des illustrations plus complexes pour utiliser
TRegExpr dans le projet `TestRExp.dpr <tregexpr_testrexp.html>`__  et
`HyperLinkDecorator.pas <#hyperlinksdecorator.html>`__.

Voir aussi mon petit article а
`Delphi3000.com <%60http://www.delphi3000.com/member.asp?ID=1300',%60',1>`__
(en Anglais) et `Delphi
Kingdom <%60http://delphi.vitpc.com/mastering/strings_birds_eye_view.htm',%60',1>`__
(en Russe).

Explication plus détaillée

 

Svp, voir la `description <tregexpr.html>`__ d'interface de
TregExpr.

 
