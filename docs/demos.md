#### Прости примери

Ако не сте запознати с Regular Expressions, можете да прочетете моето
описанието на техния [синтаксис](regexp_syntax.html).

#### Използване на глобалните процедури

Това е най-простият, но не най-гъвкавият и ефективен начин:

    ExecRegExpr ('\\d{3}-(\\d{2}-\\d{2}|\\d{4})', 'Phone: 555-1234');

връща True

    ExecRegExpr ('^\\d{3}-(\\d{2}-\\d{2}|\\d{4})', 'Phone: 555-1234');

   връща False, защото има символи преди самия телефонен номер, а ние
използваме метасимвола '^' (BeginningOfLine)

ReplaceRegExpr ('product', 'Take a look at product. product is the best
!', 'TRegExpr');

   връща 'Take a look at TRegExpr. TRegExpr is the best !'   ;)

##### Използване на обекти от клас TRegExpr

Това дава в ръцете ви мощността на цялата библиотека.

* 1

Тази проста функция извлича всички e-mail адреси от входния стринг
и връща техният списък в резултантния стринг:

{% highlight pascal linenos %}
function ExtractEmails (const AInputString : string) : string;
    const
         EmailRE = '\[\_a-zA-Z\\d\\-\\.\]+@\[\_a-zA-Z\\d\\-\]+(\\.\[\_a-zA-Z\\d\\-\]+)+'
    var
         r : TRegExpr;
    begin
         Result := ";
         r := TRegExpr.Create; // Създаваме обекта
         try // гарантира освобождаването на паметта
            r.Expression := EmailRE;
            // при това присвояване RE се компилира автоматично
            // ако има грешка, възниква Exception
            if r.Exec (AInputString) then
                REPEAT
                    Result := Result + r.Match \[0\] + ', ';
                UNTIL not r.ExecNext;
            finally r.Free;
         end;
    end;
begin
         ExctractEmails ('My e-mails is anso@mail.ru and anso@usa.net');
         // връща 'anso@mail.ru, anso@usa.net, '
end.
{% endhighlight %}
Забележка: компилирането на RE при присвояването й отнема време. 

Затова ако използвате тази функция многократно,
ще се получи значително забавяне.

Значително оптимизиране се постига ако по-рано създадете
TRegExpr и още при инициализирането компилирате RE.

* 2

Този прост пример извлича телефонен номер от входящия стринг
и го разделя на съставни части (код на страната, на града и вътрешен номер).
След това тези части се поставят в шаблон.

{% highlight pascal linenos %}
function ParsePhone (const AInputString, ATemplate : string) : string;
const
         IntPhoneRE = '(\\+\\d \*)?(\\(\\d+\\) \*)?\\d+(-\\d\*)\*';
var
         r : TRegExpr;
begin
         r := TRegExpr.Create; // Създаваме обекта
         try // гарантира освобождаване на паметта
                         r.Expression := IntPhoneRE;
                         // Присвоява сорс-кода на RE. Той ще бъдекомпилиран при необходимост
                         // (например ако се извика Exec). Ако в RE имагрешки,
                         // ще възникне run-time exception прикомпилацията му
                         if r.Exec (AInputString)
                                         then Result := r.Substitute(ATemplate)
                                         else Result := ";
                         finally r.Free;
         end;
end;
begin
         ParsePhone ('Phone of AlkorSoft (project PayCash) is +7(812) 329-44-69',
         'Zone code $1, city code $2. Whole phone number is $&.');
         // връща 'Zone code +7, city code (812) . Whole phone number is +7(812) 329-44-69.'
end.
{% endhighlight %}

##### По-сложни примери
Може да намерите по-сложни примери на използване на TRegExpr в проекта
TestRExp.dpr и [HyperLinkDecorator.pas](#hyperlinksdecorator.html).

Вижте и статията ми в
[на английски език](http://masterandrey.com/posts/en/text_processing_from_birds_eye_view.html) 
и [на руски език](http://masterandrey.com/posts/ru/text_processing_from_birds_eye_view.html).

 

### Детайлно описание
Вижте [пълното описание](tregexpr_interface.html) на интерфейса на TRegExpr.
