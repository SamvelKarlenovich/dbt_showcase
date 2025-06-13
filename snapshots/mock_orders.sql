{% snapshot mock_orders %}

{% set new_schema = target.schema + '_snapshot' %}
    {{
        config(
            target_schema=new_schema,
            target_database='pc_dbt_db',
            unique_key='order_id',

            strategy='timestamp',
            updated_at='updated_at'
        )
    }}

    select * from pc_dbt_db.{{target.schema}}.mock_orders
 {% endsnapshot %}