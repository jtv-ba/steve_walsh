select trunc(t.time1,'IW') as week1,
       trunc(t.time1) as day1,
       min(t.time1) as min_time,
       max(t.time1) as max_time,
       ROUND(SUM(t.order_est),0) as order_est,
       count(t.time1) as num_hours
from ryamcc1.MBALL_DEPT_ESTIMATE_VW t
where t.time1 >= trunc(sysdate)
  and t.plan_order_pp is not null
group by trunc(t.time1,'IW'),
         trunc(t.time1)
order by trunc(t.time1);


select trunc(a.time2,'IW') as week,
       trunc(a.time2) as time,
       min(a.time1) as min_time,
       max(a.time1) as max_time,
       to_char(a.time2,'DY') as day,
       ROUND(SUM(case when to_char(a.time2,'HH24') >= 0 and to_char(a.time2,'HH24') < 12 THEN A.order_est ELSE 0 END),0) as shift_orders,
       ROUND(SUM(case when to_char(a.time2,'HH24') >= 12 and to_char(a.time2,'HH24') < 24 THEN A.order_est ELSE 0 END),0) as non_shift_orders,
       ROUND(SUM(A.order_est),0) as total_orders_6_6,
       count(a.time2) as num_hours
FROM
(
select t.time1,
       t.time1-(6/24) as time2,
       t.order_est
from ryamcc1.MBALL_DEPT_ESTIMATE_VW t
where t.time1 >= trunc(sysdate)-(6/24)
  and t.plan_order_pp is not null
order by t.time1
) A
group by trunc(a.time2),
         to_char(a.time2,'DY')
order by trunc(a.time2)
