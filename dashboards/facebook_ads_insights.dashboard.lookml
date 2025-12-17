- dashboard: facebook_ads_insights
  title: Facebook Ads Insights
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Comprehensive overview of Facebook Ads performance metrics"

  embed_style:
    background_color: "#f8f9fa"
    show_title: true
    title_color: "#1877f2"
    show_filters_bar: true
    tile_text_color: "#1c1e21"

  elements:
  # Filters
  - name: date_filter
    title: Date Range
    type: text
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    listens_to_filters: []
    field: facebook_ads__ad_report.date_day_date

  # Top Row - Main Metrics
  - name: amount_spent
    title: Amount Spent
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: single_value
    fields: [facebook_ads__ad_report.total_spend]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "\฿ #,##0.00"
    custom_color: "#1877f2"
    listen:
      Date: facebook_ads__ad_report.date_day_date
      Campaign Benchmark: facebook_ads__ad_report.selected_campaigns
      Performance Category: facebook_ads__ad_report.performance_category
    row: 0
    col: 0
    width: 4
    height: 3

  - name: impressions
    title: Impressions
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: single_value
    fields: [facebook_ads__ad_report.total_impressions]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "#,##0.0,,\"M\""
    custom_color: "#1877f2"
    listen:
      Date: facebook_ads__ad_report.date_day_date
      Campaign Benchmark: facebook_ads__ad_report.selected_campaigns
      Performance Category: facebook_ads__ad_report.performance_category
    row: 0
    col: 4
    width: 4
    height: 3

  - name: cpm
    title: CPM
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: single_value
    fields: [facebook_ads__ad_report.cpm]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "#,##0.0"
    listen:
      Date: facebook_ads__ad_report.date_day_date
    row: 0
    col: 8
    width: 4
    height: 3

  - name: ctr
    title: CTR (all)
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: single_value
    fields: [facebook_ads__ad_report.ctr]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "0.0%"
    listen:
      Date: facebook_ads__ad_report.date_day_date
    row: 0
    col: 12
    width: 4
    height: 3

  - name: cpc
    title: Cost per Click
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: single_value
    fields: [facebook_ads__ad_report.cpc]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "\฿ #,##0.00"
    listen:
      Date: facebook_ads__ad_report.date_day_date
    row: 0
    col: 16
    width: 4
    height: 3

  - name: total_clicks
    title: Clicks
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: single_value
    fields: [facebook_ads__ad_report.total_clicks]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "#,##0.0,,\"M\""
    listen:
      Date: facebook_ads__ad_report.date_day_date
    row: 0
    col: 20
    width: 4
    height: 3

  # Second Row - Conversion Metrics
  - name: total_conversions
    title: Website Purchases
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: single_value
    fields: [facebook_ads__ad_report.total_conversions]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "#,##0.0"
    listen:
      Date: facebook_ads__ad_report.date_day_date
    row: 3
    col: 0
    width: 4
    height: 3

  - name: cost_per_conversion
    title: Cost per Conversion
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: single_value
    fields: [facebook_ads__ad_report.cost_per_conversion]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "\฿ #,##0.00"
    listen:
      Date: facebook_ads__ad_report.date_day_date
    row: 3
    col: 4
    width: 4
    height: 3

  - name: revenue
    title: Revenue
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: single_value
    fields: [facebook_ads__ad_report.total_conversions_value]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "\฿ #,##0.00,\"K\""
    listen:
      Date: facebook_ads__ad_report.date_day_date
    row: 3
    col: 8
    width: 4
    height: 3

  - name: roas
    title: ROAS
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: single_value
    fields: [facebook_ads__ad_report.roas]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "0.0"
    listen:
      Date: facebook_ads__ad_report.date_day_date
    row: 3
    col: 12
    width: 4
    height: 3

  - name: conversion_rate
    title: Conversion Rate
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: single_value
    fields: [facebook_ads__ad_report.conversion_rate]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "0.0%"
    listen:
      Date: facebook_ads__ad_report.date_day_date
    row: 3
    col: 16
    width: 4
    height: 3

  # Trend Line Chart
  - name: spend_trend
    title: Spend Over Time
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: looker_line
    fields: [facebook_ads__ad_report.date_day_date, facebook_ads__ad_report.total_spend,
      facebook_ads__ad_report.total_impressions]
    fill_fields: [facebook_ads__ad_report.date_day_date]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    sorts: [facebook_ads__ad_report.date_day_date desc]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: facebook_ads__ad_report.total_spend,
            id: facebook_ads__ad_report.total_spend, name: Total Spend}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: facebook_ads__ad_report.total_impressions,
            id: facebook_ads__ad_report.total_impressions, name: Total Impressions}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: Date
    series_types: {}
    series_colors:
      facebook_ads__ad_report.total_spend: "#4285F4"
      facebook_ads__ad_report.total_impressions: "#34A853"
    listen:
      Date: facebook_ads__ad_report.date_day_date
    row: 6
    col: 0
    width: 24
    height: 8

  # Performance by Campaign
  - name: performance_by_campaign
    title: Performance by Campaign
    model: facebook_ads_report
    explore: facebook_ads__campaign_report
    type: looker_grid
    fields: [facebook_ads__campaign_report.campaign_name, facebook_ads__campaign_report.performance_category,
      facebook_ads__campaign_report.total_spend, facebook_ads__campaign_report.total_impressions,
      facebook_ads__campaign_report.cpm, facebook_ads__campaign_report.total_clicks,
      facebook_ads__campaign_report.cpc, facebook_ads__campaign_report.ctr, facebook_ads__campaign_report.total_conversions,
      facebook_ads__campaign_report.cost_per_conversion, facebook_ads__campaign_report.total_conversions_value,
      facebook_ads__campaign_report.roas]
    filters:
      facebook_ads__campaign_report.date_day_date: 30 days
    sorts: [facebook_ads__campaign_report.total_spend desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_cell_visualizations:
      facebook_ads__campaign_report.total_spend:
        is_active: true
        palette:
          palette_id: 629b455f-662e-4854-a424-3f4e578a7a8e
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      facebook_ads__campaign_report.total_impressions:
        is_active: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: [facebook_ads__campaign_report.roas]}]
    listen:
      Date: facebook_ads__campaign_report.date_day_date
    row: 14
    col: 0
    width: 24
    height: 8

  # Performance by Ad Set
  - name: performance_by_ad_set
    title: Performance by Ad Set
    model: facebook_ads_report
    explore: facebook_ads__ad_set_report
    type: looker_grid
    fields: [facebook_ads__ad_set_report.ad_set_name, facebook_ads__ad_set_report.campaign_name,
      facebook_ads__ad_set_report.performance_category, facebook_ads__ad_set_report.total_spend,
      facebook_ads__ad_set_report.total_impressions, facebook_ads__ad_set_report.cpm,
      facebook_ads__ad_set_report.total_clicks, facebook_ads__ad_set_report.cpc,
      facebook_ads__ad_set_report.ctr, facebook_ads__ad_set_report.total_conversions,
      facebook_ads__ad_set_report.cost_per_conversion, facebook_ads__ad_set_report.total_conversions_value,
      facebook_ads__ad_set_report.roas]
    filters:
      facebook_ads__ad_set_report.date_day_date: 30 days
    sorts: [facebook_ads__ad_set_report.total_spend desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_cell_visualizations:
      facebook_ads__ad_set_report.total_spend:
        is_active: true
      facebook_ads__ad_set_report.total_impressions:
        is_active: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: [facebook_ads__ad_set_report.roas]}]
    listen:
      Date: facebook_ads__ad_set_report.date_day_date
    row: 22
    col: 0
    width: 24
    height: 8

  # Performance by Ad
  - name: performance_by_ad
    title: Performance by Ad
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: looker_grid
    fields: [facebook_ads__ad_report.ad_name, facebook_ads__ad_report.ad_set_name,
      facebook_ads__ad_report.campaign_name, facebook_ads__ad_report.performance_category,
      facebook_ads__ad_report.total_spend, facebook_ads__ad_report.total_impressions,
      facebook_ads__ad_report.cpm, facebook_ads__ad_report.total_clicks, facebook_ads__ad_report.cpc,
      facebook_ads__ad_report.ctr, facebook_ads__ad_report.total_conversions,
      facebook_ads__ad_report.cost_per_conversion, facebook_ads__ad_report.total_conversions_value,
      facebook_ads__ad_report.roas]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    sorts: [facebook_ads__ad_report.total_spend desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_cell_visualizations:
      facebook_ads__ad_report.total_spend:
        is_active: true
      facebook_ads__ad_report.total_impressions:
        is_active: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: [facebook_ads__ad_report.roas]}]
    listen:
      Date: facebook_ads__ad_report.date_day_date
    row: 30
    col: 0
    width: 24
    height: 8

  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: 30 days
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    listens_to_filters: []
    field: facebook_ads__ad_report.date_day_date

  - name: Campaign Benchmark
    title: Campaign Benchmark
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    listens_to_filters: []
    field: facebook_ads__ad_report.selected_campaigns

  - name: Performance Category
    title: Performance Category
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    listens_to_filters: []
    field: facebook_ads__ad_report.performance_category
