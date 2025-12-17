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
    description: "Unique identifier for the Facebook Ads account"
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    description: "Name of the Facebook Ads account"
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_status {
    description: "Current status of the Facebook Ads account (e.g., active, disabled)"
    type: string
    sql: ${TABLE}.account_status ;;
  }

  dimension: business_country_code {
    description: "Country code of the business associated with the account"
    type: string
    sql: ${TABLE}.business_country_code ;;
  }

  dimension: clicks {
    description: "Number of clicks on account ads"
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: conversions {
    description: "Number of conversions from account ads"
    type: number
    sql: ${TABLE}.conversions ;;
  }

  dimension: conversions_value {
    description: "Total value of conversions in Thai Baht"
    value_format: "\฿ #,##0.00"
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
    description: "Currency used by the account (should be THB for Thai Baht)"
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
    description: "Number of times account ads were displayed"
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: source_relation {
    description: "Source of the data (for data lineage tracking)"
    type: string
    sql: ${TABLE}.source_relation ;;
  }

  dimension: spend {
    description: "Amount spent on account ads in Thai Baht"
    value_format: "\฿ #,##0.00"
    type: number
    sql: ${TABLE}.spend ;;
  }

  dimension: timezone_name {
    description: "Timezone setting for the account"
    type: string
    sql: ${TABLE}.timezone_name ;;
  }

  # Measures
  measure: count {
    description: "Count of unique account records"
    type: count
    drill_fields: [account_name, timezone_name]
  }

  measure: total_spend {
    description: "Total amount spent across all account ads in Thai Baht"
    type: sum
    sql: ${spend} ;;
    value_format: "\฿ #,##0.00"
  }

  measure: total_impressions {
    description: "Total number of times account ads were displayed"
    type: sum
    sql: ${impressions} ;;
    value_format: "#,##0.00"
  }

  measure: total_clicks {
    description: "Total number of clicks on account ads"
    type: sum
    sql: ${clicks} ;;
    value_format: "#,##0.00"
  }

  measure: total_conversions {
    description: "Total number of conversions from account ads"
    type: sum
    sql: ${conversions} ;;
    value_format: "#,##0.00"
  }

  measure: total_conversions_value {
    description: "Total value of all conversions in Thai Baht"
    type: sum
    sql: ${conversions_value} ;;
    value_format: "\฿ #,##0.00"
  }

  # Calculated Measures
  measure: cpm {
    label: "CPM"
    description: "Cost per thousand impressions"
    type: number
    sql: SAFE_DIVIDE(${total_spend}, ${total_impressions}) * 1000 ;;
    value_format: "#,##0.00"
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
    value_format: "\฿ #,##0.00"
  }

  measure: cost_per_conversion {
    label: "Cost per Conversion"
    type: number
    sql: SAFE_DIVIDE(${total_spend}, ${total_conversions}) ;;
    value_format: "\฿ #,##0.00"
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
