{% if not var("enable_harvest_projects_source") %}
{{
    config(
        enabled=false
    )
}}
{% endif %}

WITH source AS (
  {{ filter_stitch_table(var('stitch_schema'),var('stitch_clients_table'),'id') }}
),
renamed as (
  SELECT
    concat('{{ var('id-prefix') }}',id) AS company_id,
    replace(replace(replace(name,'Limited',''),'ltd',''),', Inc.','') AS company_name,
    address as company_address,
    cast (null as string) AS company_address2,
    cast (null as string) AS company_city,
    cast (null as string) AS company_state,
    cast (null as string) AS company_country,
    cast (null as string) AS company_zip,
    cast (null as string) AS company_phone,
    cast (null as string) AS company_website,
    cast (null as string) AS company_industry,
    cast (null as string) AS company_linkedin_company_page,
    cast (null as string) AS company_linkedin_bio,
    cast (null as string) AS company_twitterhandle,
    cast (null as string) AS company_description,
    cast (null as string) as company_finance_status,
    created_at as company_created_date,
    updated_at as company_last_modified_date
FROM
  source
)
SELECT
  *
FROM
  renamed
