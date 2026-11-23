# Day 8 – SQL Joins & Relational Analysis

## Objective
Learn how to combine multiple related tables using SQL JOINs and analyze business data across relationships.

## Tools
- DB Browser for SQLite
- SQLite
- Sample Superstore dataset

## Topics Covered
- Primary keys
- Foreign keys
- One-to-many relationships
- INNER JOIN
- LEFT JOIN
- Missing matches using IS NULL
- Aggregation after JOIN
- COUNT DISTINCT
- Join duplication and validation

## Tables Created
- Day8_Customers
- Day8_Orders
- Day8_Products
- Day8_OrderLines

## Business Questions
1. Who are our top customers by sales?
2. Which regions generate the highest revenue?
3. Which product categories generate the most profit?
4. Who are our repeat customers?
5. Are there products without sales?
6. Which segments perform best by region?

## Key SQL Concepts Learned

### INNER JOIN
Returns matching rows between tables.

### LEFT JOIN
Keeps all rows from the left table, including unmatched rows.

### COUNT(DISTINCT)
Prevents counting repeated IDs multiple times.

### JOIN Validation
Joined sales totals should match the original total when the joins are valid and dimensions have unique keys.

## Key Learnings
- [Write what you learned]
- [Explain how JOIN works]
- [Explain why IDs are used]
- [Describe one JOIN error you fixed]

## Challenges Completed
- [List completed challenges]

## Business Insights
- [Top customer insight]
- [Regional sales insight]
- [Category profit insight]
- [Repeat customer insight]

## Validation
- Original row count:
- OrderLines row count:
- Unique orders:
- Unique customers:
- Unique products:
- Original sales total:
- Joined sales total:

## Conclusion
SQL JOINs allow analysts to connect customer, order, and product information to answer more meaningful business questions.

