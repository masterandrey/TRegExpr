Introducción
------------

Las Expresiones Regulares son un método ampliamente empleado para
especificar "plantillas" de texto a buscar. Los metacaracteres
especiales permiten especificar, por ejemplo, que una cadena en
particular que se está buscado aparezca al inicio o al fin de una línea,
o que contenga n repeticiones de cierto caracter.

Las expresiones regulares lucen incomprensibles para los novatos, pero
en realidad son muy simples (bueno, usualmente simples ;) ), y son una
herramienta práctica y poderosa.

Les recomiendo especialmente hacer pruebas con e.r. usando Windows
`REStudio <https://github.com/masterandrey/TRegExpr/releases/download/0.952b/REStudio.exe>`__
- ayuda a comprender muchos conceptos. Además hay muchos ejemplos
predefinidos con comentarios, incluidos en este proyecto.

Iniciemos el recorrido de aprendizaje!

Búsquedas simples
-----------------

Cualquier caracter se encuentra a sí mismo, a menos que se trate de un
metacaracter con significado especial, descriptos abajo.

Una serie de caracteres encuentra esa misma serie en la cadena objetivo,
por lo tanto la plantilla "bluh" encontrará "bluh'' en la cadena
objetico. Simple, no?

Se puede conseguir que los caracteres que normalmente funcionan como
metacaracteres o secuencias de escape sean interpretadas literalmente
precediéndolas con el símbolo ``\`` (backslash). Por ejemplo, el
metacaracter ``^`` significa inicio de la cadena, pero ``\^`` encuentra
el símbolo ``^``, ``\\`` encuentra ``\``, y así para todos los casos
especiales.

Ejemplos:
^^^^^^^^^

::

      foobar         encuentra la cadena 'foobar'
      \^FooBarPtr     encuentra '^FooBarPtr'

Secuencias de escape
--------------------

Algunos casos especiales pueden ser especificados usando sintaxis de
secuencias de escape como las empleadas en C y Perl: ``\n`` significa
nueva línea, ``\t`` equivale a tab, etc. Más generalmente, ``\xnn``,
donde nn es un número hexadecimal, encuentra el caracter cuyo valor
 ASCII es nn. Para usar códigos dobles de Unicode, se puede especificar
``\x{nnnn}``, donde ``nnnn`` - es uno o más valores hexadecimales.

::

     \xnn     caracter con código hexadecimal nn
     \x{nn} caracter con código hexadecimal nnnn (un byte para texto común y dos para [Unicode](tregexpr_interface.html))
     \t       tab (HT/TAB), lo mismo que \x09
     \n       línea nueva (NL), lo mismo que \x0a
     \r       retorno de carro (CR), lo mismo que \x0d
     \f       salto de hoja (FF), lo mismo que \x0c
     \a       alarma (bell) (BEL), lo mismo que \x07
     \e       escape (ESC), lo mismo que \x1b

Ejemplos:
^^^^^^^^^

::

     foo\x20bar   encuentra 'foo bar' (notar el espacio en el medio)
     \tfoobar     encuentra 'foobarar' precedido por tab

Clases de caracteres
--------------------

Se pueden especificar clases de caracteres encerrando una lista de
caracteres entre corchetes ``[]``, la que que encontrará uno cualquiera
de los caracteres de la lista.

Si el primer símbolo después deI ``[`` es ``^``, la clase encuentra
cualquier caracter que no está en la lista.

Ejemplos:
^^^^^^^^^

::

     foob\[aeiou\]r   encuentra las cadenas 'foobar', 'foober' etc. pero no 'foobbr', 'foobcr' etc.
     foob\[^aeiou\]r encuentra las cadenas 'foobbr', 'foobcr' etc. pero no 'foobar', 'foober' etc.

Dentro de una lista, el síbolo ``-`` es utilizado para especificar un
rango, entonces ``a-z`` representa todos los caracteres entre ``a`` y
``z`` inclusive.

Para que ``-`` forme parte de la clase hay que ubicarlo al inicio o
final de la lista, o usar la secuencia de escape ``\-``. Para usar ``]``
en la lista hay que ubicarlo al inicio de la lista o usar la secuencia
``\]``.

