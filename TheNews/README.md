# Тестовое задание для стажировки в Сбербанк

Реализация приложения отображающего RSS-новости на банковскую тематику.
Дизайн придумать самостоятельно
Парсинг данных из url адресов:
https://www.finam.ru/net/analysis/conews/rsspoint
https://www.banki.ru/xml/news.rss

### Логика взаимодействия:  
Должно состоять из двух экранов:
1. Список новостей. Заголовок новости и время. Новости расположены в хронологическом порядке. Есть возможность обновить по pull to refresh. При нажатии на новость осуществляется переход на 2ой экран.
2. Заголовок + содержание новости + указание времени. Возможность вернуться на стартовый экран.
### Примечания:  
Не использовать storyboard и xib
Если новость прочитана - маркируется цветом.
Должна быть возможность добавления и выбора источника.
### Использовано:
Верстка кодом, Realm, UserDefault, MVVM архитектура