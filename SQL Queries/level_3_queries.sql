/* querie_1:- Find how much amount spent by each customer on artists ? 
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



/*query_2:- We want to find out the most popular music Genre for each
country.( We determine the most popular genre as the genre with
the highest amount of purchases. Write a query that returns each
country along with the top Genre. For countrues where the maximum number
of purchases is shared return all Genres.*/




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




/* query_3:- Write a query that determines the customer that
 has spend the most on music for each country. Write a query that
 returns the country along with the top customer and how much they
 spent. For countries where the top amount spent is shared, provide
 all customers who spend this amount.
 */

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



