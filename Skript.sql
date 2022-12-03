--=============== МОДУЛЬ 2. РАБОТА С БАЗАМИ ДАННЫХ =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите уникальные названия городов из таблицы городов.

select distinct city from city;



--ЗАДАНИЕ №2
--Доработайте запрос из предыдущего задания, чтобы запрос выводил только те города,
--названия которых начинаются на “L” и заканчиваются на “a”, и названия не содержат пробелов.


select * from city where city like 'L%a' and city not like '% %';


--ЗАДАНИЕ №3
--Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись 
--в промежуток с 17 июня 2005 года по 19 июня 2005 года включительно, 
--и стоимость которых превышает 1.00.
--Платежи нужно отсортировать по дате платежа.

select * from payment where payment_date >= '2005-06-17'::date and payment_date < '2005-06-20'::date and amount > 1.00 order by payment_date;



--ЗАДАНИЕ №4
-- Выведите информацию о 10-ти последних платежах за прокат фильмов.

select * from payment order by payment_date desc limit 10


--ЗАДАНИЕ №5
--Выведите следующую информацию по покупателям:
--  1. Фамилия и имя (в одной колонке через пробел)
--  2. Электронная почта
--  3. Длину значения поля email
--  4. Дату последнего обновления записи о покупателе (без времени)
--Каждой колонке задайте наименование на русском языке.

select concat (first_name, ' ', last_name) as name, email, pg_column_size(email), date_trunc('day', last_update) from customer 



--ЗАДАНИЕ №6
--Выведите одним запросом только активных покупателей, имена которых KELLY или WILLIE.
--Все буквы в фамилии и имени из верхнего регистра должны быть переведены в нижний регистр.


select lower(first_name), lower(last_name), customer_id, store_id, email, create_date, last_update from customer where first_name = 'KELLY' or first_name = 'WILLIE' and active = '1'


--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите одним запросом информацию о фильмах, у которых рейтинг "R" 
--и стоимость аренды указана от 0.00 до 3.00 включительно, 
--а также фильмы c рейтингом "PG-13" и стоимостью аренды больше или равной 4.00.

select * from film where (rating = 'R' and rental_rate >= 0.00 and rental_rate <= 3.00) or (rating = 'PG-13'  and rental_rate >= 4.00)


--ЗАДАНИЕ №2
--Получите информацию о трёх фильмах с самым длинным описанием фильма.


select * from film order by length (description) desc limit 3


--ЗАДАНИЕ №3
-- Выведите Email каждого покупателя, разделив значение Email на 2 отдельных колонки:
--в первой колонке должно быть значение, указанное до @, 
--во второй колонке должно быть значение, указанное после @.


select split_part(email, '@', 1) as name, split_part(email, '@', 2) as server from customer 


--ЗАДАНИЕ №4
--Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: 
--первая буква должна быть заглавной, остальные строчными.


select initcap(split_part(email, '@', 1)) as name, initcap(split_part(email, '@', 2)) as server from customer 



