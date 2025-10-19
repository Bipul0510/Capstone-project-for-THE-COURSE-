-----CREATE the database
Create database Restraunt2025

-----Load the database
use Restraunt2025

-----Load csv files

Select * from consumer_preferences
Select * from consumers
Select * from ratings
Select * from restaurant_cuisines
Select * from restaurants


----- Identify the top 5 most highly-rated restaurant cuisines by consumers with the occupation 'Student'.
    
select Top 5 rc.Cuisine,
        round(avg(cast(r.Overall_Rating as REAL)),3) as Average_Overall_Rating
    from
        consumers as c
    JOIN
        ratings as r on c.Consumer_ID = r.Consumer_ID
    JOIN
        restaurant_cuisines as rc on r.Restaurant_ID = rc.Restaurant_ID

where c.Occupation = 'Student'
group by rc.Cuisine
order by Average_Overall_Rating desc

------------------------------------------------------------REST OF THE QUARIES--------------------------------------------------------------------



--- 1. Count of restaurants per cuisine: This query counts the number of restaurants associated with each cuisine type.

select Cuisine,
        count(Restaurant_ID) as Number_Of_Restaurants
    from restaurant_cuisines
    group by Cuisine
    order by Number_Of_Restaurants desc

    
--- 2. Average overall rating per restaurant: This query calculates the average overall rating for each restaurant.

select Restaurant_ID,
       round(avg(cast(Overall_Rating as REAL)),4) as Average_Overall_Rating
    from ratings
    group by Restaurant_ID
    order by Average_Overall_Rating desc

    
--- 3. Consumers with high ratings: This query identifies consumers who have given an average overall rating greater than 1.5

select Consumer_ID,
       round(avg(cast(Overall_Rating as REAL)),3) as Average_Overall_Rating
    from ratings
    group by Consumer_ID
    having round(avg(cast(Overall_Rating as REAL)),3) > 1.5
    order by Average_Overall_Rating desc

    
--- 4. Most common transportation method: This query finds the most frequent transportation method used by consumers.

select top 1 Transportation_Method,
       count(*) as Consumer_Count
    from consumers
    where Transportation_Method IS NOT NULL AND Transportation_Method <> ''
    group by Transportation_Method
    order by Consumer_Count desc
   
    
--- 5. Average age of consumers per city: This query calculates the average age of consumers in each city.

select City,
       avg(Age) as Average_Age
    from consumers
    group by City
    order by Average_Age desc

    
--- 6. Restaurants with highest service rating: This query identifies the restaurants with the highest average service rating.

select Restaurant_ID,
       round(avg(cast(Service_Rating as REAL)),3) as Average_Service_Rating
from ratings
group by Restaurant_ID
order by Average_Service_Rating desc

    
--- 7. Count of smokers vs. non-smokers: This query compares the number of consumers who are smokers versus non-smokers.

select cast(Smoker as NVARCHAR(50)) as SmokerStatus,
       count(*) as Consumer_Count
from consumers
where Smoker is not null
group by cast(Smoker as NVARCHAR(50))
order by Consumer_Count desc



--- 8. Preferred cuisine by marital status: This query identifies the most preferred cuisine for each marital status.

select c.Marital_Status,
        cp.Preferred_Cuisine,
        count(*) as Preference_Count

from consumers as c
join consumer_preferences as cp
on c.Consumer_ID = cp.Consumer_ID
where c.Marital_Status is not null
group by c.Marital_Status, cp.Preferred_Cuisine
order by c.Marital_Status, Preference_Count desc

    
--- 9. Restaurants with high food and low service rating: This query finds restaurants with a high average food rating (e.g., > 1.5) but a low average service rating (e.g., < 1.0)

select r.Restaurant_ID,
       avg(cast(r.Food_Rating as REAL)) as Avg_Food_Rating,
       avg(cast(r.Service_Rating as REAL)) as Avg_Service_Rating

from ratings as r
group by r.Restaurant_ID
having avg(cast(r.Food_Rating as REAL)) > 1.5 and avg(cast(r.Service_Rating as REAL)) < 1.0;
    
    
--- 10. Most popular cuisine among low-budget consumers: This query finds the most popular cuisine for consumers with a 'Low' budget, based on ratings.

SELECT rc.Cuisine,
       count(r.Restaurant_ID) as Number_of_Ratings

from consumers as c
join ratings as r
on c.Consumer_ID = r.Consumer_ID
join restaurant_cuisines as rc
on r.Restaurant_ID = rc.Restaurant_ID
where c.Budget = 'Low'
group by rc.Cuisine
order by Number_of_Ratings desc

    
    
--- 11. Count of restaurants in each state: This query counts the number of restaurants located in each state.

select State,
       count(Restaurant_ID) as Number_Of_Restaurants
from restaurants
group by State
order by Number_Of_Restaurants desc

    
--- 12. Average price rating per city: This query calculates the average price rating for restaurants in each city.
--- Note: 'Price' is assumed to be a categorical column, so this query will not return a numerical average but group by city and price category count.

select City,
       Price,
       count(Restaurant_ID) as Count_of_Restaurants

from restaurants
where Price is not null and Price <> ''
group by City, Price
order by City, Count_of_Restaurants desc

    
--- 13. Consumers who have rated more than one cuisine: This query identifies consumers who have rated restaurants belonging to more than one distinct cuisine type.

select c.Consumer_ID,
       count(distinct rc.Cuisine) as Number_Of_Cuisines_Rated

from consumers as c
join ratings as r 
on c.Consumer_ID = r.Consumer_ID
join restaurant_cuisines as rc
on r.Restaurant_ID = rc.Restaurant_ID
group by c.Consumer_ID
having  count(distinct rc.Cuisine) > 1
order by Number_Of_Cuisines_Rated desc
    

--- 14. Restaurants with no ratings: This query finds restaurants from the 'restaurants' table that do not appear in the 'ratings' table.

select r.Restaurant_ID,
       r.Name

from restaurants as r
left join ratings as ra
on r.Restaurant_ID = ra.Restaurant_ID
where ra.Restaurant_ID is null

    
--- 15. Total number of ratings per consumer: This query calculates the total number of ratings submitted by each consumer.

select Consumer_ID,
       count(Restaurant_ID) as Total_Ratings

from ratings
group by Consumer_ID
order by Total_Ratings desc

--------------------------------------------------------END OF QUARIES--------------------------------------------------------------------------    
    