# The name of this view in Looker is "Facebook Ads Ad Set Report"
view: facebook_ads__ad_set_report {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `facebook_ads_facebook_ads.facebook_ads__ad_set_report` ;;

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

  dimension: ad_set_id {
    description: "Unique identifier for the ad set"
    type: number
    sql: ${TABLE}.ad_set_id ;;
  }

  dimension: ad_set_name {
    type: string
    sql: ${TABLE}.ad_set_name ;;
    full_suggestions: yes

    link: {
      label: "🎯 View Ad Set Performance"
      icon_url: "http://www.looker.com/favicon.ico"
      url: "/explore/facebook_ads_report/facebook_ads__ad_set_report?fields=facebook_ads__ad_set_report.ad_set_name,facebook_ads__ad_set_report.total_spend,facebook_ads__ad_set_report.total_impressions,facebook_ads__ad_set_report.cpm,facebook_ads__ad_set_report.ctr,facebook_ads__ad_set_report.total_conversions,facebook_ads__ad_set_report.roas&f[facebook_ads__ad_set_report.ad_set_name]={{ value | encode_uri }}"
    }

    link: {
      label: "📱 Open in Facebook Ads Manager"
      icon_url: "https://www.facebook.com/favicon.ico"
      url: "https://business.facebook.com/adsmanager/manage/adsets?act={{ account_id._value }}"
    }
  }

  dimension: bid_strategy {
    description: "Bidding strategy used for the ad set (e.g., lowest_cost, cost_cap)"
    type: string
    sql: ${TABLE}.bid_strategy ;;
  }

  dimension: budget_remaining {
    description: "Remaining budget for the ad set in Thai Baht"
    value_format: "\"฿\"#,##0.00"
    type: number
    sql: ${TABLE}.budget_remaining ;;
  }

  dimension: campaign_id {
    description: "Unique identifier for the campaign"
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: clicks {
    description: "Number of clicks on ad set ads"
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: conversions {
    description: "Number of conversions from ad set ads"
    type: number
    sql: ${TABLE}.conversions ;;
  }

  dimension: conversions_value {
    description: "Total value of conversions in Thai Baht"
    value_format: "\"฿\"#,##0.00"
    type: number
    sql: ${TABLE}.conversions_value ;;
  }

  dimension: daily_budget {
    description: "Daily budget allocated for the ad set in Thai Baht"
    value_format: "\"฿\"#,##0.00"
    type: number
    sql: ${TABLE}.daily_budget ;;
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

  dimension_group: end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.end_at ;;
  }

  dimension: impressions {
    description: "Number of times ad set ads were displayed"
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: optimization_goal {
    description: "Optimization goal set for the ad set (e.g., conversions, reach)"
    type: string
    sql: ${TABLE}.optimization_goal ;;
  }

  dimension: source_relation {
    description: "Source of the data (for data lineage tracking)"
    type: string
    sql: ${TABLE}.source_relation ;;
  }

  dimension: spend {
    description: "Amount spent on the ad set in Thai Baht"
    value_format: "\"฿\"#,##0.00"
    type: number
    sql: ${TABLE}.spend ;;
  }

  dimension_group: start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.start_at ;;
  }

  # Measures
  measure: count {
    description: "Count of unique ad set records"
    type: count
    drill_fields: [campaign_name, account_name, ad_set_name]
  }

  measure: total_spend {
    description: "Total amount spent on ad sets in Thai Baht"
    type: sum
    sql: ${spend} ;;
    value_format: "\"฿\"#,##0.00"
  }

  measure: total_impressions {
    description: "Total number of times ad set ads were displayed"
    type: sum
    sql: ${impressions} ;;
    value_format: "#,##0.00"
  }

  measure: total_clicks {
    description: "Total number of clicks on ad set ads"
    type: sum
    sql: ${clicks} ;;
    value_format: "#,##0.00"
  }

  measure: total_conversions {
    description: "Total number of conversions from ad sets"
    type: sum
    sql: ${conversions} ;;
    value_format: "#,##0.00"
  }

  measure: total_conversions_value {
    description: "Total value of all conversions in Thai Baht"
    type: sum
    sql: ${conversions_value} ;;
    value_format: "\"฿\"#,##0.00"
  }

  # Calculated Measures
  measure: cpm {
    label: "CPM"
    description: "Cost per thousand impressions in Thai Baht (how much it costs to show ads to 1,000 people)"
    type: number
    sql: SAFE_DIVIDE(${total_spend}, ${total_impressions}) * 1000 ;;
    value_format: "#,##0.00"
  }

  measure: ctr {
    label: "CTR"
    description: "Click-through rate - percentage of people who clicked after seeing ad set ads"
    type: number
    sql: SAFE_DIVIDE(${total_clicks}, ${total_impressions}) ;;
    value_format_name: percent_2
  }

  measure: cpc {
    label: "CPC"
    description: "Cost per click in Thai Baht - average amount paid for each click on ad set ads"
    description: "Cost per click"
    type: number
    sql: SAFE_DIVIDE(${total_spend}, ${total_clicks}) ;;
    value_format: "\"฿\"#,##0.00"
  }

  measure: cost_per_conversion {
    label: "Cost per Conversion"
    description: "Average cost to acquire one conversion in Thai Baht for ad sets"
    type: number
    sql: SAFE_DIVIDE(${total_spend}, ${total_conversions}) ;;
    value_format: "\"฿\"#,##0.00"
  }

  measure: roas {
    label: "ROAS"
    description: "Return on ad spend for ad sets - revenue generated per Baht spent (e.g., 3.00 means ฿3 revenue for every ฿1 spent)"
    type: number
    sql: SAFE_DIVIDE(${total_conversions_value}, ${total_spend}) ;;
    value_format_name: decimal_2
  }

  measure: conversion_rate {
    label: "Conversion Rate"
    description: "Percentage of clicks that resulted in conversions for ad sets"
    type: number
    sql: SAFE_DIVIDE(${total_conversions}, ${total_clicks}) ;;
    value_format_name: percent_2
  }

  # Performance Categories
  dimension: performance_category {
    type: string
    description: "Performance category based on ROAS"
    sql: CASE
      WHEN SAFE_DIVIDE(${conversions_value}, NULLIF(${spend}, 0)) >= 3
        THEN '🟢 High Performance (ROAS 3+)'
      WHEN SAFE_DIVIDE(${conversions_value}, NULLIF(${spend}, 0)) >= 1.5
        THEN '🟡 Good Performance (ROAS 1.5-3)'
      WHEN SAFE_DIVIDE(${conversions_value}, NULLIF(${spend}, 0)) >= 1
        THEN '🟠 Break Even (ROAS 1-1.5)'
      WHEN SAFE_DIVIDE(${conversions_value}, NULLIF(${spend}, 0)) > 0
        THEN '🔴 Low Performance (ROAS <1)'
      ELSE '⚪ No ROAS Data'
    END ;;
  }

  dimension: roas_tier {
    type: tier
    description: "ROAS bucketed into tiers"
    tiers: [0, 0.5, 1, 1.5, 2, 3, 5]
    sql: SAFE_DIVIDE(${conversions_value}, NULLIF(${spend}, 0)) ;;
    style: interval
  }

  dimension: spend_tier {
    type: tier
    description: "Spend bucketed into tiers"
    tiers: [0, 100, 500, 1000, 5000, 10000, 50000]
    sql: ${spend} ;;
    style: interval
    value_format: "\"฿\"#,##0.00"
  }

  # Drill Fields
  set: adset_detail {
    fields: [
      ad_set_name,
      campaign_name,
      bid_strategy,
      optimization_goal,
      total_spend,
      total_impressions,
      cpm,
      total_clicks,
      ctr,
      total_conversions,
      cost_per_conversion,
      roas
    ]
  }
}
