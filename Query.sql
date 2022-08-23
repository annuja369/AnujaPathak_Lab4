use `order-directory`;

-- Q3) Display the total number of customers based on gender who have placed orders of worth at least Rs. 3000. --

select count(t2.cus_gender) as NoOfCustomers, t2.cus_gender from
(select t1.cus_id, t1.cus_gender,t1.ord_amount, t1.cus_name from
(select 'order'.*, customer.cus_gender, customer.cus_name from 'order' inner join customer where 'order'.cus_id=customer.cus_id having 
'order'.ord_amount>=3000)
as t1 group by t1.cus_id) as t1 group by t2.cus_gender;
 

-- Q4) Display all the orders along with product name ordered by a customer having customer_ID=2. --

select product.pro_name,
'order' .* from 'order', supplier_pricing, product
where 'order'.cus_id=2 and
'order'.pricing_id=spplier_pricing.pricing_id and supplier_pricing.pro_id=product.pro_id;


-- Q5) Display the supplier detalis who can supply more than one product. --

select supplier.* from supplier where supplier.supp_id in
(select supp_id from supplier_pricing group by supp_id having
count(supp_id)>1)
group by supplier.supp_id;


-- Q6) Find the least expensive product from each category and print the table with category id, name, product name and price of the product. --

select category.cat_id,category.cat_name, min(t3.min_price) as min_Price from category inner join
(select product.cat.id,product.pro_name, t2.* from product inner join
(select pro_id, min(supp_price) as min_price from supplier_pricing group by pro_id) 
 as t2 where t2.pro_id = product.pro_id)
 as t3 where t3.cat_id = category.cat_id group by t3.cat_id;
 
-- Q7)	Display the Id and Name of the Product ordered after “2021-10-05”.--

select product.pro_id,product.pro_name from 'order' inner join supplier_pricing 
on supplier_pricing.pricing_id='order'.pricing_id inner join product
on product.pro_id=supplier_pricing.pro_id where 'order'.ord_date>"2021-10-05";

-- Q8)	Display customer name and gender whose names start or end with character 'A'.

select  customer.cus_name,customer.cus_gender from customer where customer.cus_name like 'A%' or customer.cus_name like '%A' ;

-- 9)	Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.--

select report.supp_id,report.supp_name,report.Average,
CASE
WHEN.report.Average.=5 THEN 'Excellentservice'
WHEN.report.Average.=4 THEN 'Good Service'
WHEN.report.Average.=2 THEN 'Average Service'
ELSE 'Poor Service'
END AS Type_of_Service from
(select final.supp_id, supplier.supp_name,final.Average from
(select test2.supp_id, sum(test2.rat_ratstars)/count(test2.rat_ratstars) as Average from
(select supplier_pricing.supp_id, test.ORD_ID, test.RAT_RATSTARS from supplier_pricing inner join 
(select 'order'.pricing_id, rating.ORD_ID, rating.RAT_RATSTARS from 'order' inner join rating  on rating.'ord_id'= 'order' .ord_id) as test 
on test.pricing group by supplier_pricing.supp_id)
as test2 group by supplier_pricing.supp_id)
as final inner join supplier when final.supp_id = supplier.supp_id0 as report;
END &&
DELIMITER;
call proc();
