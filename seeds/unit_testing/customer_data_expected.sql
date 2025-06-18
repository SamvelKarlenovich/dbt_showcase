-- seeds/unit_testing/customer_data_expected.sql

{{ config(
    schema='customer_data_testing'
) }}

select
  'USA' as Nation,
  'North America' as Region,
  'Alice' as Customer,
  1 as Total_no_of_orders,
  cast('2024-01-01' as date) as Most_recent_order,
  100.5 as Total_price_of_orders