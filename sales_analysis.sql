use ac

-- sales info with names and categories of products
select s.Date, pr.Product, pr.Category, pr.Product_ID, s.Product, s.Amount
from sales s
join products pr on pr.Product_ID = s.Product


--shipments with sales person name and team
select s.Date, p.Sales_person, p.Team, s.Amount
from sales s
join people p on p.SP_ID = s.Sales_Person

--bars shipments alone
select s.Date, pr.Product, pr.Category, pr.Product_ID, s.Product, s.Amount
from sales s
join products pr on pr.Product_ID = s.Product
where pr.Category = 'Bars'

--Barr Shipments alone
select s.Date, p.Sales_person, p.Team, s.Amount
from sales s
join people p on p.SP_ID = s.Sales_Person and p.Sales_person = 'Barr Faughny'

select s.Date, p.Sales_person, p.Team, s.Amount
from sales s
join people p on p.SP_ID = s.Sales_Person 
where p.Sales_person = 'Barr Faughny'

-- bars Barr Sales
select s.Date, p.Sales_person, p.Team, s.Amount, pr.Category, pr.Product
from sales s
join people p on p.SP_ID = s.Sales_Person 
join products pr on pr.Product_ID = s.Product 
where p.Sales_person = 'Barr Faughny' and
	pr.Category = 'Bars'
order by s.Amount desc

--bar barr shipments, grouped by month
select FORMAT(s.date, 'MMM yy') as "Month", sum(s.amount) "Sales", SUM(s.boxes) "Boxes"
from sales s
join people p on p.SP_ID = s.Sales_Person 
join products pr on pr.Product_ID = s.Product 
where pr.Category = 'Bars' and p.Sales_person = 'Barr Faughny'

group by FORMAT(s.date, 'MMM yy')

--left join: all products join on sales
select pr.Product_ID, pr.Product, s.Product, s.Amount, s.Date
from products pr 
left join sales s on pr.Product_ID = s.Product

--anti join which products havent been sold
select pr.Product_ID, pr.Product, s.Product, s.Amount, s.Date
from products pr 
left join sales s on pr.Product_ID = s.Product
where s.Product = 'Choco Jello'

--did we ship all the products from 1 feb 2022
with febprods as (
				select s.Date, s.Amount, pr.Product
				from products pr 
				left join sales s on pr.Product_ID=s.Product and Date ='2022-02-01')
select 
	Product, sum(amount) as "Sales",
	"Sales status" = 
		case when sum(amount)>0 then 'Shipped'
		else 'Not Shipped'
	end
from febprods
group by Product