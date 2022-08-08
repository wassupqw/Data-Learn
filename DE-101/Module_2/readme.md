# Homework Module 2

## 2.3 Подключение к Базам Данных и SQL
Установил клиент SQL - DBeaver.

Создал 3 таблицы:
- orders
- people
- returns

Одноименные запросы SQL лежат в папке [ссылка](https://github.com/wassupqw/Data-Learn/tree/main/DE-101/Module_2/creating%20tables)

Написал аналитические запросы [файл](https://github.com/wassupqw/Data-Learn/blob/main/DE-101/Module_2/creating%20tables/metrics.sql)

## 2.4 Модели Данных
Создал физическую модель типа "Звезда".
![схема](https://github.com/wassupqw/Data-Learn/blob/main/DE-101/Module_2/2.4/physical.png)

Запросы:
- [DDL](https://github.com/wassupqw/Data-Learn/blob/main/DE-101/Module_2/2.4/ddl.sql)
- [insert data](https://github.com/wassupqw/Data-Learn/blob/main/DE-101/Module_2/2.4/insert%20data.sql)

В ходе построения выяснились некоторые подводные камни:
- В полях segment и product_name информация задваивается, поэтому на одном этапе данные столбцы пришлось удалить, а потом добавить в основную таблицу sales.
