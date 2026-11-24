# Day 10 – Power BI Fundamentals

## Project
Sample Superstore Sales Dashboard

## Objective
Create an interactive Power BI report to analyze business performance using the Sample Superstore dataset.

## Tool
- Microsoft Power BI Desktop
- Power Query
- DAX

## Data Preparation
- Imported Sample Superstore data
- Checked column names
- Verified data types
- Reviewed missing values
- Applied data transformations

## KPI Cards
- Total Sales
- Total Profit
- Total Orders
- Total Customers

## Visualizations
- Sales by Region
- Profit by Category
- Sales by Customer Segment
- Sales by Sub-Category
- Monthly Sales Trend

## Interactive Filters
- Region
- Category
- Segment

## DAX Measures

### Total Sales
```dax
Total Sales = SUM('Superstore'[Sales])
```

### Total Profit
```dax
Total Profit = SUM('Superstore'[Profit])
```

### Profit Margin
```dax
Profit Margin =
DIVIDE([Total Profit], [Total Sales], 0)
```

## Business Findings

1. Best-performing region
2. Highest-profit category
3. Highest-sales segment
4. Monthly sales trend
5. Important observation

## Recommendations

### Recommendation 1
Finding:

Evidence:

Recommended action:

### Recommendation 2
Finding:

Evidence:

Recommended action:

### Recommendation 3
Finding:

Evidence:

Recommended action:

## Files Created
- Superstore_Dashboard.pbix
- day10_powerbi_fundamentals.md

## Conclusion
Created an interactive Power BI dashboard to explore Superstore sales, profitability, customers, and regional performance.

## Completion Status
- [ ] Data imported
- [ ] Data types checked
- [ ] Four KPI cards created
- [ ] Sales by Region chart created
- [ ] Profit by Category chart created
- [ ] Sales by Segment chart created
- [ ] Monthly Sales Trend created
- [ ] Three slicers created
- [ ] DAX measures created
- [ ] Dashboard formatted
- [ ] PBIX file saved
- [ ] Documentation completed
- [ ] GitHub commit and push completed
