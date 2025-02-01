
/* query_1:- Write query to return the email, first name, last name
 & Genre of all Rock Music listeners.
Return your list ordered alphebitically by email starting
 with A*/

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



/* query_2:- let's invite the artists who have written the most rock music
in our database. Write a query that returns the Artist name and 
total track count of the top 10 rock bands */



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



/* query_3:-Ruturn all the track names that have a song length longer
than the average song length. Retunn the Name and Miliseconds
for each track Order by the song length with the longest no_of_songs
listed first.*/

select name,
    milliseconds
from track
where milliseconds > (select avg(milliseconds)
    from track)
order by milliseconds DESC



