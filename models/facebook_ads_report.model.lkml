# Define the database connection to be used for this model.
connection: "primal_poc"

# include all the views
include: "/views/**/*.view.lkml"
include: "/dashboards/**/*.dashboard.lookml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: facebook_ads_report_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: facebook_ads_report_default_datagroup

# Explores
explore: facebook_ads__account_report {
  label: "Facebook Ads - Account Performance"
  description: "Account-level Facebook Ads performance metrics"
}

explore: facebook_ads__campaign_report {
  label: "Facebook Ads - Campaign Performance"
  description: "Campaign-level Facebook Ads performance metrics"
}

explore: facebook_ads__ad_set_report {
  label: "Facebook Ads - Ad Set Performance"
  description: "Ad Set-level Facebook Ads performance metrics"
}

explore: facebook_ads__ad_report {
  label: "Facebook Ads - Ad Performance"
  description: "Ad-level Facebook Ads performance metrics"

  join: int_facebook_ads__creative_history {
    type: left_outer
    sql_on: ${facebook_ads__ad_report.ad_id} = ${int_facebook_ads__creative_history.creative_id} ;;
    relationship: many_to_one
  }
}

