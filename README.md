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
<br>



 

<br>
<br>
<br>
<br>


<br>



<br>




<br>

 
## level_2 queries
### query_1:- Write query to return the email, first name, last name & Genre of all Rock Music listeners.Return your list ordered alphebitically by email starting with A
```sql
 with rock_lovers as 
    (SELECT customer.first_name,
        customer.last_name,
        customer.email,
        customer.customer_id,
        --,invoice.invoice_id
        --,track.genre_id
        genre.name
    from customer
    JOIN invoice on customer.customer_id=invoice.customer_id
    join invoice_line on invoice.invoice_id=invoice_line.invoice_id
    join track on invoice_line.track_id = track.track_id
    join genre on track.genre_id = genre.genre_id
    where genre.name = 'Rock')
SELECT DISTINCT* from rock_lovers
ORDER BY email
```
**result**
| First Name     | Last Name      | Email                          | Customer ID | Name |
|----------------|----------------|--------------------------------|-------------|------|
| Aaron          | Mitchell       | aaronmitchell@yahoo.ca         | 32          | Rock |
| Alexandre      | Rocha          | alero@uol.com.br               | 11          | Rock |
| Astrid         | Gruber         | astrid.gruber@apple.at         | 7           | Rock |
| Bjørn          | Hansen         | bjorn.hansen@yahoo.no          | 4           | Rock |
| Camille        | Bernard        | camille.bernard@yahoo.fr       | 39          | Rock |
| Daan           | Peeters        | daan_peeters@apple.be          | 8           | Rock |
| Diego          | Gutiérrez      | diego.gutierrez@yahoo.ar       | 56          | Rock |
| Dan            | Miller         | dmiller@comcast.com            | 20          | Rock |
| Dominique      | Lefebvre       | dominiquelefebvre@gmail.com    | 40          | Rock |
| Edward         | Francis        | edfrancis@yachoo.ca            | 30          | Rock |
| Eduardo        | Martins        | eduardo@woodstock.com.br       | 10          | Rock |
| Ellie          | Sullivan       | ellie.sullivan@shaw.ca         | 33          | Rock |
| Emma           | Jones          | emma_jones@hotmail.com         | 52          | Rock |
| Enrique        | Muñoz          | enrique_munoz@yahoo.es         | 50          | Rock |
| Fernanda       | Ramos          | fernadaramos4@uol.com.br       | 13          | Rock |

**customer information is in customer table and genre information is in genre table for getting these information we have to combine total 5 tables by join function and then we apply the condition that we want only rock genre since a customer has bought many track of one genre we will apply distinct along with another CTE**

### query_2:- let's invite the artists who have written the most rock music in our database. Write a query that returns the Artist name and total track count of the top 10 rock bands 

```sql

select artist.name,
    count(track_id ) as no_of_songs
from track
join genre on genre.genre_id = track.genre_id
join album on track.album_id = album.album_id
join artist on artist.artist_id = album.artist_id
where genre.name = 'Rock'
group by artist.artist_id
order by no_of_songs DESC
LIMIT 10;
```

**result**
| Name                             | No. of Songs |
|----------------------------------|-------------:|
| Led Zeppelin                     | 114         |
| U2                                | 112         |
| Deep Purple                      | 92          |
| Iron Maiden                      | 81          |
| Pearl Jam                        | 54          |
| Van Halen                        | 52          |
| Queen                            | 45          |
| The Rolling Stones               | 41          |
| Creedence Clearwater Revival     | 40          |
| Kiss                             | 35          |


**for finding the artist who has writen the most rock music we have to first connect track table with artist and count total track id i.e. id per song. but we also have to add a condition in where clouse that we only want rock genre.**

