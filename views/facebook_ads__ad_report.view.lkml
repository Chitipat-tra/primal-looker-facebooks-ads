# The name of this view in Looker is "Facebook Ads Ad Report"
view: facebook_ads__ad_report {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `facebook_ads_facebook_ads.facebook_ads__ad_report` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account ID" in Explore.

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
    description: "Unique identifier for the Facebook Ads account"
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
    description: "Name of the Facebook Ads account"
  }

  dimension: ad_id {
    type: number
    sql: ${TABLE}.ad_id ;;
    description: "Unique identifier for the ad"
  }

  dimension: ad_name {
    type: string
    sql: ${TABLE}.ad_name ;;
    description: "Name of the individual ad creative"
    full_suggestions: yes

    link: {
      label: "🎬 View Ad Performance"
      icon_url: "http://www.looker.com/favicon.ico"
      url: "/explore/facebook_ads_report/facebook_ads__ad_report?fields=facebook_ads__ad_report.ad_name,facebook_ads__ad_report.total_spend,facebook_ads__ad_report.total_impressions,facebook_ads__ad_report.cpm,facebook_ads__ad_report.ctr,facebook_ads__ad_report.total_conversions,facebook_ads__ad_report.roas&f[facebook_ads__ad_report.ad_name]={{ value | encode_uri }}"
    }

    link: {
      label: "📱 Open in Facebook Ads Manager"
      icon_url: "https://www.facebook.com/favicon.ico"
      url: "https://business.facebook.com/adsmanager/manage/ads?act={{ account_id._value }}"
    }

    link: {
      label: "✏️ Edit Ad Creative"
      icon_url: "https://www.facebook.com/favicon.ico"
      url: "https://business.facebook.com/adsmanager/manage/ads?act={{ account_id._value }}"
    }

    link: {
      label: "📊 View Ad Preview"
      icon_url: "https://www.facebook.com/favicon.ico"
      url: "https://business.facebook.com/adsmanager/manage/ads?act={{ account_id._value }}"
    }
  }

  dimension: ad_set_id {
    type: number
    sql: ${TABLE}.ad_set_id ;;
    description: "Unique identifier for the ad set"
  }

  dimension: ad_set_name {
    type: string
    sql: ${TABLE}.ad_set_name ;;
    description: "Name of the ad set containing this ad"
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

    link: {
      label: "👥 Edit Targeting"
      icon_url: "https://www.facebook.com/favicon.ico"
      url: "https://business.facebook.com/adsmanager/manage/adsets?act={{ account_id._value }}"
    }
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
    description: "Unique identifier for the campaign"
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
    description: "Name of the campaign containing this ad"
    full_suggestions: yes

    link: {
      label: "📊 View Campaign Performance"
      icon_url: "http://www.looker.com/favicon.ico"
      url: "/dashboards/facebook_ads_report::facebook_campaign_detail?Campaign+Name={{ value | encode_uri }}"
    }

    link: {
      label: "📱 Open in Facebook Ads Manager"
      icon_url: "https://www.facebook.com/favicon.ico"
      url: "https://business.facebook.com/adsmanager/manage/campaigns?act={{ account_id._value }}"
    }

    link: {
      label: "📥 Export Campaign Data"
      icon_url: "http://www.looker.com/favicon.ico"
      url: "/explore/facebook_ads_report/facebook_ads__campaign_report?fields=facebook_ads__campaign_report.campaign_name,facebook_ads__campaign_report.total_spend,facebook_ads__campaign_report.total_impressions,facebook_ads__campaign_report.cpm,facebook_ads__campaign_report.ctr,facebook_ads__campaign_report.total_conversions,facebook_ads__campaign_report.roas&f[facebook_ads__campaign_report.campaign_name]={{ value | encode_uri }}"
    }
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
    description: "Number of clicks on the ad"
  }

  dimension: conversion_domain {
    type: string
    sql: ${TABLE}.conversion_domain ;;
    description: "Domain where the conversion occurred"
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.conversions ;;
    description: "Number of conversions attributed to the ad"
  }

  dimension: conversions_value {
    type: number
    sql: ${TABLE}.conversions_value ;;
    description: "Total value of conversions in Thai Baht"
    value_format: "\฿ #,##0.00"
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_day {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_day ;;
    description: "Date when the ad metrics were recorded"
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
    description: "Number of times the ad was displayed"
  }

  dimension: source_relation {
    type: string
    sql: ${TABLE}.source_relation ;;
    description: "Source of the data (for data lineage tracking)"
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
    description: "Amount spent on the ad in Thai Baht"
    value_format: "\฿ #,##0.00"
  }

  # Measures
  measure: count {
    type: count
    drill_fields: [ad_name, campaign_name, account_name, ad_set_name]
    description: "Count of unique ad records"
  }

  measure: total_spend {
    type: sum
    sql: ${spend} ;;
    value_format: "\฿ #,##0.00"
    description: "Total amount spent on ads in Thai Baht"
  }

  measure: total_impressions {
    type: sum
    sql: ${impressions} ;;
    value_format: "#,##0.00"
    description: "Total number of times ads were displayed"
  }

  measure: total_clicks {
    type: sum
    sql: ${clicks} ;;
    value_format: "#,##0.00"
    description: "Total number of clicks on ads"
  }

  measure: total_conversions {
    type: sum
    sql: ${conversions} ;;
    value_format: "#,##0.00"
    description: "Total number of conversions from ads"
  }

  measure: total_conversions_value {
    type: sum
    sql: ${conversions_value} ;;
    value_format: "\฿ #,##0.00"
    description: "Total value of all conversions in Thai Baht"
  }

  # Calculated Measures
  measure: cpm {
    label: "CPM"
    description: "Cost per thousand impressions in Thai Baht (how much it costs to show ads to 1,000 people)"
    type: number
    sql: SAFE_DIVIDE(${total_spend}, ${total_impressions}) * 1000 ;;
    value_format: "\฿ #,##0.00"
  }

  measure: ctr {
    label: "CTR"
    description: "Click-through rate - percentage of people who clicked after seeing the ad"
    type: number
    sql: SAFE_DIVIDE(${total_clicks}, ${total_impressions}) ;;
    value_format_name: percent_2
  }

  measure: cpc {
    label: "CPC"
    description: "Cost per click in Thai Baht - average amount paid for each click"
    type: number
    sql: SAFE_DIVIDE(${total_spend}, ${total_clicks}) ;;
    value_format: "\฿ #,##0.00"
  }

  measure: cost_per_conversion {
    label: "Cost per Conversion"
    description: "Average cost to acquire one conversion in Thai Baht"
    type: number
    sql: SAFE_DIVIDE(${total_spend}, ${total_conversions}) ;;
    value_format: "\฿ #,##0.00"
  }

  measure: roas {
    label: "ROAS"
    description: "Return on ad spend - revenue generated per Baht spent (e.g., 3.00 means ฿3 revenue for every ฿1 spent)"
    type: number
    sql: SAFE_DIVIDE(${total_conversions_value}, ${total_spend}) ;;
    value_format: "#,##0.00"
  }

  measure: conversion_rate {
    label: "Conversion Rate"
    description: "Percentage of clicks that resulted in conversions"
    type: number
    sql: SAFE_DIVIDE(${total_conversions}, ${total_clicks}) ;;
    value_format_name: percent_2
  }

  # Performance Categories & Tiers
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
    description: "Spend bucketed into tiers for analysis (฿0, ฿100, ฿500, ฿1K, ฿5K, ฿10K, ฿50K)"
    tiers: [0, 100, 500, 1000, 5000, 10000, 50000]
    sql: ${spend} ;;
    style: interval
    value_format: "\฿ #,##0.00"
  }

  dimension: ctr_tier {
    type: tier
    description: "CTR bucketed into tiers"
    tiers: [0, 0.005, 0.01, 0.015, 0.02, 0.03]
    sql: SAFE_DIVIDE(${clicks}, NULLIF(${impressions}, 0)) ;;
    style: interval
    value_format_name: percent_2
  }

  # Drill Fields
  set: campaign_detail {
    fields: [
      campaign_name,
      total_spend,
      total_impressions,
      cpm,
      total_clicks,
      ctr,
      total_conversions,
      cost_per_conversion,
      total_conversions_value,
      roas
    ]
  }

  set: adset_detail {
    fields: [
      ad_set_name,
      campaign_name,
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

  set: ad_detail {
    fields: [
      ad_name,
      ad_set_name,
      campaign_name,
      date_day_date,
      total_spend,
      total_impressions,
      cpm,
      total_clicks,
      ctr,
      cpc,
      total_conversions,
      cost_per_conversion,
      roas
    ]
  }

  # Benchmark Filters
  filter: selected_campaigns {
    type: string
    description: "Select campaigns to compare against others"
    suggest_dimension: campaign_name
  }

  dimension: campaign_comparison_group {
    type: string
    description: "Groups campaigns into selected vs. others for benchmarking"
    sql: CASE
      WHEN {% condition selected_campaigns %} ${campaign_name} {% endcondition %}
      THEN ${campaign_name}
      ELSE 'Other Campaigns'
    END ;;
  }

  filter: selected_adsets {
    type: string
    description: "Select ad sets to compare against others"
    suggest_dimension: ad_set_name
  }

  dimension: adset_comparison_group {
    type: string
    description: "Groups ad sets into selected vs. others for benchmarking"
    sql: CASE
      WHEN {% condition selected_adsets %} ${ad_set_name} {% endcondition %}
      THEN ${ad_set_name}
      ELSE 'Other Ad Sets'
    END ;;
  }

  filter: selected_ads {
    type: string
    description: "Select ads to compare against others"
    suggest_dimension: ad_name
  }

  dimension: ad_comparison_group {
    type: string
    description: "Groups ads into selected vs. others for benchmarking"
    sql: CASE
      WHEN {% condition selected_ads %} ${ad_name} {% endcondition %}
      THEN ${ad_name}
      ELSE 'Other Ads'
    END ;;
  }
}
