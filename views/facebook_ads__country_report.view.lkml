# The name of this view in Looker is "Facebook Ads Country Report"
view: facebook_ads__country_report {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `facebook_ads_facebook_ads.facebook_ads__country_report` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account Business Country Code" in Explore.

  dimension: account_business_country_code {
    type: string
    sql: ${TABLE}.account_business_country_code ;;
  }

  dimension: account_currency {
    type: string
    sql: ${TABLE}.account_currency ;;
  }

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_min_daily_budget {
    type: number
    sql: ${TABLE}.account_min_daily_budget ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_timezone {
    type: string
    sql: ${TABLE}.account_timezone ;;
  }

  dimension: account_timezone_offset_hours_utc {
    type: number
    sql: ${TABLE}.account_timezone_offset_hours_utc ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.conversions ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: country_id {
    type: string
    sql: ${TABLE}.country_id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_day {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_day ;;
  }

  dimension: frequency {
    type: number
    sql: ${TABLE}.frequency ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: reach {
    type: number
    sql: ${TABLE}.reach ;;
  }

  dimension: source_relation {
    type: string
    sql: ${TABLE}.source_relation ;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
  }
  measure: count {
    type: count
    drill_fields: [account_name]
  }
}