Ejemplos:
^^^^^^^^^

::

     [-az]     encuentra 'a', 'z' y '-'
     [az-]     encuentra 'a', 'z' y '-'
     [a\-z]     encuentra 'a', 'z' y '-'
     [a-z]     encuentra todas las minúsculas de 'a' hasta 'z'
     [\n-\x0D] encuentra cualquiera de #10,#11,#12,#13.
     [\d-t]     encuentra cualquier dígito, '-' or 't'.
     []-a]     encuentra cualquier caracter de ']' hasta 'a'.

Metacaracteres
--------------

Los metacaracteres son caracteres especiales que son la esencia de las
Expresiones Regulares. Hay diferentes tipos:

Metacaracteres - separadores de líneas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

     ^     inicio de línea
     $     fin de línea
     \A     inicio de texto
     \Z     fin de texto
     .     cualquier caracter en la línea

Ejemplos:
^^^^^^^^^

::

     ^foobar     encuentra 'foobar' sólo si está al principio de una línea
     foobar$     encuentra 'foobar' sólo si está al final de una línea
     ^foobar$   encuentra 'foobar' sólo si es la única cadena en la línea
     foob.r     encuentra cadenas tipo 'foobar', 'foobbr', 'foob1r'

El metacaracter ``^`` por defecto sólo garantiza encontrar coincidencias
al principio de la cadena/texto analizados, y ``$`` sólo al final. Los
separadores de línea intermedios no son encontrados por ``^`` o ``$``.

Sin embargo, se puede tratar una cadena como multilínea, de esta forma
``^`` encontrará coincidencias después de cualquier separador de línea
dentro de esta cadena, y ``$`` dará resultados positivos antes de
cualquier separador. Esto se logra activando el modificador ``/m``.

Las secuencias ``\A`` y ``\Z`` son como ``^`` y ``$``, excepto que no
dan resultados múltiples aunque esté activado el modificador ``/m``,
mientras que ``^`` y ``$`` encontrarán coincidencias en todos los
separadores de línea internos.

El metacaracter ``.`` por defecto encuentra cualquier caracter, pero si
se desactiva el modificador ``/s`` entonces ``.`` no encuentra
separadores de línea internos.

