
select * from Zomato where RestaurantType='Quick Bites';

--Task to be  Performed

--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.

CREATE FUNCTION ReplaceQuickBitesWithChicken(@inputString NVARCHAR(max))
RETURNS NVARCHAR(max)
AS
BEGIN
    RETURN REPLACE(@inputString, 'Quick Bites', 'Quick Chicken Bites');
END;

UPDATE Zomato
SET RestaurantType = dbo.ReplaceQuickBitesWithChicken(RestaurantType)
WHERE RestaurantType LIKE '%Quick Bites%'

--2. Use the function to display the restaurant name and cuisine type which has the
--maximum number of rating.
SELECT 
    RestaurantName,Rating,
    dbo.ReplaceQuickBitesWithChicken(CuisinesType) AS CuisineType
FROM 
    Zomato
WHERE 
    Rating = (SELECT MAX(Rating) FROM Zomato);
---OR-------
 select RestaurantName,CuisinesType,No_Of_Rating from Zomato 
 where No_Of_Rating in(select max(No_Of_Rating) from Zomato);

--3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
--start rating, ‘Good’ if it has above 3.5 and below 4 star rating, ‘Average’ if it is above 3
--and below 3.5 and ‘Bad’ if it is below 3 star rating and
 select RestaurantName, RestaurantType,Rating,
 case 
 when Rating>4 then 'Excellent'
 when Rating>3.5 then 'Good'
 when Rating>3 then 'Average'
 else 'Bad'
 end as 'Rating_Status'
 from Zomato
 

--4. Find the Ceil, floor and absolute values of the rating column and display the current
--date and separately display the year, month_name and day.
select CEILING(Rating) as Rating_Ceiling,FLOOR(Rating) as Rating_Floor,ABS(Rating) as absolute_Rating,
datepart(yy,getdate()) as Year_name,datename(mm,getdate()) as month_name,day(getdate()) as day_name from Zomato;

--5. Display the restaurant type and total average cost using rollup.select RestaurantType,sum(AverageCost) as Avg_Cost from Zomatogroup by rollup(RestaurantType);


