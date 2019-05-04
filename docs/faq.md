### P. Cómo puedo usar TRegExpr con Borland C++ Builder?

Tengo un problema porque no hay un archivo de cabecera (.h or .hpp)
disponible.

#### R.

* Agregar RegExpr.pas al proyecto bcb.
* Compilar el proyecto. Esto genera el archivo RegExpr.hpp.
* Ahora se puede escribir código que use la unidad RegExpr.
* No olvidar agregar #include "RegExpr.hpp" donde haga falta.

### P. Porqué TRegExpr devuelve más de una línea?

Por ejemplo, e.r. `<font .\*>` devuelve la primera línea `<font`, y
entonces el resto del archivo incluso el último `</html>`.

#### R.
Por compatibilidad con versiones anteriores el modificador /s está
activado por defecto.

Desactivarlo y `.` encotrará todo menos separadores de línea.

A propósito, le sugiero `<font (\[^\\n>\]\*)>`, será la URL en
Match\[1\].

### P. Porqué TRegExpr devuelve más de lo esperado?

Por ejemplo, la e.r. `<p>(.+)</p>` aplicada a la cadena
`<p>a</p><p>b</p>` devuelve
`a</p><p>b` pero no `a` como esperaba.

#### R.
Por defecto, todos los operadores funcionan en modo `voraz`, entonces
devuelven lo máximo posible.

Para operación `no voraz` se pueden usar operadores no voraces como `+?`
(nuevo en v. 0.940) o cambiar todos los operadores a modo `no voraz` con
la ayuda del modificador `g` (usando las propiedades de TRegExpr o
construcciones como `?(-g)` en la e.r.).

### P. Cómo se pueden descomponer textos como HTML con la ayuda de TRegExpr

#### R.
Lo siento amigos, pero es prácticamente imposible!

Por supuesto, se puede usar fácilmente TRegExpr para extraer alguna
información del HTML, como se muestra en mis ejemplos, pero para
desomponer en forma precisa hay que usar un código real de
descomposición, no e.r.!

Pueden obtener la explicación completa en el libro `Perl Cookbook` de
Tom Christiansen y Nathan Torkington. Brevemente, hay muchas
construcciones que són fácilmente descompuestas por el programa
apropiado, pero en absoluto por una e.r., y un descomponedor real es
MUCHO más rápido porque la e.r. no hace simplemente una búsqueda,
incluye una optimización que puede llevar una gran cantidad de tiempo.

### P. Hay forma de obtener múltiples coincidencias de una plantilla en TRegExpr?

#### R.
Se puede hacer un bucle e iterar una por una con el método ExecNext.

No se puede hacer más fácil porque Delphi no es un intérprete como Perl
(y es un beneficio, los intérpretes son muy lentos).

Para ver algún ejemplo ver la implementación del método
TRegExpr.Replace, o los ejemplos en
[HyperLinksDecorator.pas](#hyperlinksdecorator.html)

### P. Estoy controlando entradas de usuarios. Porqué TRegExpr devuelve `True` para cadenas incorrectas?

#### R.
En muchos casos los usuarios de TRegExpr olvidan que las expresiones
regulares son para BUSCAR en una cadena. Entonces, si se pretende que un
usuario ingrese sólo 4 dígitos y se usa para ello la expresión
`\\d{4,4}`, se puede errar la detección de parámetros incorrectos como
`12345` o `cualquier letra 1234 y cualquier otra cosa`. Hay que agregar
control para inicio y fin de línea para asegurarse de que no hay nada
alrededor: `^\\d{4,4}$`.

### P. Porqué los iteradores no voraces a veces funcionan como en modo voraz?

Por ejemplo, la e.r. `a+?,b+?` aplicada a la cadena `aaa,bbb` encuentra
`aaa,b`, pero debería No encontrar `a,b` a causa de la no voracidad del
primer iterador?

#### R.
Esta es la limitación de las matemáticas usadas por TRegExpr (y de las
e.r. de Perl y muchos Unix) - e.r. realiza sólo una optimización de
búsqueda `simple`, y no trata de hacer la mejor optimización. En algunos
casos esto es malo, pero en los comunes es mayor la ventaja que la
limitación - por motivos de rapidez y predecibilidad.

La regla principal - la e.r. antes que nada intenta encontrar
coincidencia desde la posición actual y sólo si es completamente
imposible avanzar un caracter e intentar nuevamente desde ese lugar.
Entonces, si se usa `a,b+?` se encuentra `a,b`, pero en el caso de
`a+?,b+?` es `no recomendado` (a causa de la no voracidad) pero posible
encontrar más de una `a`, entonces TRegExpr lo hace y finalmente obtiene
una correcta (pero no óptima) coincidencia. TRegExpr como las e.r. de
Perl o Unix no intenta avanzar y volver a chequear - lo que sería una
`mejor` coincidencia. Más aún, esto no puede ser comparado en absoluto
en términos de `mejor o pero coincidencia`.

Por favor, leer  `[Sintaxis](regular_expressions.html)`.
