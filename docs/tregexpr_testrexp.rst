Това е проста програма, която можете да използвате за изследване и
тестване на RE. Разпространява се като сорс (проекта TestRExpr.dpr) и
като TestRExpr.exe.

Отбележете, че тя използва някои свойства на VCL които съществуват само
в Delphi 4 или по-висока версия. Ако компилирате в Delphi 3 или Delphi
2, ще получите съобщения за грешки, отнасящи се за непознати свойства.
Можете да ги игнорирате – тези свойства за необходими за промяна на
размерите и наместване на компонентите, ако формата промени размерите
си.

С помощта на тази програма може лесно да определяте броя на подизразите,
които да редактирате, да отидете на някой дефиниран подизраз (както в
изходния код на RE, така и в резултатите, върнати от него), да си
поиграете с функциите Substitude, Replace и Split и др.

Нещо повече – в демонстрационния проект са включени много примери –
използвайте ги за разучаване на синтаксиса на RE или за бързо разучаване
на възможностите на TRegExpr.

Пример: Hyper Links Decorator
=============================

DecorateURLs   DecorateEMails

Функции за създаване на хипервръзки при конвертиране на обикновен текст
в HTML.

Например, заменя 'http://anso.da.ru'  с  'anso.da.ru' или 'anso@mail.ru'
с 'anso@mail.ru'.

функция DecorateURLs

Тя е за търсене и замяна на хипервръзки като 'http://...' или 'ftp://..'
или такива без протокол, но започващи с 'www.' Ако искате да
конвертирате и e-mail адрес, използвайте функцията DecorateEMails.

function DecorateURLs (const AText : string; AFlags :
TDecorateURLsFlagSet = [durlAddr, durlPath]) : string;

Описание

Връща текста AText форматиран като хипервръзка.

AFlags описва кои части от хипервръзката да се включат в нейната ВИДИМА
част:

Например, ако е [durlAddr], то хипервръзката
'http://anso.da.ru/index.htm' ще се форматира като 'anso.da.ru'

type

TDecorateURLsFlags = (durlProto, durlAddr, durlPort, durlPath,
durlBMark, durlParam);

TDecorateURLsFlagSet = set of TDecorateURLsFlags;

Описание

Това са възможните стойности:

Стойност                Значение

durlProto                Protocol (like 'ftp://' or 'http://')

durlAddr                TCP address or domain name (like 'anso.da.ru')

durlPort                                Port number if specified (like
':8080')

durlPath                Path to document (like 'index.htm')

durlBMark                Book mark (like '#mark')

durlParam                URL params (like '?ID=2&User=13')

функция DecorateEMails

Заменя всички синтактически правилни e-mail адреси с 'ADDR'. Например,
заменя 'anso@mail.ru'  с 'anso@mail.ru'.

function DecorateEMails (const AText : string) : string;

Описание

Връща AText с фарматирани e-mail адреси
