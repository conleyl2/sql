use sakila;
select first_name, last_name from actor;

select concat(first_name, ' ', last_name) as 'Actor Name' from actor;

SELECT * from actor
WHERE actor.first_name = 'Joe';

SELECT * from actor
WHERE actor.last_name like '%gen%';

SELECT last_name, first_name from actor
WHERE actor.last_name like '%li%';

select country_id,country from country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

Alter table actor 
add column middle_name varchar(40) AFTER first_name;

alter table actor
modify column middle_name blob;

Alter table actor
drop column middle_name;

select last_name, count(last_name) as 'Count' FROM actor GROUP BY last_name;

select last_name, count(last_name) as 'Count' FROM actor 
GROUP BY last_name
HAVING COUNT(last_name) > 1;

UPDATE actor
SET first_name = 'Harpo'
WHERE last_name = 'Williams' and first_name = 'Groucho';

UPDATE actor
SET first_name = CASE
   WHEN first_name = 'Harpo' and last_name = 'Williams' THEN 'GROUCHO'
   WHEN first_name = 'Groucho' and last_name = 'Williams' THEN 'MUCHO GROUCHO'
   ELSE first_name
END;

show create table address;

SELECT s.first_name, s.Last_name, a.address
from staff s
JOIN address a
ON s.address_id = a.address_id;

select s.first_Name, s.Last_name, sum(p.amount) as amount
from staff s
left join payment p
on s.staff_id = p.staff_id
WHERE p.payment_date Between '2005-08-01' and '2005-08-31'
GROUP BY s.staff_id;

select f.title, count(a.actor_id) as Actors
from film f
inner join film_actor a
on f.film_id = a.film_id
GROUP BY f.title;

select f.title, count(i.inventory_id) as Inventory
from film f
inner join inventory i
on f.film_id = i.film_id
Where f.title = 'Hunchback Impossible'
GROUP BY f.title;

select  c.last_name,c.first_name, sum(p.amount) as 'Total Paid'
from customer c
inner join payment p
on c.customer_id = p.customer_id
GROUP BY c.last_name
ORDER BY c.last_name;

select title from film
where language_id = 1 and (title like'q%' or title like 'k%');

select a.first_name, a.last_name
from film_actor fa
inner join film f
on f.film_id = fa.film_id
join actor a
on fa.actor_id = a.actor_id
where f.title = 'Alone Trip';

select c.first_name, c.last_name, c.email
from customer c
join address a 
on c.address_id = a.address_id
join city ci
on a.city_id = ci.city_id
join country co
on co.country_id = ci.country_id
Where co.country = 'Canada';

select f.title, c.name as category
from film f 
join film_category fi
on fi.film_id = f.film_id
join category c 
on c.category_id = fi.category_id
WHERE c.name = 'Family';

select f.title, count(r.rental_id) as Rentals
from film f
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
Group by f.title
Order by count(r.rental_id) DESC;

select s.store_id, sum(p.amount)
from store s
join staff st 
on s.store_id = st.store_id
join payment p
on st.staff_id = p.staff_id
Group by s.store_id;

select s.store_id, ci.city, c.country
from store s
join address a 
on s.address_id = a.address_id
join city ci
on a.city_id = ci.city_id
join country c
on c.country_id = ci.country_id;

select ca.name as category, sum(p.amount) as total
from category ca
join film_category fc
on ca.category_id = fc.category_id
join inventory i
on i.film_id = fc.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p
on r.rental_id = p.rental_id
Group by ca.name
order by sum(p.amount) DESC
Limit 5;

Create View MyAwesomeView as
select ca.name as category, sum(p.amount) as total
from category ca
join film_category fc
on ca.category_id = fc.category_id
join inventory i
on i.film_id = fc.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p
on r.rental_id = p.rental_id
Group by ca.name
order by sum(p.amount) DESC
Limit 5;

select * from myawesomeview;

drop view myawesomeview;