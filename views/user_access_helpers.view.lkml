# Helper view to demonstrate user attribute usage in views
# This view shows various patterns for using user attributes

view: user_access_helpers {

  # Derived table is not needed for this helper view
  # These are just example dimensions showing user attribute usage

  # Show current user's access level
  dimension: user_campaign_access {
    type: string
    sql: '{{ _user_attributes["campaign_access"] }}' ;;
    description: "Shows the current user's campaign access level"
  }

  dimension: user_account_access {
    type: string
    sql: '{{ _user_attributes["account_access"] }}' ;;
    description: "Shows the current user's account access"
  }

  dimension: user_role {
    type: string
    sql: '{{ _user_attributes["user_role"] }}' ;;
    description: "Shows the current user's role"
  }

  # Check if current user is admin
  dimension: is_admin {
    type: yesno
    sql: '{{ _user_attributes["campaign_access"] }}' IN ('all', 'admin') ;;
    description: "Returns Yes if user has admin access"
  }

  # Dynamic label based on user access
  dimension: access_level_label {
    type: string
    sql: CASE
      WHEN '{{ _user_attributes["campaign_access"] }}' IN ('all', 'admin') THEN 'Full Access'
      WHEN '{{ _user_attributes["campaign_access"] }}' LIKE '%EMEA%' THEN 'EMEA Region'
      WHEN '{{ _user_attributes["campaign_access"] }}' LIKE '%US%' THEN 'US Region'
      WHEN '{{ _user_attributes["campaign_access"] }}' LIKE '%APAC%' THEN 'APAC Region'
      ELSE 'Limited Access'
    END ;;
    description: "Friendly label for user's access level"
  }

  # Example: User's email (built-in user attribute)
  dimension: current_user_email {
    type: string
    sql: '{{ _user_attributes["email"] }}' ;;
    description: "Current user's email address"
  }

  # Example: Conditional measure based on user permission
  measure: total_spend_with_access_check {
    type: number
    sql:
      {% if _user_attributes["can_view_pii"] == 'yes' %}
        SUM(${TABLE}.spend)
      {% else %}
        NULL
      {% endif %}
    ;;
    description: "Only shows spend if user has PII access"
    value_format_name: usd_0
  }
}
