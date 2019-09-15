
## updating the date column in table bajaj
update bajaj set date=str_to_date(Date,"%d-%M-%Y");
select * from bajaj;
alter table bajaj
modify Date date;


##creating table bajaj1 as per the requirement##
create table bajaj1 as
select Date,(`Close Price`) as `Close Price`,
avg(`Close Price`) over (order by `Date` asc rows between 19 preceding and current one) as'MA20',
avg(`Close Price`) over (order by `Date` asc rows between 49 preceding and current one) as'MA50'
from bajaj;




##updating the date column in table eicher
update eicher set date=str_to_date(Date,"%d-%M-%Y");
alter table eicher 
modify Date date;

select * from eicher;

##creating eicher1 as per requirement##
create table eicher1 as
select Date,(`Close Price`) as 'Close Price',
avg(`Close Price`) over (order by `Date` asc rows between 19 preceding and current one) as'MA20',
avg(`Close Price`) over (order by `Date` asc rows between 49 preceding and current one) as'MA50'
from eicher;

##updating the date column in table heromotocorp
update heromotocorp set date=str_to_date(Date,"%d-%M-%Y");
alter table heromotocorp
modify Date date;
select * from heromotocorp;


##creating hero1 as per requirement##
create table hero1 as
select Date,(`Close Price`) as 'Close Price',
avg(`Close Price`) over (order by `Date` asc rows between 19 preceding and current one) as'MA20',
avg(`Close Price`) over (order by `Date` asc rows between 49 preceding and current one) as'MA50'
from heromotocorp;


##updating the date column in table infosys
update infosys set date=str_to_date(Date,"%d-%M-%Y");
alter table infosys
modify Date date;
select * from infosys;



##creating infy1 as per requirement##
create table infy1 as
select Date,(`Close Price`) as 'Close Price',
avg(`Close Price`) over (order by `Date` asc rows between 19 preceding and current one) as'MA20',
avg(`Close Price`) over (order by `Date` asc rows between 49 preceding and current one) as'MA50'
from infosys;

##updating the date column in table tcs
update tcs set date=str_to_date(Date,"%d-%M-%Y");
alter table tcs
modify Date date;
select * from tcs;

##creating tcs1 as per requirement##
create table tcs1 as
select Date,(`Close Price`) as 'Close Price',
avg(`Close Price`) over (order by `Date` asc rows between 19 preceding and current one) as'MA20',
avg(`Close Price`) over (order by `Date` asc rows between 49 preceding and current one) as'MA50'
from tcs;

##updating the date column in table tvs
update tvs set date=str_to_date(Date,"%d-%M-%Y");
alter table tvs
modify Date date;
select * from tvs;

##creating tvs1 as per requirement##
create table tvs1 as
select Date,(`Close Price`) as 'Close Price',
avg(`Close Price`) over (order by `Date` asc rows between 19 preceding and current one) as'MA20',
avg(`Close Price`) over (order by `Date` asc rows between 49 preceding and current one) as'MA50'
from tvs;

##creating master table
create table MASTER_TABLE AS
select bajaj.Date,bajaj.`Close Price` as BAJAJ,
eicher.`Close Price` as EICHER,
heromotocorp.`Close Price` as HERO,
infosys.`Close Price` as infosys,tcs.`Close Price` as TCS,
tvs.`Close Price` as TVS
from bajaj inner JOIN eicher on bajaj.Date=eicher.Date inner  join heromotocorp on eicher.Date=heromotocorp.Date
inner join infosys on heromotocorp.Date=infosys.Date inner join tcs on infosys.Date=tcs.Date inner join tvs on tcs.Date=tvs.Date;

select * from master_table;


##creating table bajaj2 as per requirement
create table bajaj2 as
select `Date`,`Close Price`,
case
when `MA20`>`MA50` and (LAG(`MA20`,1) over w <LAG(`MA50`,1) over w) then "BUY"
when `MA20`<`MA50` and (LAG(`MA20`,1) over w >LAG(`MA50`,1) over w) then "sell"
else "HOLD"
END as "Signal_Value"
from bajaj1
window w as (order by `Date`);
 

##creating table eicher2 as per requirement
create table eicher2 as
select `Date`,`Close Price`,
case
when `MA20`>`MA50` and (LAG(`MA20`,1) over w <LAG(`MA50`,1) over w) then "BUY"
when `MA20`<`MA50` and (LAG(`MA20`,1) over w >LAG(`MA50`,1) over w) then "sell"
else "HOLD"
END as "Signal_Value"
from eicher1
window w as (order by `Date`);


##creating table hero2 as per requirement
create table hero2 as
select `Date`,`Close Price`,
case
when `MA20`>`MA50` and (LAG(`MA20`,1) over w <LAG(`MA50`,1) over w) then "BUY"
when `MA20`<`MA50` and (LAG(`MA20`,1) over w >LAG(`MA50`,1) over w) then "sell"
else "HOLD"
END as "Signal_Value"
from hero1
window w as (order by `Date`);


##creating table infy2 as per requirement
create table infy2 as
select `Date`,`Close Price`,
case
when `MA20`>`MA50` and (LAG(`MA20`,1) over w <LAG(`MA50`,1) over w) then "BUY"
when `MA20`<`MA50` and (LAG(`MA20`,1) over w >LAG(`MA50`,1) over w) then "sell"
else "HOLD"
END as "Signal_Value"
from infy1
window w as (order by `Date`);


##creating table tcs2 as per requirement
create table tcs2 as
select `Date`,`Close Price`,
case
when `MA20`>`MA50` and (LAG(`MA20`,1) over w <LAG(`MA50`,1) over w) then "BUY"
when `MA20`<`MA50` and (LAG(`MA20`,1) over w >LAG(`MA50`,1) over w) then "sell"
else "HOLD"
END as "Signal_Value"
from tcs1
window w as (order by `Date`);


##creating table tvs2 as per requirement
create table tvs2 as
select `Date`,`Close Price`,
case
when `MA20`>`MA50` and (LAG(`MA20`,1) over w <LAG(`MA50`,1) over w) then "BUY"
when `MA20`<`MA50` and (LAG(`MA20`,1) over w >LAG(`MA50`,1) over w) then "sell"
else "HOLD"
END as "Signal_Value"
from tvs1
window w as (order by `Date`);
 
 
 ## creating User defined function for bajaj
delimiter $$
CREATE FUNCTION Bajaj_stocks_signals(N date)
returns varchar(50)
DETERMINISTIC
BEGIN
DECLARE function_showsignal VARCHAR(50);
SELECT bajaj2.`Signal_Value` into function_showsignal from bajaj2 where N=bajaj2.Date;
return (function_showsignal);
end
$$
delimiter;
 
 



 
