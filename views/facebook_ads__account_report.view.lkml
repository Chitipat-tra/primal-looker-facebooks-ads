# The name of this view in Looker is "Facebook Ads Account Report"
view: facebook_ads__account_report {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `facebook_ads_facebook_ads.facebook_ads__account_report` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account ID" in Explore.

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_status {
    type: string
    sql: ${TABLE}.account_status ;;
  }

  dimension: business_country_code {
    type: string
    sql: ${TABLE}.business_country_code ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.conversions ;;
  }

  dimension: conversions_value {
    type: number
    sql: ${TABLE}.conversions_value ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension_group: date_day {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_day ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: source_relation {
    type: string
    sql: ${TABLE}.source_relation ;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
  }

  dimension: timezone_name {
    type: string
    sql: ${TABLE}.timezone_name ;;
  }

  # Measures
  measure: count {
    type: count
    drill_fields: [account_name, timezone_name]
  }

  measure: total_spend {
    type: sum
    sql: ${spend} ;;
    value_format_name: usd_0
  }

  measure: total_impressions {
    type: sum
    sql: ${impressions} ;;
    value_format_name: decimal_0
  }

  measure: total_clicks {
    type: sum
    sql: ${clicks} ;;
    value_format_name: decimal_0
  }

  measure: total_conversions {
    type: sum
    sql: ${conversions} ;;
    value_format_name: decimal_1
  }

  measure: total_conversions_value {
    type: sum
    sql: ${conversions_value} ;;
    value_format_name: usd_0
  }

  # Calculated Measures
  measure: cpm {
    label: "CPM"
    description: "Cost per thousand impressions"
    type: number
    sql: SAFE_DIVIDE(${total_spend}, ${total_impressions}) * 1000 ;;
    value_format_name: decimal_1
  }

  measure: ctr {
    label: "CTR"
    description: "Click-through rate"
    type: number
    sql: SAFE_DIVIDE(${total_clicks}, ${total_impressions}) ;;
    value_format_name: percent_2
  }

  measure: cpc {
    label: "CPC"
    description: "Cost per click"
    type: number
    sql: SAFE_DIVIDE(${total_spend}, ${total_clicks}) ;;
    value_format_name: usd_2
  }

  measure: cost_per_conversion {
    label: "Cost per Conversion"
    type: number
    sql: SAFE_DIVIDE(${total_spend}, ${total_conversions}) ;;
    value_format_name: usd_2
  }

  measure: roas {
    label: "ROAS"
    description: "Return on ad spend"
    type: number
    sql: SAFE_DIVIDE(${total_conversions_value}, ${total_spend}) ;;
    value_format_name: decimal_2
  }

  measure: conversion_rate {
    label: "Conversion Rate"
    type: number
    sql: SAFE_DIVIDE(${total_conversions}, ${total_clicks}) ;;
    value_format_name: percent_2
  }
}
