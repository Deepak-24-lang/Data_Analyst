print("_________SALES CALCULATOR_________")

product_name = input("Enter the product name: ")
sales_amount = float(input("Enter the sales amount: "))
expenses = float(input("Enter the expenses: "))

profit = sales_amount - expenses
expense_percentage = (expenses / sales_amount) * 100

print("\n==========SALES REPORT=========")

print(f"Product Name: {product_name}")
print(f"Sales Amount: ${sales_amount:.2f}") 
print(f"Expenses: ${expenses:.2f}")
print(f"Profit: ${profit:.2f}")
print(f"Expense Percentage: {expense_percentage:.2f}%")
        

