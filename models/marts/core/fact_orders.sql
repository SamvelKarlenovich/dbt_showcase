with orders as (
    select * from {{ ref('stg_orders')}}

),

payments as (
    select * from {{ ref('stg_payments')}}
),

fact_orders as (
    select 
        o.order_id,
        p.payment_id,
        p.amount
    from orders o
    left join payments p on o.order_id = p.order_id
)

select * from fact_orders
