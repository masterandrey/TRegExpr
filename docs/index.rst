.. include:: translation_help.rst

------------

TRegExpr es una herramienta poderosa y fácil de usar para controlar
entrada de datos de cadenas de caracteres en base a plantillas (en DBMS
y aplicaciones para web), búsqueda y sustitución de texto, utilidades
tipo egrep, etc.

Se puede verificar fácilmente una dirección de e-mail, extraer un número
de teléfono o código postal de texto sin formato, cualquier tipo de
información de una página web, y todo lo que pueda imaginar!. Las reglas
(plantillas) pueden ser modificadas sin recompilar el programa!

Esta librería freeware es una versión extendida para Delphi de las
rutinas V8 de Henry Spencer,. Trabajan con un subconjunto de las
`Expresiones Regulares <regular_expressions.html>`__ de Perl.

TRegExpr está programado en Pascal puro, con el código fuente completo
gratis.

El original en C ha sido mejorado y encapsulado completamente en la
clase `TRegExpr <tregexpr.html>`__ implementada en un sólo
archivo: RegExpr.pas.

Por lo tanto, no se necesita ninguna DLL!

Ver los `ejemplos simples <demos.html>`__ y estudiar la
`sintaxis <regular_expressions.html>`__ de las expresiones regulares (Se puede
usar el `proyecto demo <tregexpr_testrexp.html>`__ para probar y depurar
las expresiones regulares propias).

Se puede usar Unicode (WideString de Delphi) - ver "`Cómo usar
Unicode <tregexpr.html#unicode>`__".

Documentation
-------------

.. toctree::
   :glob:
   :maxdepth: 2

   regular_expressions
   tregexpr
   faq
   demos
   tregexpr_testrexp
