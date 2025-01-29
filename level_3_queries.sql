/* Find how much amount spent by each customer on artists ? 
Write a query to return costomer name, artist name and total spent
*/
 


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
ORDER BY sum DESC 

/* We want to find out the most popular music Genre for each
country. We determine the most popular genre as the genre with
the highest amount of purchases. Write a query that returns each 
county along with the top genere. For countries where the macimum
number of purchases is shared return all Genres.
*/

select * from invoice_line

select genre.genre_id
    ,genre.name
    ,sum(invoice_line.unit_price*invoice_line.quantity)
from invoice_line
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id
group by genre.genre_id
order by sum DESC







