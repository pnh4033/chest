select a.name, id, c.categoryIdx
, (if (c.productIdx is null, c.name, (select d.name from tblproduct d where d.idx=c.productIdx))) as name
, (if (c.productIdx is null, c.price, (select d.price from tblproduct d where d.idx=c.productIdx))) as price
from tblstore a
join tblstorecategory b 
on (a.id=b.storeId)
join tblstoreproduct c
on (b.storeId=c.storeId and b.idx=c.categoryIdx) 
where a.id='b0001'
order by b.sequence asc, c.sequence asc
;









select carname, normalcost, b.name, c.name, d.name
from tblmain a join tblcartype b
on (a.cartype=b.code) join tblfuel c
on (a.fuel=c.code) join tblfuelcost d
on (a.fuelcost=d.code);