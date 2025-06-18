
{% set import_customer = select_table(source("source", "customer"), ref("input_customers")) %}
{% set import_orders = select_table(source("source", "orders"), ref("input_orders")) %}
{% set import_nation = select_table(source("source", "nation"), ref("input_nations")) %}
{% set import_region = select_table(source("source", "region"), ref("input_regions")) %}

with
    customer as (select * from {{ import_customer }}),
    orders as (select * from {{ import_orders }}),
    region as (select * from {{ import_region }}),
    nation as (select * from {{ import_nation }}),
    final as (
        select
            n_name as nation,
            r_name as region,
            c_name as customer,
            count(o_orderkey) as total_no_of_orders,
            max(o_orderdate) as most_recent_order,
            sum(o_totalprice) as total_price_of_orders
        from customer cust
        inner join orders ord on cust.c_custkey = ord.o_custkey
        inner join nation nat on cust.c_nationkey = nat.n_nationkey
        inner join region reg on nat.n_regionkey = reg.r_regionkey
        group by n_name, r_name, c_name
    )

select *
from final
