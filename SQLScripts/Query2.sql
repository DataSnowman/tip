Select top 100  

   count(distinct cs_order_number) as "order count" 

  ,sum(cs_ext_ship_cost) as "total shipping cost" 

  ,sum(cs_net_profit) as "total net profit" 

from 

   hack.catalog_sales cs1 

  ,hack.date_dim 

  ,hack.customer_address 

  ,hack.call_center 

where 

    hack.date_dim.d_date between '1999-3-01' and  

   dateadd(day, 60, cast('1999-3-01' as date)) 

and cs1.cs_ship_date_sk = d_date_sk 

and cs1.cs_ship_addr_sk = ca_address_sk 

and ca_state = 'TX' 

and cs1.cs_call_center_sk = cc_call_center_sk 

and cc_county in ('Jefferson Davis Parish','Gage County','Sierra County','Pennington County', 

                  'Wadena County' 

) 

and exists (select * 

            from hack.catalog_sales cs2 

            where cs1.cs_order_number = cs2.cs_order_number 

              and cs1.cs_warehouse_sk <> cs2.cs_warehouse_sk) 

and not exists(select * 

               from hack.catalog_returns cr1 

               where cs1.cs_order_number = cr1.cr_order_number) 

order by count(distinct cs_order_number)