### query_3:-Ruturn all the track names that have a song length longer than the average song length. Retunn the Name and Miliseconds for each track Order by the song length with the longest no_of_songs listed first
```sql
select name,
    milliseconds
from track
where milliseconds > (select avg(milliseconds)
    from track)
order by milliseconds DESC
```
**result**
| Name                                   | Milliseconds |
|----------------------------------------|-------------:|
| Occupation / Precipice                 | 5,286,953    |
| Through a Looking Glass                | 5,088,838    |
| Greetings from Earth, Pt. 1            | 2,960,293    |
| The Man With Nine Lives                | 2,956,998    |
| Battlestar Galactica, Pt. 2            | 2,956,081    |
| Battlestar Galactica, Pt. 1            | 2,952,702    |
| Murder On the Rising Star              | 2,935,894    |
| Battlestar Galactica, Pt. 3            | 2,927,802    |
| Take the Celestra                      | 2,927,677    |
| Fire In Space                          | 2,926,593    |
| The Long Patrol                        | 2,925,008    |
| The Magnificent Warriors               | 2,924,716    |
| The Living Legend, Pt. 1               | 2,924,507    |
| The Gun On Ice Planet Zero, Pt. 2      | 2,924,341    |
| The Hand of God                        | 2,924,007    |
| **only 15 out of 494 total song**

**first we have to make a sub-query for finding average length for all tracks and use it in another query that give you all the track list. After getting all the track we can use where query to find track with grater length then average length**
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
## level_3 queries
### querie_1:- Find how much amount spent by each customer on artists ? Write a query to return costomer name, artist name and total spent
```sql
 


with spending_by_customers as
    (select customer.customer_id,
        customer.first_name,
        customer.last_name,
        sum(unit_price*quantity)
    from invoice_line
    join invoice on 
        invoice.invoice_id =  invoice_line.invoice_id
    join customer on 
        invoice.customer_id = customer.customer_id
    group by customer.customer_id)
--this CTE give you totel amount that every person spend)
SELECT
    customer.customer_id,
    customer.first_name,
    artist.name,
    artist.artist_id,
    sum(spending_by_customers.sum)
from invoice
join spending_by_customers on
    spending_by_customers.customer_id = invoice.customer_id
JOIN invoice_line on
    invoice_line.invoice_id = invoice.invoice_id
join track ON
    track.track_id = invoice_line.track_id
join album on 
    album.album_id = track.album_id
join artist on
    artist.artist_id = album.artist_id
join customer on
    customer.customer_id = invoice.customer_id
GROUP BY artist.artist_id,
    customer.customer_id
ORDER BY sum DESC;
```
**rasult**
| Customer ID | First Name | Name                     | Artist ID | Sum      |
|------------:|-----------|--------------------------|----------:|---------:|
| 46         | Hugh      | Queen                    | 51        | 3215.52  |
| 5          | R         | Kiss                     | 52        | 2890.80  |
| 5          | R         | Eric Clapton             | 81        | 2601.72  |
| 6          | Helena    | Red Hot Chili Peppers    | 127       | 2574.00  |
| 42         | Wyatt     | Frank Sinatra            | 85        | 2399.76  |
| 6          | Helena    | Jimi Hendrix             | 94        | 2187.90  |
| 46         | Hugh      | Nirvana                  | 110       | 2181.96  |
| 46         | Hugh      | Marisa Monte             | 103       | 2067.12  |
| 3          | François  | The Who                  | 144       | 1999.80  |
| 1          | Luís      | The Cult                 | 139       | 1960.20  |
| **only 10 out of 2189**


**First CTE will give us the total spanding by each coustomer by joining customer table to invoice table.Then we can connect it with artist table and do sum of all spanding by coustomer with group by artist_id**



## query_2:- We want to find out the most popular music Genre for each country.( We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countrues where the maximum number of purchases is shared return all Genres.


