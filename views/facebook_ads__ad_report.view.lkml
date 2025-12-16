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
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: ad_id {
    type: number
    sql: ${TABLE}.ad_id ;;
  }

  dimension: ad_name {
    type: string
    sql: ${TABLE}.ad_name ;;
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

    link: {
      label: "👥 Edit Targeting"
      icon_url: "https://www.facebook.com/favicon.ico"
      url: "https://business.facebook.com/adsmanager/manage/adsets?act={{ account_id._value }}"
    }
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
    full_suggestions: yes

    link: {
      label: "📊 View Campaign Performance"
      icon_url: "http://www.looker.com/favicon.ico"
      url: "/dashboards/facebook_campaign_detail?Campaign+Name={{ value | encode_uri }}"
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
  }

  dimension: conversion_domain {
    type: string
    sql: ${TABLE}.conversion_domain ;;
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

  # Measures
  measure: count {
    type: count
    drill_fields: [ad_name, campaign_name, account_name, ad_set_name]
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
    description: "Spend bucketed into tiers"
    tiers: [0, 100, 500, 1000, 5000, 10000, 50000]
    sql: ${spend} ;;
    style: interval
    value_format_name: usd_0
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
