      **This is very old and outdated translation.**
      *If you can read English or Russian please use up-to-date* `English version <http://regexpr.masterandrey.com>`_ *or* `Russian version <http://regexpr.masterandrey.com/ru/latest/>`_.

      *If you want to help to update the translation please* `contact me <https://github.com/masterandrey>`_.
      New translation is based on `GetText <https://en.wikipedia.org/wiki/Gettext>`_ and can be edited with `transifex.com <https://www.transifex.com/masterAndrey/tregexpr/dashboard/>`_.
      It is already machine-translated and need only proof-reading and may be some copy-pasting from here.

------------

Ejemplos simples
~~~~~~~~~~~~~~~~

Si no tiene experiencia con las expresiones regulares, por favor vea la
sección `sintaxis <regular_expressions.html>`__.

Usando las rutinas globales
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Es simple pero poco flexible y efectivo

::

    ExecRegExpr ('\\d{3}-(\\d{2}-\\d{2}|\\d{4})', 'Teléfono: 555-1234');

devuelve True

::

    ExecRegExpr ('^\\d{3}-(\\d{2}-\\d{2}|\\d{4})', 'Teléfono: 555-1234');

devuelve False, porque hay algunos símbolos antes del número de teléfono
y estamos usando el metasímbolo '^' (BeginningOfLine = Inicio de línea)

ReplaceRegExpr ('producto', 'Pruebe producto. producto es el mejor !',
'TRegExpr');

devuelve 'Pruebe TRegExpr. TRegExpr es el mejor !'; ;)

Usando la clase TRegExpr
~~~~~~~~~~~~~~~~~~~~~~~~

Se obtiene todo el poder de la librería

{% highlight pascal linenos %} // Esta simple función extrae todas las
direcciones de email de la cadena ingresada // y devuelve una lista de
estos email en el resultado function ExtraeEmails (const AInputString :
string) : string; const          EmailRE
='[_a-zA-Z\d\-\.]+@[_a-zA-Z\d\-]+(\.[_a-zA-Z\d\-]+)+' var          r :
TRegExpr; begin          Result := '';          r := TRegExpr.Create; //
Crea el objeto          try // asegura la liberación de memoria        
                 r.Expression := EmailRE;                          // La
e.r. se compila automáticamente en estructuras internas                
         // cuando se asigna la propiedad Expression                    
     if r.Exec (AInputString) then                                      
   REPEAT                                                        
 Result := Result + r.Match [0] + ', ';                                
         UNTIL not r.ExecNext;                          finally r.Free;
         end; end; begin          ExtraeEmails ('Mis e-mails son
anso@mail.ru y anso@usa.net');          // devuelve 'anso@mail.ru,
anso@usa.net, ' end. // Nota: la compilación de la r.e. realizada al
asignar ;a propiedad Expression // toma cierto tiempo, si se usa esta
función muchas veces // se sobrecarga inútilmente. // Esto se puede
optimizar significativamente creando el objeto TRegExpr // y
precompilando la expresión durante la inicialización del programa. {%
endhighlight %}   {% highlight pascal linenos %} // Este ejemplo extrae
números de teléfono // y los descompone en partes (códigos de Ciudad y
país, númerotelefónico                ). // Después substituye estas
partes en la máscara ingresada. function ParseTel (const AInputString,
ATemplate : string) : string; const          IntPhoneRE = '(\+\d
\*)?(\(\d+\) \*)?\d+(-\d*)*'; var          r : TRegExpr; begin        
 r := TRegExpr.Create; // Crea el objeto          try // asegura la
liberación de memoria                          r.Expression :=
IntPhoneRE;                          // La e.r. se compila
automáticamente en estructuras internas                          //
cuando se asigna la propiedad Expression                          if
r.Exec (AInputString)                                          then
Result := r.Substitute (ATemplate)                                      
   else Result := '';                          finally r.Free;        
 end; end; begin          ParseTel ('El teléfono de AlkorSoft (proyecto
PayCash) es +7(812) 329-44-69',          'Código de País $1, código de
ciudad $2. El número telefónico completo es $&.');          // devuelve
'Código de País +7, código de ciudad (812) . El número telefónico
completo es +7(812) 329-44-69.' end. {% endhighlight %}

Ejemplos más complejos
~~~~~~~~~~~~~~~~~~~~~~

Se pueden encontrar ejemplos más complejos del uso de TRegExpr en el
proyecto `TestRExp.dpr <#tregexpr_testrexp.html>`__ y
`HyperLinkDecorator.pas <#hyperlinksdecorator.html>`__.

Ver también mis artículos en
`Delphi3000.com <%60http://www.delphi3000.com/member.asp?ID=1300',%60',1,%60'>`__
(Inglés) y `Delphi
Kingdom <%60http://delphi.vitpc.com/mastering/strings_birds_eye_view.htm',%60',1,%60'>`__
(Ruso).

 

Explicación detallada
~~~~~~~~~~~~~~~~~~~~~

Por favor, ver la `descripcion <tregexpr.html>`__ de la
interface de TRegExpr.