```sql

with popular_genre as
(
    select 
        count(invoice_line.quantity),
        genre.name,
        genre.genre_id,
        customer.country,
        row_number() over (partition by customer.country order by count(invoice_line) DESC) as row_no
    from invoice_line
    join track on
        invoice_line.track_id = track.track_id
    join genre on 
        track.genre_id = genre.genre_id
    join invoice on
        invoice.invoice_id = invoice_line.invoice_id
    join customer on 
        customer.customer_id = invoice.customer_id
    group by 3,customer.country
    )
select 
    country,
    name,
    count
from popular_genre
where row_no = 1
order by name desc
```
**result**
| Country          | Name                 | Count |
|-----------------|----------------------|------:|
| USA             | Rock                 |  561  |
| Australia       | Rock                 |   34  |
| Austria         | Rock                 |   40  |
| Belgium         | Rock                 |   26  |
| Brazil          | Rock                 |  205  |
| Canada          | Rock                 |  333  |
| Chile           | Rock                 |   61  |
| Czech Republic  | Rock                 |  143  |
| Denmark         | Rock                 |   24  |
| Finland         | Rock                 |   46  |
| **10 out of 22**

**first step in this query was to find total count the total number of track that was sold but we have to count it for each country and also count for each genre i.e. we have to get total number of songe for each genre for each country so we use group by country and genre. Along with it we also add one more column that  give us row number by the count of track for each country and each genre i.e. if a track is play the most in a country it will give it row number 1.and then we can use it in another table and get only rows where row number is 1**

## query_3:- Write a query that determines the customer that has spend the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spend this amount.
```sql

with without_customer_name as
    (
    with recursive top_spending_customer as
        (
        select customer_id,
        billing_country,
        sum(total)
        from invoice
        group by 
        customer_id
        ,billing_country
        order by billing_country
         ),

    only_top_per_county as
    (
        select max(sum),
            billing_country
        from top_spending_customer
        group by billing_country)

    select only_top_per_county.max,
        only_top_per_county.billing_country,
        top_spending_customer.customer_id
    from only_top_per_county
    left join top_spending_customer on
        only_top_per_county.max = top_spending_customer.sum
    )
select without_customer_name.*,
    customer.first_name,
    customer.last_name
from without_customer_name
left join customer on
    without_customer_name.customer_id = customer.customer_id
order by billing_country
```
**rasult**
| Max    | Billing Country     | Customer ID | First Name  | Last Name  |
|--------:|--------------------|------------:|------------|------------|
| 39.60  | Argentina          | 56         | Diego      | Gutiérrez  |
| 81.18  | Australia          | 55         | Mark       | Taylor     |
| 69.30  | Austria            | 11         | Alexandre  | Rocha      |
| 69.30  | Austria            | 7          | Astrid     | Gruber     |
| 60.39  | Belgium            | 8          | Daan       | Peeters    |
| 108.90 | Brazil             | 1          | Luís       | Gonçalves  |
| 99.99  | Canada             | 42         | Wyatt      | Girard     |
| 99.99  | Canada             | 3          | François   | Tremblay   |
| 97.02  | Chile              | 57         | Luis       | Rojas      |
| 144.54 | Czech Republic     | 5          | R          | Madhav     |
| 37.62  | Denmark            | 9          | Kara       | Nielsen    |
| 79.20  | Finland            | 18         | Michelle   | Brooks     |
| 79.20  | Finland            | 54         | Steve      | Murray     |
| 79.20  | Finland            | 39         | Camille    | Bernard    |
| 79.20  | Finland            | 44         | Terhi      | Hämäläinen |
| **10 out of 36**



**In this query we made two tables with recursive.In first table we add the spanding down by every person and group it by customer Id and billing country 
 in second table we extract only max value from table first tabel. In third table we combine these two tables so we can get other information of max value data.Lastly we combine all this with customer table to get customer names.**

 # Tools I used 
In my way of getting the inside from the data analyst job maket in had to use these following tools;

- **SQL:**  The backbone of all my analyst, allowing me to query the database and providing the critical insights.
- **postgreSQL:** The chosen database managment system, ideal for handling the job posting data
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

- **Power Shell:** Assisted me to connect with public repository and made it easy for me to pull and push file from Git Hub.


  # What I learn
   The purpose of this projuct was to try to solve some real life data analysis problems. This projust helped me in understanding the data modal i.e. how can a dataset be made of many different table each connecting with each other and removing the redundant data, and it help me understand grouping and CTE more clearly.


 










