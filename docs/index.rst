      **This is very old and outdated translation.**
      *If you can read English or Russian please use up-to-date* `English version <http://regexpr.masterandrey.com/en/latest/>`_ *or* `Russian version <http://regexpr.masterandrey.com/ru/latest/>`_.

      *If you want to help to update the translation please* `contact me <https://github.com/masterandrey>`_.
      New translation is based on `GetText <https://en.wikipedia.org/wiki/Gettext>`_ and can be edited with `transifex.com <https://www.transifex.com/masterAndrey/tregexpr/dashboard/>`_.
      It is already machine-translated and need only proof-reading and may be some copy-pasting from here.

------------

TRegExpr е мощен и лесен за използване инструмент, който е предназначен
за проверка, на базата на предварително дефинирани изрази (шаблони,
regular expressions) на входни данни в текстови полета (в бази от данни,
web-ориентирани приложения и др.), за търсене и замяна на текст, за
създаване на инструменти, подобни на egrep от UNIX и т.н.

С негова помощ лесно можете да проверявате например дали един e-mail
адрес е синтактично правилен, да извличате необходимите Ви данни (като
телефонни номера, пощенски кодове и др.) от произволен неформатиран
текст, да намирате определена информация в web-страници – възможностите
са ограничени единствено от  Вашето въображение! Обърнете внимание –
правилата (изразите) за търсене и проверка може да бъдат изменяни без
прекомпилиране на основната Ви програма!

Тази библиотека е freeware и представлява разширена Delphi-версия на
библиотеката V8 на Henry Spencer за работа с подмножество на
дефинираните в езика Perl нормални изрази (`Regular
Expressions) <regular_expressions.html>`__.

TRegExpr е написан на чист Object Pascal, като всички сорс-кодове са
достъпни безплатно.

Освен това към оригиналния С-код са добавени някои разширения и всичко е
капсулирано в обектния клас `TRegExpr <tregexpr.html>`__,
който е реализиран в един-единствен файл - RegExpr.pas.

За неговото използване не са необходими никакви DLL !

За начало може да погледнете някои прости `примери на
използване <demos.html>`__ , а ако не сте запознати с изразите Regular
Expressions, да разучите техният `синтаксис <regular_expressions.html>`__. (За
обучение и експерименти може да използвате и `демонстрационната
програма <tregexpr_testrexp.html>`__).

TregExpr може да работи и с Unicode-стрингове - вижте `как се работи с
Unicode <tregexpr.html#unicode>`__.

Историята на разработката и измененията на библиотеката, както и новите
неща, са описани в `История <../posts/bg/tregexpr_history/>`__.

Ако при работа с библиотеката откриете някакви грешки, ако имате
забележки или нови идеи, изпращайте ги без притеснение.

Благодарности
~~~~~~~~~~~~~

-  Guido Muehlwitz – намерил и изчистил грозен бъг в обработката на
   големи стрингове
-  Stephan Klimek – тествал в CPPB и предложил/реализирал много
   възможности
-  Steve Mudford – реализирал параметъра Offset
-  Martin Baur (`www.mindpower.com <http://www.mindpower.com>`__) -
   помощ на немски, полезни съвети
-  Yury Finkel – реализирал поддръжката на UniCode, намерил и поправил
   грешки
-  Ralf Junker – някои нови възможности, много съвети по оптимизацията
-  Simeon Lilov – помощ на български
-  Filip Jirsбk и Matthew Winter (wintermi@yahoo.com) - помощ при
   реализацията на нежадния режим
-  Kit Eason – много примери, използвани в тази помощ
-  Juergen Schroth – изчистване на грешки и полезни предложения
-  Diego Calp (mail@diegocalp.com), Аржентина – помощ на испански

И на много други – за голямото чистене на грешки !

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
