-- who is the senior most employee based on job title ?

SELECT *
from employee
order by hire_date
LIMIT 1;



--which country have the most invoice

SELECT billing_country , count(invoice_id) as total_invoices
from invoice
GROUP BY billing_country
ORDER BY total_invoices DESC;



--what are the top three valuses of total invoice

select * from invoice 
ORDER BY total DESC
LIMIT 3;

/* which city has the best customers ? we would
 like to throw a promational Music Festival in the 
 city we made the most money. Write a query that returns
  one city that has the hightest sum of invoice totals.
 Return both the city name & sum of all invoices totals */

SELECT billing_city, sum(total)
from invoice
GROUP BY billing_city
ORDER BY sum DESC;

/* who is the best customer ? The customer who has spent 
the most money wil be declared the best customer.
Write a query that returns the person who has spent the
   most money.*/

select invoice.customer_id,
     sum(total) over(PARTITION BY invoice.customer_id) as total_spending,
     customer.first_name,
     customer.last_name
from invoice
LEFT JOIN customer on
    customer.customer_id=invoice.customer_id
--GROUP BY invoice.customer_id 
ORDER BY total_spending DESC
LIMIT 1;
