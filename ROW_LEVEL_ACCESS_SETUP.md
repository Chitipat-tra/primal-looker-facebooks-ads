# Row-Level Access Control Setup Guide

This guide explains how to configure and test row-level access control using user attributes in your Facebook Ads Looker project.

## Table of Contents
1. [Overview](#overview)
2. [User Attributes Setup](#user-attributes-setup)
3. [Access Control Patterns](#access-control-patterns)
4. [Testing Instructions](#testing-instructions)
5. [Real-World Examples](#real-world-examples)

---

## Overview

Row-level access control ensures users only see data they're authorized to view. This implementation showcases **4 different patterns** across your Facebook Ads explores.

### Required User Attributes

Create these user attributes in Looker Admin:

| User Attribute | Type | Description | Example Values |
|---------------|------|-------------|----------------|
| `campaign_access` | String | Campaign name pattern or "all" | `"all"`, `"EMEA_%"`, `"US_Brand_%"` |
| `account_access` | String | Comma-separated account IDs or "all" | `"all"`, `"123456,789012"` |
| `user_role` | String | User's role in organization | `"admin"`, `"regional_manager"`, `"analyst"` |
| `can_view_pii` | String | Permission to view sensitive data | `"yes"`, `"no"` |

---

## User Attributes Setup

### Step 1: Create User Attributes (Looker Admin)

1. Go to **Admin** → **User Attributes**
2. Click **New User Attribute**
3. Create each attribute:

#### campaign_access
- **Name**: `campaign_access`
- **Data Type**: String
- **User Access**: View
- **Hide Values**: No
- **Default Value**: Leave blank (users with no value will see no data)

#### account_access
- **Name**: `account_access`
- **Data Type**: String
- **User Access**: View
- **Hide Values**: No
- **Default Value**: Leave blank

#### user_role
- **Name**: `user_role`
- **Data Type**: String
- **User Access**: View
- **Hide Values**: No
- **Default Value**: `analyst`

#### can_view_pii
- **Name**: `can_view_pii`
- **Data Type**: String
- **User Access**: None (admins only)
- **Hide Values**: Yes
- **Default Value**: `no`

### Step 2: Assign Values to Users

1. Go to **Admin** → **Users**
2. Click on a user
3. Scroll to **User Attributes**
4. Set values for each attribute

---

## Access Control Patterns

### Pattern 1: Account-Level Access (Account Report)

**Location**: `facebook_ads__account_report`

**How it works**:
- Users with `account_access = "all"` see all accounts
- Users with specific account IDs only see those accounts
- Supports multiple accounts (comma-separated)

**SQL Logic**:
```sql
sql_always_where:
  {% if _user_attributes['account_access'] == 'all' %}
    1=1
  {% else %}
    account_id IN (123456, 789012)  -- Parsed from user attribute
  {% endif %}
;;
```

**Use Case**: Ad agency with multiple client accounts

### Pattern 2: Campaign Name Pattern (Campaign Report)

**Location**: `facebook_ads__campaign_report`

**How it works**:
- Uses `access_filter` to match campaign names
- Supports SQL wildcards (%, _)
- Combined with account access control

**LookML**:
```lookml
access_filter: {
  field: campaign_name
  user_attribute: campaign_access
}
```

**Use Case**: Regional managers see only their region's campaigns

### Pattern 3: Combined Multi-Attribute (Ad Set Report)

**Location**: `facebook_ads__ad_set_report`

**How it works**:
- Combines campaign pattern AND account access
- Requires date filter for non-admin users
- Uses `conditionally_filter` for performance

**Use Case**: Analysts with restricted access and mandatory date filters

### Pattern 4: Complex with Date Restrictions (Ad Report)

**Location**: `facebook_ads__ad_report`

**How it works**:
- Campaign pattern matching
- Account-level filtering
- Date restriction (90 days) for non-admin users
- Required filters unless admin

**Use Case**: General users with time-limited data access

---

## Testing Instructions

### Test Scenario 1: Admin User (Full Access)

**Setup**:
```
campaign_access = "all"
account_access = "all"
user_role = "admin"
can_view_pii = "yes"
```

**Expected Result**:
- ✅ Sees all campaigns across all accounts
- ✅ No required filters
- ✅ Can see all date ranges
- ✅ Can access sensitive fields

### Test Scenario 2: Regional Manager (EMEA)

**Setup**:
```
campaign_access = "EMEA_%"
account_access = "123456,789012"
user_role = "regional_manager"
can_view_pii = "no"
```

**Expected Result**:
- ✅ Sees only campaigns starting with "EMEA_"
- ✅ Sees only accounts 123456 and 789012
- ⚠️ Required to select date filter (defaults to 30 days)
- ❌ Cannot see PII fields

**How to Test**:
1. Open **Campaign Report** explore
2. Add `campaign_name` to query
3. Verify only "EMEA_%" campaigns appear
4. Check account IDs in results match 123456 or 789012

### Test Scenario 3: US Analyst (Limited)

**Setup**:
```
campaign_access = "US_%"
account_access = "123456"
user_role = "analyst"
can_view_pii = "no"
```

**Expected Result**:
- ✅ Sees only campaigns starting with "US_"
- ✅ Sees only account 123456
- ⚠️ Ad Report: Can only see last 90 days
- ⚠️ Required to select date filter

**How to Test**:
1. Open **Ad Report** explore
2. Try to select a date > 90 days ago
3. Verify data is filtered to last 90 days
4. Check only "US_%" campaigns appear

### Test Scenario 4: Client User (Single Campaign)

**Setup**:
```
campaign_access = "US_Brand_Summer2025"
account_access = "123456"
user_role = "client"
can_view_pii = "no"
```

**Expected Result**:
- ✅ Sees only one specific campaign
- ✅ Sees only one account
- ⚠️ All filters required

---

## Real-World Examples

### Example 1: Ad Agency with Multiple Clients

**Scenario**: Agency manages 10 client accounts

**User Setup**:
```
Client A Manager:
  account_access = "111111"
  campaign_access = "all"

Client B Manager:
  account_access = "222222"
  campaign_access = "all"

Agency Admin:
  account_access = "all"
  campaign_access = "all"
```

### Example 2: Global Brand with Regional Teams

**Scenario**: Global company with regional marketing teams

**User Setup**:
```
EMEA Marketing Manager:
  account_access = "all"
  campaign_access = "EMEA_%"

US Marketing Manager:
  account_access = "all"
  campaign_access = "US_%"

APAC Marketing Manager:
  account_access = "all"
  campaign_access = "APAC_%"

Global CMO:
  account_access = "all"
  campaign_access = "all"
```

### Example 3: Brand vs Performance Teams

**Scenario**: Different teams manage different campaign types

**User Setup**:
```
Brand Team:
  account_access = "all"
  campaign_access = "%_Brand_%"

Performance Team:
  account_access = "all"
  campaign_access = "%_Performance_%"

Analytics Team:
  account_access = "all"
  campaign_access = "all"
  can_view_pii = "yes"
```

---

## Advanced Features

### Access Grants

Access grants are reusable permission checks:

```lookml
access_grant: can_see_all_campaigns {
  user_attribute: campaign_access
  allowed_values: ["all", "admin"]
}
```

**Usage in Explores**:
```lookml
conditionally_filter: {
  filters: [campaign_name: ""]
  unless: [can_see_all_campaigns]
}
```

### Dynamic Field Hiding

Hide fields based on permissions:

```lookml
fields: [ALL_FIELDS*, -campaign_report_pii*]
```

Fields matching `-campaign_report_pii*` pattern are hidden for users without access.

### User Attribute in Views

Reference user attributes in dimensions/measures:

```lookml
dimension: is_user_admin {
  type: yesno
  sql: '{{ _user_attributes["campaign_access"] }}' = 'all' ;;
}

measure: conditional_spend {
  type: sum
  sql: {% if _user_attributes["can_view_pii"] == 'yes' %}
         ${spend}
       {% else %}
         NULL
       {% endif %} ;;
}
```

---

## Verification Checklist

After setup, verify:

- [ ] User attributes created in Looker Admin
- [ ] Default values set appropriately
- [ ] Test users created with different attribute values
- [ ] Each explore filters data correctly
- [ ] Admin users see all data
- [ ] Restricted users see only their data
- [ ] SQL queries include correct WHERE clauses
- [ ] Performance is acceptable (add indexes if needed)
- [ ] Dashboard filters work with row-level security

---

## Troubleshooting

### Issue: User sees no data

**Possible Causes**:
- User attribute not set (defaults to blank = no data)
- User attribute value doesn't match any data
- Typo in user attribute value

**Solution**:
1. Check user's attribute values in Admin
2. Verify data exists matching the pattern
3. Check SQL in Looker IDE

### Issue: User sees all data (should be restricted)

**Possible Causes**:
- User has `"all"` value
- SQL logic error
- Access grant misconfigured

**Solution**:
1. Verify user attribute value
2. Check `sql_always_where` syntax
3. Test in Looker IDE SQL runner

### Issue: Performance degradation

**Possible Causes**:
- Row-level filters not using indexes
- Complex user attribute parsing

**Solution**:
1. Add database indexes on `campaign_name`, `account_id`
2. Simplify `sql_always_where` logic
3. Use `access_filter` instead of `sql_always_where` when possible

---

## Best Practices

1. **Always set default values**: Blank user attributes should deny access, not grant it
2. **Use access grants**: Reusable permission logic across explores
3. **Test thoroughly**: Test with each user role before production
4. **Document patterns**: Keep track of which users have which access
5. **Monitor queries**: Check that WHERE clauses are being applied
6. **Use wildcards wisely**: `%` matches any characters, `_` matches single character
7. **Combine methods**: Use both `access_filter` and `sql_always_where` for defense-in-depth
8. **Audit regularly**: Review user access quarterly

---

## Next Steps

1. Create user attributes in Looker Admin
2. Assign test values to your user account
3. Open each explore and verify filtering
4. Create test users with different access levels
5. Share dashboards and verify row-level security applies
6. Document your organization's access patterns
7. Train users on their data access scope

For questions, see [Looker Documentation on User Attributes](https://cloud.google.com/looker/docs/user-attributes)
