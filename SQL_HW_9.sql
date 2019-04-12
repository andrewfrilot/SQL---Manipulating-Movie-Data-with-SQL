-- 1A

USE sakila;

SELECT first_name, last_name FROM actor;


-- 1B

USE sakila

SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS 'Actor Name'
FROM actor


-- 2A

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';


-- 2B

SELECT actor_id, first_name, last_name
FROM actor
where last_name like '%GEN%'


-- 2C

SELECT actor_id, last_name, first_name
FROM actor
where last_name like '%LI%'


-- 2D

SELECT country_id, country
FROM country
Where country IN
('Afghanistan', 'Bangladesh', 'China');


-- 3A

ALTER TABLE actor
ADD COLUMN description BLOB;


-- 3B

ALTER TABLE actor
DROP COLUMN description;


-- 4A

SELECT last_name, COUNT(*) AS 'Amount of Actors'
FROM actor GROUP BY last_name;


-- 4B

SELECT last_name, COUNT(*) AS 'Amount of Actors'
from actor GROUP BY last_name HAVING COUNT(*) >= 2;


-- 4C

UPDATE actor
SET first_name = 'Harpo'
WHERE first_name = 'Groucho' AND last_name = 'Williams';


-- 4D

UPDATE actor
Set first_name = 'Groucho'
Where first_name = 'Harpo';

-- 5A

DESCRIBE sakila.address;


-- 6A

SELECT first_name, last_name, address
FROM staff s
JOIN address a
ON s.address_id = a.address_id;


-- 6B

SELECT payment.staff_id, staff.first_name, staff.last_name, payment.amount, payment.payment_date
FROM staff INNER JOIN payment ON
staff.staff_id = payment.staff_id AND payment_date LIKE '2005-08%';


-- 6C

SELECT f.title AS 'Film', COUNT(fa.actor_id) AS 'Number of Actors'
FROM film_actor fa
INNER JOIN film f
on fa.film_id = f.film_id
GROUP BY f.title;


-- 6D

SELECT title, (
SELECT COUNT(*) FROM inventory
WHERE film.film_id = inventory.film_id
) AS 'Number of Copies'
FROM film
WHERE title = "Hunchback Impossible";


-- 6E

SELECT c.first_name, c.last_name, sum(p.amount) AS 'Total Paid by Each Customer'
From customer c
JOIN payment p
on c.customer_id = p.customer_id
GROUP BY c.last_name;


-- 7A

SELECT title
FROM film WHERE title LIKE 'K%' OR title LIKE 'Q%' AND title IN
(
SELECT title
FROM film 
Where language_id = 1
);


-- 7B

SELECT first_name, last_name
FROM actor WHERE actor_id IN
(
SELECT actor_id
FROM film_actor WHERE film_id IN
(
SELECT film_id
FROM film WHERE title = 'Alone Trip'
));


-- 7C

Select cus.first_name, cus.last_name, cus.email
FROM customer cus
join address a 
ON (cus.address_id = a.address_id)
JOIN city cty
ON (cty.city_id = a.city_id)
join country
ON (country.country_id = cty.country_id)
WHere country.country = 'Canada'



-- 7D

SELECT title, description FROM film Where film_id IN
(
Select film_id FROM  film_category Where category_id IN
(
Select category_id FROM category Where name = 'Family'
));



-- 7E

SELECT f.title, Count(rental_id) AS 'Rentals'
FROM rental r
JOIN inventory i
ON (r.inventory_id = i.inventory_id)
join film f
ON (i.film_id = f.film_id)
GROUP BY f.rental_rate
ORDER BY 'Rentals' DESC;


-- 7F

SELECT s.store_id, SUM(amount) AS 'Revenue - USD'
FROM payment p
JOIN rental r
ON (p.rental_id = r.rental_id)
JOIN inventory i 
ON (i.inventory_id = r.inventory_id)
JOIN store s
ON (s.store_id = i.store_id)
GROUP BY s.store_id;


-- 7G

SELECT s.store_id, cty.city, country.country
FROM store s
JOIN address a
ON (s.address_id = a.address_id)
JOIN city cty
ON (cty.city_id = a.city_id)
JOIN country
ON (country.country_id = cty.country_id);


-- 7H

SELECT c.name AS 'Genre', SUM(p.amount) as 'Gross Revenue'
FROM category c
JOIN film_category fc
ON (c.category_id = fc.category_id)
JOIN inventory i
ON (fc.film_id = i.film_id)
JOIN rental r
ON (i.inventory_id = r.inventory_id)
JOIN payment p
ON (r.rental_id = p.rental_id)
GROUP BY c.name
order by 'Gross Revenue' DESC Limit 5;


-- 8A

Create VIEW top_genre_revenue AS 
SELECT c.name AS 'Genre', SUM(p.amount) as 'Gross Revenue'
FROM category c
JOIN film_category fc
ON (c.category_id = fc.category_id)
JOIN inventory i
ON (fc.film_id = i.film_id)
JOIN rental r
ON (i.inventory_id = r.inventory_id)
JOIN payment p
ON (r.rental_id = p.rental_id)
GROUP BY c.name
order by 'Gross Revenue' DESC Limit 5;



-- 8B

SELECT * FROM top_genre_revenue



-- 8C

DROP VIEW top_genre_revenue







