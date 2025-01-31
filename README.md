# Introduction
This project is based on a music store database. In this project I try to figure out answer
of some specific questions that is asked in this projuct. Questions are divided into three secton
on the basis of difficulty level.

# Dataset 
The data set have 11 different tables and each table is connected with at least one another table. 
Tables are containing information from employee to customer to music. the Ed diagram of the table is this:-
![ER Diagram](https://github.com/Lovemann1/music_store_project/blob/main/ER_diagram/ERD.jpeg) 


# The Questions and Their Analysis 

## Level _1 queries
###  query_1: who is the senior most employee based on job title ?

 ```sql
   SELECT *
  from employee
  order by hire_date
  LIMIT 1;
```
**Result**
 Employee Details  

| Employee ID | Last Name | First Name | Title                  | Reports To | Level | Birthdate  | Hire Date  | Address            | City     | State | Country | Postal Code | Phone           | Fax             | Email                                 |
|------------|-----------|------------|------------------------|------------|-------|------------|------------|--------------------|----------|-------|---------|-------------|----------------|----------------|--------------------------------------|
| 9          | Madan     | Mohan      | Senior General Manager | -          | L7    | 1961-01-26 | 2016-01-14 | 1008 Vrinda Ave MT | Edmonton | AB    | Canada  | T5K 2N1     | +1 (780) 428-9482 | +1 (780) 428-3457 | madan.mohan@chinookcorp.com |


**By just ordering the dataset by date of hireing we can find out most senior employee**

### query_2:which country have the most invoice

```sql
SELECT billing_country , count(invoice_id) as total_invoices
from invoice
GROUP BY billing_country
ORDER BY total_invoices DESC
LIMIT 3;
```
**Result**

 Billing Information  

| Billing Country | Total Invoices |
|----------------|---------------|
| USA           | 131           |
| Canada        | 76            |
| Brazil        | 61            |

**by selecting count of invoice id from invoice table for each country we can find total invoice per country and after ordering it we can get country with highest invoices**

### query_3:-what are the top three valuses of total invoice

```sql
select * from invoice 
ORDER BY total DESC
LIMIT 3;
```
**Result**
Invoice Details  

| Invoice ID | Customer ID | Invoice Date         | Billing Address           | Billing City | Billing State | Billing Country | Billing Postal | Total  |
|-----------|------------|----------------------|---------------------------|--------------|--------------|----------------|----------------|--------|
| 183       | 42         | 2018-02-09 00:00:00  | 9, Place Louis Barthou    | Bordeaux     | None         | France         | 33000          | 23.76  |
| 92        | 32         | 2017-07-02 00:00:00  | 696 Osborne Street        | Winnipeg     | MB           | Canada         | R3L 2B9        | 19.80  |
| 31        | 3          | 2017-02-21 00:00:00  | 1498 rue Bélanger         | Montréal     | QC           | Canada         | H2G 1A7        | 19.80  |


**just by using order by on total billing anount we can get top three values of total invoices**

### query_4:- which city has the best customers ? we would
 like to throw a promational Music Festival in the 
 city we made the most money. Write a query that returns
  one city that has the hightest sum of invoice totals.
 Return both the city name & sum of all invoices totals 
```sql
SELECT billing_city, sum(total)
from invoice
GROUP BY billing_city
ORDER BY sum DESC
limit 1;
```
**result**
| Billing City | Sum       |
|-------------|----------:|
| Prague      | 273.24    |

**for this we have to find hightest total by each billing city from table invoice and by select only the top city from the table we can get best customers city.**
### query_5:- who is the best customer ? The customer who has spent the most money wil be declared the best customer.Write a query that returns the person who has spent the most money.

```sql
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
```
**result**
| Customer ID | Total Spending | First Name | Last Name |
|------------:|--------------:|------------|-----------|
| 5          | 144.54        | R          | Madhav    |

**first we have to find the customer id of the customer who spent the most by add all the billing anount for each customer Id and the we have to use group by to find the name of these customer id's from customer table**






