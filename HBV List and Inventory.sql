select A.*,
       B.*
FROM
(
select wnour.get_trimmed_id(t.master_id) as trimmed_id,
       t.* 
from TBV_LIST_BY_DAY t
where t.code = 'HBV'
order by t.promotion_s_date
) A,
(
select t.master_id,
       trunc(t.snapshot_dt) as snapshot_dt,
       ROUND(SUM(t.sellable_ext_price), 0) as sellable_ext_price,
       ROUND(SUM(t.white_total_qty)+SUM(t.red_qty_total_qty), 0) as sellable_qty
  from dw_summary_schema.INV_OBS_SNAPSHOT t
 where t.snapshot_dt = trunc(sysdate)
   and t.performance_category <> 'AUCTION'
   and t.p1 > 0
   and t.sellable_status like ('SELLABLE%')
group by t.master_id,
         trunc(t.snapshot_dt)
) B
WHERE A.master_id = B.master_id(+)
