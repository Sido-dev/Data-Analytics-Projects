Create Database Ola;
use Ola;
select * from bookings;
desc bookings;

#1. Retrieve all successful bookings: 
select * from bookings where booking_status = "Success";

#2. Find the average ride distance for each vehicle type:
select vehicle_type ,avg(ride_distance) as Avg_distance from bookings group by vehicle_type ;
 
#3. Get the total number of cancelled rides by customers: 
select count(*) as `cancelled rides`  from bookings where booking_status = "Canceled by Customer";

#4. List the top 5 customers who booked the highest number of rides: 
select customer_id,count(*) as cnt from bookings group by customer_id order by cnt desc limit 5;

#5. Get the number of rides cancelled by drivers due to personal and car-related issues: 
select count(*) cnt from bookings where Canceled_Rides_by_Driver = "Personal & Car related issue";

#6. Find the maximum and minimum driver ratings for Prime Sedan bookings: 
select max(Driver_Ratings) `maximum driver ratings`,min(Driver_Ratings) `minimum driver ratings` from bookings where vehicle_type= "Prime Sedan";

#7. Retrieve all rides where payment was made using UPI: 
select * from bookings where Payment_Method = "UPI";

#8. Find the average customer rating per vehicle type: 
select vehicle_type,round(avg(Customer_Rating),3) Avg_customer_Rating from bookings group by vehicle_type;

#9. Calculate the total booking value of rides completed successfully: 
select sum(booking_value) `total booking value` from bookings where booking_status = "Success";

#10. List all incomplete rides along with the reason:
select Booking_id,customer_id,incomplete_rides,incomplete_rides_reason from bookings where incomplete_rides="yes";

#11. Find the total number of bookings for each vehicle type:
select vehicle_type,count(*) bookings from bookings group by vehicle_type;

#12. Retrieve all bookings where the ride distance is greater than 10 km:
select * from bookings where ride_distance > 10;

#13. Find the total revenue generated for each payment method:
select payment_method,sum(booking_value) revenue_generated from bookings where booking_status = "Success" group by payment_method;

#14. Get the number of successful rides for each pickup location:
select pickup_location,count(*) `number of successful rides`  from bookings group by pickup_location;

#15. Find the most frequently used payment method:
select payment_method,count(*) frequently from bookings group by payment_method order by frequently desc limit 1;

#16. List all rides where the customer rating is less than 3:
select * from bookings where customer_rating < 3;

#17. Find the average booking value per vehicle type:
select vehicle_type,avg(booking_value) Avg_booking_value from bookings group by vehicle_type;

#18. Get the total number of rides for each booking status:
select booking_status,count(*) `Ride booking status` from bookings group by booking_status;

#19. Retrieve the top 3 pickup locations with the highest number of bookings:
select pickup_location,count(*) as No_bookings from bookings group by pickup_location order by No_bookings limit 3;

#20. Find the total number of rides where drivers gave a rating below 4:
select * from bookings where driver_ratings < 4;

#21. Calculate the average ride distance for successful bookings only:
select avg(ride_distance) Avg_distance from bookings where booking_status = "Success";

#22. Find the number of rides cancelled by customers for each reason:
select Canceled_Rides_by_Customer,count(*) cnt from bookings where booking_status = "Canceled by Customer" group by Canceled_Rides_by_Customer;

#23. Retrieve all bookings where the booking value is above the average booking value:
select * from bookings where booking_value > (select avg(booking_value)avg_booking_price from bookings);

#24. Find the total number of incomplete rides for each vehicle type:
select vehicle_type,count(*) cnt from bookings where incomplete_rides = "Yes" group by vehicle_type;

#25. Get the average customer rating for completed (successful) rides only:
select round(avg(customer_rating),3) avg_customer_rating  from bookings where booking_status= "Success";

#26. find the percentage of rides cancelled by customers out of total bookings:
select (count(case when booking_status = 'canceled by customer' then 1 end) * 100.0) / count(*) as cancel_percentage from bookings;

#27. find the average booking value for rides cancelled by customers vs successfully completed rides:
select booking_status,avg(booking_value) as avg_value from bookings where booking_status in ('canceled by customer', 'success') group by booking_status;


