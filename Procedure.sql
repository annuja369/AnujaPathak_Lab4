CREATE DEFINER='root'@'localhost' PROCEDURE 'procedure_latest'()
BEGIN
SELECT report.supp_id,report.supp_name,report.Average,
CASE
WHEN report.Average =5 THEN 'Excellent Service'
WHEN report.Average =4 THEN 'Good Service'
WHEN report.Average =2 THEN 'Average Service'
ELSE 'Poor Service'
END AS Type_Of_Service from
(select final.supp_id, supplier.supp_name, final.Average from
(select test2.supp_id, sum(test2.rat_ratstars)/count(test2.rat_ratstars) as Average from
(select supplier_pricing_supp_id, test.ORD_ID, test.RAT_RATSTARS from supplier_pricing inner join
(select 'order'.pricing_id, rating.ORD_ID, rating.RAT_RATSTARS from 'order' inner join rating on rating.'ord_id' = 'order.orderid'
on test.pricing_id = supplier_pricing.pricing_id)
on test2 group by supplier_pricing.supp_id)
as final inner join supplier where final.supp_id = supplier.supp_id) as report;
