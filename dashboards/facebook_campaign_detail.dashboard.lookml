- dashboard: facebook_campaign_detail
  title: Campaign Performance Detail
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Deep dive into individual campaign performance"

  embed_style:
    background_color: "#f8f9fa"
    show_title: true
    title_color: "#1877f2"
    show_filters_bar: true
    tile_text_color: "#1c1e21"

  elements:
  # KPI Tiles with Comparisons
  - name: campaign_total_spend
    title: Total Spend
    model: facebook_ads_report
    explore: facebook_ads__campaign_report
    type: single_value
    fields: [facebook_ads__campaign_report.total_spend, facebook_ads__campaign_report.cpc]
    filters:
      facebook_ads__campaign_report.date_day_date: 30 days
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: "Avg CPC"
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1877f2"
    single_value_title: "Total Spend"
    value_format: "$#,##0"
    listen:
      Campaign Name: facebook_ads__campaign_report.campaign_name
      Date Range: facebook_ads__campaign_report.date_day_date
    row: 0
    col: 0
    width: 4
    height: 4

  - name: campaign_impressions
    title: Impressions
    model: facebook_ads_report
    explore: facebook_ads__campaign_report
    type: single_value
    fields: [facebook_ads__campaign_report.total_impressions, facebook_ads__campaign_report.cpm]
    filters:
      facebook_ads__campaign_report.date_day_date: 30 days
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: "CPM"
    enable_conditional_formatting: false
    custom_color: "#1877f2"
    value_format: "#,##0.0,,\"M\""
    listen:
      Campaign Name: facebook_ads__campaign_report.campaign_name
      Date Range: facebook_ads__campaign_report.date_day_date
    row: 0
    col: 4
    width: 4
    height: 4

  - name: campaign_clicks
    title: Clicks
    model: facebook_ads_report
    explore: facebook_ads__campaign_report
    type: single_value
    fields: [facebook_ads__campaign_report.total_clicks, facebook_ads__campaign_report.ctr]
    filters:
      facebook_ads__campaign_report.date_day_date: 30 days
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: "CTR"
    enable_conditional_formatting: false
    custom_color: "#1877f2"
    value_format: "#,##0"
    listen:
      Campaign Name: facebook_ads__campaign_report.campaign_name
      Date Range: facebook_ads__campaign_report.date_day_date
    row: 0
    col: 8
    width: 4
    height: 4

  - name: campaign_conversions
    title: Conversions
    model: facebook_ads_report
    explore: facebook_ads__campaign_report
    type: single_value
    fields: [facebook_ads__campaign_report.total_conversions, facebook_ads__campaign_report.conversion_rate]
    filters:
      facebook_ads__campaign_report.date_day_date: 30 days
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: "Conversion Rate"
    enable_conditional_formatting: false
    custom_color: "#1877f2"
    value_format: "#,##0.0"
    listen:
      Campaign Name: facebook_ads__campaign_report.campaign_name
      Date Range: facebook_ads__campaign_report.date_day_date
    row: 0
    col: 12
    width: 4
    height: 4

  - name: campaign_revenue
    title: Revenue
    model: facebook_ads_report
    explore: facebook_ads__campaign_report
    type: single_value
    fields: [facebook_ads__campaign_report.total_conversions_value, facebook_ads__campaign_report.cost_per_conversion]
    filters:
      facebook_ads__campaign_report.date_day_date: 30 days
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: "Cost per Conversion"
    enable_conditional_formatting: false
    custom_color: "#1877f2"
    value_format: "$#,##0"
    listen:
      Campaign Name: facebook_ads__campaign_report.campaign_name
      Date Range: facebook_ads__campaign_report.date_day_date
    row: 0
    col: 16
    width: 4
    height: 4

  - name: campaign_roas
    title: ROAS
    model: facebook_ads_report
    explore: facebook_ads__campaign_report
    type: single_value
    fields: [facebook_ads__campaign_report.roas]
    filters:
      facebook_ads__campaign_report.date_day_date: 30 days
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: greater than, value: 1, background_color: "#4FBC89",
        font_color: "#FFFFFF", color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: [facebook_ads__campaign_report.roas]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1877f2"
    value_format: "0.00"
    listen:
      Campaign Name: facebook_ads__campaign_report.campaign_name
      Date Range: facebook_ads__campaign_report.date_day_date
    row: 0
    col: 20
    width: 4
    height: 4

  # Daily Performance Trend
  - name: daily_performance_trend
    title: Daily Performance Trend
    model: facebook_ads_report
    explore: facebook_ads__campaign_report
    type: looker_line
    fields: [facebook_ads__campaign_report.date_day_date, facebook_ads__campaign_report.total_spend,
      facebook_ads__campaign_report.total_conversions_value, facebook_ads__campaign_report.roas]
    fill_fields: [facebook_ads__campaign_report.date_day_date]
    filters:
      facebook_ads__campaign_report.date_day_date: 30 days
    sorts: [facebook_ads__campaign_report.date_day_date]
    limit: 500
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
    y_axis_combined: false
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: facebook_ads__campaign_report.total_spend,
            id: facebook_ads__campaign_report.total_spend, name: Total Spend}, {
            axisId: facebook_ads__campaign_report.total_conversions_value, id: facebook_ads__campaign_report.total_conversions_value,
            name: Revenue}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: facebook_ads__campaign_report.roas,
            id: facebook_ads__campaign_report.roas, name: ROAS}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_label: Date
    series_types: {}
    series_colors:
      facebook_ads__campaign_report.total_spend: "#EA4335"
      facebook_ads__campaign_report.total_conversions_value: "#34A853"
      facebook_ads__campaign_report.roas: "#FBBC04"
    listen:
      Campaign Name: facebook_ads__campaign_report.campaign_name
      Date Range: facebook_ads__campaign_report.date_day_date
    row: 4
    col: 0
    width: 24
    height: 8

  # Ad Set Performance Breakdown
  - name: adset_performance_breakdown
    title: Ad Set Performance Breakdown
    model: facebook_ads_report
    explore: facebook_ads__ad_set_report
    type: looker_grid
    fields: [facebook_ads__ad_set_report.ad_set_name, facebook_ads__ad_set_report.total_spend,
      facebook_ads__ad_set_report.total_impressions, facebook_ads__ad_set_report.cpm,
      facebook_ads__ad_set_report.total_clicks, facebook_ads__ad_set_report.ctr,
      facebook_ads__ad_set_report.total_conversions, facebook_ads__ad_set_report.cost_per_conversion,
      facebook_ads__ad_set_report.total_conversions_value, facebook_ads__ad_set_report.roas,
      facebook_ads__ad_set_report.performance_category]
    filters:
      facebook_ads__ad_set_report.date_day_date: 30 days
    sorts: [facebook_ads__ad_set_report.total_spend desc]
    limit: 500
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
        palette:
          palette_id: 629b455f-662e-4854-a424-3f4e578a7a8e
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      facebook_ads__ad_set_report.total_impressions:
        is_active: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: [facebook_ads__ad_set_report.roas]}]
    listen:
      Campaign Name: facebook_ads__ad_set_report.campaign_name
      Date Range: facebook_ads__ad_set_report.date_day_date
    row: 12
    col: 0
    width: 24
    height: 8

  # Top 10 Ads by ROAS
  - name: top_10_ads_by_roas
    title: Top 10 Ads by ROAS
    model: facebook_ads_report
    explore: facebook_ads__ad_report
    type: looker_grid
    fields: [facebook_ads__ad_report.ad_name, facebook_ads__ad_report.ad_set_name,
      facebook_ads__ad_report.total_spend, facebook_ads__ad_report.total_impressions,
      facebook_ads__ad_report.total_clicks, facebook_ads__ad_report.ctr, facebook_ads__ad_report.total_conversions,
      facebook_ads__ad_report.total_conversions_value, facebook_ads__ad_report.roas,
      facebook_ads__ad_report.performance_category]
    filters:
      facebook_ads__ad_report.date_day_date: 30 days
    sorts: [facebook_ads__ad_report.roas desc]
    limit: 10
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
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: [facebook_ads__ad_report.roas]}]
    listen:
      Campaign Name: facebook_ads__ad_report.campaign_name
      Date Range: facebook_ads__ad_report.date_day_date
    row: 20
    col: 0
    width: 24
    height: 8

  filters:
  - name: Campaign Name
    title: Campaign Name
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: facebook_ads_report
    explore: facebook_ads__campaign_report
    listens_to_filters: []
    field: facebook_ads__campaign_report.campaign_name

  - name: Date Range
    title: Date Range
    type: field_filter
    default_value: 30 days
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: facebook_ads_report
    explore: facebook_ads__campaign_report
    listens_to_filters: []
    field: facebook_ads__campaign_report.date_day_date
