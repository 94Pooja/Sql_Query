
select * from Zomato;

/*
Tasks to be performed:
1. Create a stored procedure to display the restaurant name, type and cuisine where the
table booking is not zero.
*/
create procedure  sp_displayRestaurant 
As
begin
select RestaurantName,RestaurantType,CuisinesType from Zomato 
where TableBooking!=0
end

exec sp_displayRestaurant


--2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.
BEGIN TRANSACTION
UPDATE Z
SET Z.CuisinesType='Cafeteria'
--SELECT *
FROM Zomato as Z
WHERE CuisinesType='Cafe'

ROLLBACK TRANSACTION
SELECT * FROM Zomato
--3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.
SELECT --TOP 5
  ROW_NUMBER() OVER(PARTITION BY Area ORDER BY No_Of_Rating DESC) 
  AS Row#,
  Area,RestaurantType, RestaurantName,No_of_Rating,Rating
FROM Zomato ;

--4. Use the while loop to display the 1 to 50.
declare 
   @x int=1;
while @x<=50
begin
   print @x;
   set @x+=1;
end

--5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.
create view Top_rating_restaurant as
select Top 5 * from Zomato order by Rating desc;

select * from Top_rating_restaurant

--6. Create a trigger that give an message whenever a new record is inserted.create trigger new_record 
on Zomato
for
insert
as 
print('you can not insert new record into this table i')
rollback;drop trigger new_recordinsert into Zomato values(7105,'Gulati','Vegiterian',4.5,4000,600,1,1,'Butter Paneer','Pandara Road','Delhi India gate',70)0'