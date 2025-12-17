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

# Access Grants - Reusable permission logic
# These can be used across multiple explores for consistent access control

access_grant: can_see_all_campaigns {
  user_attribute: campaign_access
  allowed_values: ["all", "admin"]
}

access_grant: can_see_pii {
  user_attribute: can_view_pii
  allowed_values: ["yes"]
}

access_grant: is_regional_manager {
  user_attribute: user_role
  allowed_values: ["regional_manager", "admin"]
}

# Explores with Row-Level Access Control

explore: facebook_ads__account_report {
  label: "Facebook Ads - Account Performance"
  description: "Account-level Facebook Ads performance metrics"

  # Option 1: Filter by Account ID
  # Users can only see data for their assigned account(s)
  # User attribute: account_access (comma-separated account IDs, or "all")
  sql_always_where:
    {% if _user_attributes['account_access'] == 'all' %}
      1=1
    {% else %}
      ${account_id} IN (
        {% assign accounts = _user_attributes['account_access'] | split: ',' %}
        {% for account in accounts %}
          {{ account }}{% unless forloop.last %},{% endunless %}
        {% endfor %}
      )
    {% endif %}
  ;;
}

explore: facebook_ads__campaign_report {
  label: "Facebook Ads - Campaign Performance"
  description: "Campaign-level Facebook Ads performance metrics"

  # Option 2: Access Filters - Filter by Campaign Name Pattern
  # Users can only see campaigns matching their assigned pattern
  # User attribute: campaign_access (e.g., "EMEA_%", "US_%", or "all")
  access_filter: {
    field: campaign_name
    user_attribute: campaign_access
  }

  # Additional filter by account if needed
  sql_always_where:
    {% if _user_attributes['account_access'] != 'all' and _user_attributes['account_access'] != '' %}
      ${account_id} IN (
        {% assign accounts = _user_attributes['account_access'] | split: ',' %}
        {% for account in accounts %}
          {{ account }}{% unless forloop.last %},{% endunless %}
        {% endfor %}
      )
    {% else %}
      1=1
    {% endif %}
  ;;

  # Conditionally hide fields based on permissions
  fields: [ALL_FIELDS*, -campaign_report_pii*]

  # Override to show PII fields if user has permission
  conditionally_filter: {
    filters: [campaign_name: ""]
    unless: [can_see_all_campaigns]
  }
}

explore: facebook_ads__ad_set_report {
  label: "Facebook Ads - Ad Set Performance"
  description: "Ad Set-level Facebook Ads performance metrics"

  # Option 3: Multiple User Attributes Combined
  # Filter by both campaign pattern AND account
  access_filter: {
    field: campaign_name
    user_attribute: campaign_access
  }

  sql_always_where:
    {% if _user_attributes['account_access'] != 'all' and _user_attributes['account_access'] != '' %}
      ${account_id} IN (
        {% assign accounts = _user_attributes['account_access'] | split: ',' %}
        {% for account in accounts %}
          {{ account }}{% unless forloop.last %},{% endunless %}
        {% endfor %}
      )
    {% else %}
      1=1
    {% endif %}
  ;;

  # Require at least one filter unless user has admin access
  conditionally_filter: {
    filters: [date_day_date: "30 days"]
    unless: [can_see_all_campaigns]
  }
}

explore: facebook_ads__ad_report {
  label: "Facebook Ads - Ad Performance"
  description: "Ad-level Facebook Ads performance metrics"

  join: int_facebook_ads__creative_history {
    type: left_outer
    sql_on: ${facebook_ads__ad_report.ad_id} = ${int_facebook_ads__creative_history.creative_id} ;;
    relationship: many_to_one
  }

  # Option 4: Complex Row-Level Security with Multiple Conditions
  # Combines campaign access, account access, and date restrictions
  access_filter: {
    field: campaign_name
    user_attribute: campaign_access
  }

  sql_always_where:
    -- Account-level access control
    (
      {% if _user_attributes['account_access'] == 'all' %}
        1=1
      {% elsif _user_attributes['account_access'] != '' %}
        ${account_id} IN (
          {% assign accounts = _user_attributes['account_access'] | split: ',' %}
          {% for account in accounts %}
            {{ account }}{% unless forloop.last %},{% endunless %}
          {% endfor %}
        )
      {% else %}
        1=1
      {% endif %}
    )
    -- Date restriction for non-admin users (optional)
    {% if _user_attributes['campaign_access'] != 'all' and _user_attributes['campaign_access'] != 'admin' %}
      AND ${date_day_date} >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)
    {% endif %}
  ;;

  # Conditionally require filters for non-admin users
  conditionally_filter: {
    filters: [date_day_date: "30 days"]
    unless: [can_see_all_campaigns]
  }
}