TRegExpr trabaja con los separadores de línea según las recomendaciones
de []www.unicode.org](http://www.unicode.org/unicode/reports/tr18/):

``^`` al inicio de la cadena ingresada, y si el modificador ``/m`` está
activado, también inmediatamente después de toda ocurrencia de
``\x0D\x0A``, ``\x0A`` o ``\x0D`` (si se usa la versión
`Unicode <tregexpr_interface.html>`__ de TRegExpr, también ``\x2028``,
 ``\x2029``, ``\x0B``, ``\x0C`` o ``\x85``). Notar que no hay una línea
vacía dentro de la secuencia ``\x0D\x0A``.

``$`` al final de la cadena ingresada, y si el modificador /m está
activado, también inmediatamente antes de toda ocurrencia de
 ``\x0D\x0A``, ``\x0A``, o ``\x0D`` (si se usa la versión Unicode de
TRegExpr, también ``\x2028``,  ``\x2029``, ``\x0B``, ``\x0C`` o
``\x85``). Notar que no hay una línea vacía dentro de la secuencia
``\x0D\x0A``.

``.`` encuentra cualquier caracter, pero si se desactiva el modificador
/s entonces ``.`` no encuentra ``\x0D\x0A``, ``\x0A`` y ``\x0D`` (si se
usa la versión Unicode de TRegExpr, también ``\x2028``,  ``\x2029``,
``\x0B``, ``\x0C`` y ``\x85``).

Notar que ``^.*$`` (plantilla de línea vacía) no encuentra la cadena
vacía dentro de la secuencia ``\x0D\x0A``, pero sí dentro de la
secuencia ``\x0A\x0D``.

El procesamiento multilínea puede ser fácilmenet afinado para sus
propósitos con la ayuda de las propiedades LineSeparators y
LinePairedSeparator de TRegExpr. Se pueden usar sólo separadores tipo
Unix ( ``\n`` ) o sólo tipo DOS/Windows ( ``\r\n``) o todos juntos (como
se describe arriba y usado por defecto), o incluso definir sus propios
deparadores de línea !

Metacaracteres - clases predefinidas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

     \w     un caracter alfanumérico (incluye "_")
     \W     un caracter no alfanumérico
     \d     un caracter numérico
     \D     un caracter no numérico
     \s     cualquier espacio (lo mismo que [ \t\n\r\f])
     \S     un no espacio

Se pueden usar las clases ``\w``, ``\d`` y ``\s`` dentro de las clases
de caracteres personales.

Ejemplos:
^^^^^^^^^

::

     foob\dr     encuentra cadenas como 'foob1r', ''foob6r' pero no 'foobar', 'foobbr'
     foob\[\w\s]r encuentra cadenas como 'foobar', 'foob r', 'foobbr' pero no 'foob1r', 'foob=r'

TRegExpr usa las propiedades SpaceChars y WordChars para definir las
clases de caracteres ``\w``, ``\W``, ``\s``, ``\S``, por lo tanto se
pueden redefinir fácilmente.

NOTA PARA USUARIOS DE IDIOMA ESPAСOL:

La propiedad WordChars por defecto está definida con el siguiente
conjunto de caracteres:

::

    WordChars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\_'

Para nuestro idioma lo correcto sería:

::

    WordChars = '0123456789aábcdeéfghiíjklmnсoópqrstuúvwxyzAáBCDEéFGHIJKLMNСOУPQRSTUúVWXYZ\_'

Metacaracteres - límites de palabras
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

      \b                                encuentra límite de palabra
      \B                                encuentra distinto a límite de palabra

Un límite de palabra (``\b``) es un punto entre dos caracteres que está
limitado por un ``\w`` de un lado y un ``\W`` en el otro (en cualquier
orden), contando los caracteres imaginarios del inicio y final de la
cadena como coincidencias con ``\W``.

Metacaracteres - iteradores
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cualquier item de una expresión regular puede ser seguido por otro tipo
de metacaracteres, los iteradores. Usando estos metacaracteres se puede
especificar el número de ocurrencias del caracter previo, de un
metacaracter o de una subexpresion.

::

     *     cero o más ("voraz"), similar a {0,}
     +   una o más ("voraz"), similar a {1,}
     ?   cero o una ("voraz"), similar a {0,1}
     {n}   exactamente n veces ("voraz")
     {n,}   por lo menos n veces ("voraz")
     {n,m} por lo menos n pero no más de m veces ("voraz")
     *?     cero o más ("no voraz"), similar a {0,}?
     +?     una o más ("no voraz"), similar a {1,}?
     ??     cero o una ("no voraz"), similar a {0,1}?
     {n}?   exactamente n veces ("no voraz")
     {n,}? por lo menos n veces ("no voraz")
     {n,m}? por lo menos n pero no más de m veces ("no voraz")

Entonces, los dígitos entre llaves de la forma ``{n,m}``, especifican el
mínimo número de ocurrencias en ``n`` y el máximo en ``m``. La forma
``{n}`` es equivalente a ``{n,n}`` y coincide exactamente ``n`` veces.
La forma ``{n,}`` encuentra ocurrencias de ``n`` o más veces. No hay
límites para los número ``n`` o ``m``, pero si son muy grandes se
consume más memoria y la ejecución de la e.r. se hace más lenta.

Si una llave aparece en otro contexto se la trata como un caracter
regular.

Ejemplos:
^^^^^^^^^

::

     foob.*r     encuentra cadenas como 'foobar', 'foobalkjdflkj9r' y 'foobr'
     foob.+r     encuentra cadenas como 'foobar', 'foobalkjdflkj9r' pero no 'foobr'
     foob.?r     encuentra cadenas como 'foobar', 'foobbr' y 'foobr' pero no 'foobalkj9r'
     fooba{2}r   encuentra la cadena 'foobaar'
     fooba{2,}r encuentra cadenas como 'foobaar', 'foobaaar', 'foobaaaar' etc.
     fooba{2,3}r encuentra cadenas como 'foobaar', o 'foobaaar' pero no 'foobaaaar'

Una mínima explicacion acerca de la ``voracidad``. ``Voraz`` toma la
mayor cantidad posible, ``no voraz`` toma la mínima cantidad posible.
Por ejemplo, ``b+`` y ``b*`` aplicados a la cadena ``abbbbc`` devuelven
``bbbb``, ``b+?`` devuelve ``b``, ``b*?`` devuelve unacadena vacía,
``b{2,3}?`` devuelve ``bb``, ``b{2,3}`` devuelve ``bbb``.

Se pueden activar todos los iteradores para que funcione en modo "no
voraz" (ver el modificador ``/g``).

Metacaracteres - alternativas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Se puede especificar una serie de alternativas para una plantilla usando
``|`` para separarlas, entonces ``fee|fie|foe`` encontrará cualquier
``fee``, ``fie``, o ``foe`` en la cadena objetivo (lo mismo sería
``f(e|i|o)e``). La primera alternativa incluye todo desde el ultimo
delimitador ( "('', ``[``, o el inicio de la plantilla) hasta el primer
``|``, y la última alternativa contiene todo desde el último ``|`` hasta
el siguiente delimitador de plantilla. Por esta razón es una práctica
común incluir las alternativas entre paréntesis, para minimizar la
confusión de dónde se inician y dónde terminan.

Las alternativas son evaluadas de izquierda a derecha, por lo tanto la
primera alternativa que coincide plenamente con la expresión analizada
es la que se selecciona. Esto significa que las alternativas no son
necesariamente voraces. Por ejemplo: si se buscam foo|foot en
``barefoot``, sólo la parte ``foo`` da resultado positivo, porque es la
primera alternativa probada, y porque tiene éxito en la búsqueda de la
cadena analizada. (Esto puede no parecer importante, pero lo es cuando
se está capturando el texto buscado usando paréntesis.)

También recordar que ``|`` es interpretado literalmente dentro de los
corchetes, entonces si se escribe ``[fee|fie|foe]`` lo único que se
encuentra es ``[feio|]``.

Ejemplo:
^^^^^^^^

::

     foo(bar|foo) encuentra las cadenas 'foobar' o 'foofoo'.

Metacaracteres - subexpresiones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La construcción ``( ... )`` también puede ser empleada para definir
subexpresiones de e.r. (después del análisis se obtienen las posiciones
de las subexpresiones, su longitud y el valor actual en las propiedades
MatchPos, MatchLen y Match de TRegExpr; y se pueden substituir en
cadenas de plantillas con TRegExpr.Substitute).

Las subexpresiones son numeradas de izquierda a derecha en base al orden
de sus paréntesis de apertura. La primera subexpresión es la '1' (la
e.r. completa tiene el número '0' - Se puede substituir en
TRegExpr.Substitute como '$0' o '$&').

 

Ejemplos:
^^^^^^^^^

::

     (foobar){10} encuentra cadenas que contienen 8, 9 o 10 instancias de 'foobar'
     foob([0-9]|a+)r encuentra 'foob0r', 'foob1r' , 'foobar', 'foobaar', 'foobaar' etc.

Metacaracteres - memorias (backreferences)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Los metacaracteres ``\1`` a ``\9`` son interpretados como memorias.
``\<n>`` encuentra la subexpresión previamente encontrada ``#<n>``.

Ejemplos:
^^^^^^^^^

::

     (.)\1+         encuentra 'aaaa' y 'cc'.
     (.+)\1+       también encuentra 'abab' y '123123'
     (\['"]?)(\d+)\1 encuentra '"13" (entre comillas dobles), o '4' (entre comillas simples) o 77 (sin comillas) etc

Modificadores
-------------

Los modificadores son para cambiar el comportamiento de TRegExpr.

Hay varias formas de configurar los modificadores.

Cualquiera de estos modificadores pueden incluirse dentro de las
expresiones regulares usando la estructura ``(?...)``.

También se pueden asignar las propiedades adecuadas de TRegExpr
(ModifierX por ejemplo, para cambiar ``/x``, o ModifierStr para cambiar
todos los modificadores simultáneamente). Los valores por defecto para
nuevas instancias de TRegExpr están definidos en variables globales, por
ejemplo la variable global RegExprModifierX define el valor de la
propiedad ModifierX en las nuevas instacias del objeto TRegExpr.

 

i
~

Búsquedas insensibles a mayúsculas, ver también InvertCase.

m
~

Tratamiento de cadenas como múltiples líneas. Esto es, cambia a ``^`` y
``$`` de encontrar solo en el inicio y fin de la cadena al inicio y fin
de cada línea dentro de la cadena, ver también Separadores de líneas.

s
~

Tratamiento de cadenas cómo línea simple. Esto es, cambia ``.`` para
encontrar cualquier caracter en cualquier lado, incluso separadores de
línea (ver Separadores de línea), que  normalmente no son encontradod.

g
~

Modificador no standard. Al desactivarlo se cambian todos los operadores
siguientes en modo no voraz (por defecto este modificador esta
activado). Entonces, si el modificador ``/g`` está Off entonces ``+``
funciona como ``+?``, ``*`` como ``*?``, etc.

x
~

Aumenta la legibilidad de las plantillas al permitir espacios en blanco
y comentarios (ver la explicación más abajo).

r
~

Modificador no standard para incluir letras rusas en el rango de
caracteres.

Perdón a los usuarios extranjeros, pero está activado por defecto. Para
desactivarlo por defecto cambiar a False la variable global
RegExprModifierR.

El modificador ``/x`` necesita un poco más de explicación. Le dice a
TRegExpr que ignore los espacios blancos que no están precedidos por
``\`` o no incluídos en una clase de caracteres. Se puede usar para
separar las expresiones regulares en partes más legibles. El caracter
``#`` es tratado como metacaracter para comentarios, por ejemplo:

::

    (
    (abc) #comentario 1
      |   #Se pueden usar espacios para formatear e.r.
    (efg) #comentario 2
    )

Esto significa que si se desea usar realmente un espacio o ``#`` en una
plantilla (fuera de clases de caracteres, donde no son afectadas por
``/x``), hay que usar ``\`` o codificarlos en su valor ASCII en octal o
hexadecimal.

Extensiones de Perl
-------------------

(?imsxr-imsxr)
~~~~~~~~~~~~~~

Se pueden usar dentro de las e.r. para cambiar modificaciones
instantáneamente. Si esta construcción está incluída dentro de una
subexpresión, entonces sólo afecta a la subexpresión.

Ejemplos:
^^^^^^^^^

::

     (?i)Saint-Petersburg       encuentra 'Saint-petersburg' y 'Saint-Petersburg'
     (?i)Saint-(?-i)Petersburg encuentra 'Saint-Petersburg' pero no 'Saint-petersburg'
     (?i)(Saint-)?Petersburg   encuentra 'Saint-petersburg' y 'saint-petersburg'
     ((?i)Saint-)?Petersburg   encuentra 'saint-Petersburg', pero no 'saint-petersburg'

(?#text)
~~~~~~~~

Comentario, el texto es ignorado. Notar que TRegExpr cierra el
comentario apenas encuentra un ")", por lo tanto no hay forma de poner
un ")" literal en el comentario.
