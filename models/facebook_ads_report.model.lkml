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

# ========================================
# ACCESS GRANTS - Control who can access what
# ========================================

access_grant: facebook_ads_full_access {
  user_attribute: facebook_ads_access_level
  allowed_values: ["admin"]
}

access_grant: facebook_ads_manager_access {
  user_attribute: facebook_ads_access_level
  allowed_values: ["admin", "manager"]
}

access_grant: facebook_ads_analyst_access {
  user_attribute: facebook_ads_access_level
  allowed_values: ["admin", "manager", "analyst"]
}

access_grant: facebook_ads_viewer_access {
  user_attribute: facebook_ads_access_level
  allowed_values: ["admin", "manager", "analyst", "viewer"]
}

# ========================================
# EXPLORES WITH ROW-LEVEL SECURITY
# ========================================

explore: facebook_ads__account_report {
  label: "Facebook Ads - Account Report"
  description: "Account performance with row-level security"

  access_filter: {
    field: account_name
    user_attribute: facebook_ads_account_access
  }

  required_access_grants: [facebook_ads_viewer_access]
}

explore: facebook_ads__campaign_report {
  label: "Facebook Ads - Campaign Report"
  description: "Campaign performance with row-level security"

  access_filter: {
    field: account_name
    user_attribute: facebook_ads_account_access
  }

  access_filter: {
    field: campaign_name
    user_attribute: facebook_ads_campaign_access
  }

  required_access_grants: [facebook_ads_viewer_access]
}

explore: facebook_ads__ad_set_report {
  label: "Facebook Ads - Ad Set Report"
  description: "Ad set performance with row-level security"

  access_filter: {
    field: account_name
    user_attribute: facebook_ads_account_access
  }

  access_filter: {
    field: campaign_name
    user_attribute: facebook_ads_campaign_access
  }

  required_access_grants: [facebook_ads_viewer_access]
}

explore: facebook_ads__ad_report {
  label: "Facebook Ads - Ad Report"
  description: "Ad performance with row-level security"

  join: int_facebook_ads__creative_history {
    type: left_outer
    sql_on: ${facebook_ads__ad_report.ad_id} = ${int_facebook_ads__creative_history.creative_id} ;;
    relationship: many_to_one
  }

  access_filter: {
    field: account_name
    user_attribute: facebook_ads_account_access
  }

  access_filter: {
    field: campaign_name
    user_attribute: facebook_ads_campaign_access
  }

  required_access_grants: [facebook_ads_viewer_access]
}
