create database project
use  project

select * from books
select * from customers  
select * from orders 

-- basic query 

-- Retrieve all books in the "Fiction" genre.
select book_id, title
from books 
where genre ='fiction'

-- Find books published after the year 1950
select book_id, title ,published_year
from  books 
where published_year < 1950

--List all customers from the Canada.
select name 
from customers 
where country ='canada'

---Show orders placed in November 2023.
select * from orders 
where order_date >= '2023-11-01'and order_date <'2023-12-01'

--Retrieve the total stock of books available.
select sum(isnull(stock,0)) as 'Total stock'
from books 

--- Find the details of the most expensive book.
select top 1 *
from books 
order by prices desc

--- Show all customers who ordered more than 1 quantity of a book
select customer_id , quantity 
from orders 
where quantity >1

--Retrieve all orders where the total amount exceeds $20
select * FROM orders 
where total_amount > $20

---List all genres available in the Books table.
select genre from books 
group by genre 

--Find the book with the lowest stock.
select top 1 *
from books 
order by stock asc 

--- Calculate the total revenue generated from all orders.
select sum(isnull(TOTAL_amount,0)) as revenue 
from orders 

--Advance Queries 

---Retrieve the total number of books sold for each genre. 
select b.genre , sum(o.Quantity) as 'no.books sold'
from books b
inner join orders o on b.Book_id = o.book_id
group by b.genre 

--Find the average price of books in the "Fantasy" genre.

select avg(isnull(prices,0)) as Avgprice , genre 
from books 
where genre = 'fantasy'
group by genre

-- List customers who have placed at least 2 orders.
select c.name ,count(o.quantity)as orders  
from customers c
inner join orders o on c.customer_id = o.customer_id
group by c.name,c.customer_id 
having count(o.quantity)>=2
order by c.customer_id

--Find the most frequently ordered book.
select b.title,count(o.order_id) as 'frequently ordered'
from books b
inner join orders o on b.book_id= o.book_id 
group by b.title 

--Show the top 3 most expensive books of 'Fantasy' Genre.
select top 3 b.title ,b.prices 
from books b 
where genre ='fantasy'
order by b.prices desc 

--- Retrieve the total quantity of books sold by each author.
select b.author, sum(isnull(o.quantity,0)) as 'total quantity '
from books b
inner join orders o on b.book_id = o.book_id
group by b.author 

---List the cities where customers who spent over $30 are located.
select  distinct c.city 
from customers c
inner join orders o on c.customer_id = o.customer_id
group by c.city,c.customer_id
having sum(o.total_amount)>30

--- Find the customer who spent the most on orders.
select top 1 c.name ,c.customer_id ,sum(o.total_amount) as 'total spent'
from customers c 
inner join orders o on c.customer_id = o.customer_id 
group by c.name,c.customer_id
order by 'total spent' desc

---Calculate the stock remaining after fulfilling all orders.
select b.book_id , b.title ,b.stock ,
COALESCE(sum(o.quantity),0) as Quantity,
b.stock - COALESCE(sum(o.quantity),0) as Remaining_quantity
from books b 
left join orders o on b.book_id = o.book_id
group by  b.book_id , b.title ,b.stock
order by b.book_id 
