using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

class ExpenseTracker
{
    public string Description { get; set; }
    public double Amount { get; set; }
    public string Category { get; set; }
}

class Expense
{
    private List<ExpenseTracker> expenses = new List<ExpenseTracker>();

    public void AddExpense()
    {
        Console.Write("Enter Description: ");
        string description = Console.ReadLine();
        double amount;
        while (true)
        {
            Console.Write("Enter Amount: ");
            if (double.TryParse(Console.ReadLine(), out amount) && amount > 0)
                break;
            Console.WriteLine("Invalid input. Please enter a valid amount.");
        }

        Console.Write("Enter Category: ");
        string category = Console.ReadLine();

        expenses.Add(new ExpenseTracker { Description = description, Amount = amount, Category = category });
        Console.WriteLine("\nExpense added successfully!\n");
    }

    public void ViewExpenses()
    {
        if (expenses.Count == 0)
        {
            Console.WriteLine("No expenses found.");
            return;
        }

        Console.WriteLine("\nAll Expenses:");
        foreach (var expense in expenses)
        {
            Console.WriteLine($"Category: {expense.Category} | Amount: {expense.Amount:C} | Description: {expense.Description}");
        }
    }

    public void ExportExpenses(string format)
    {
        string fileName;
        switch (format.ToLower())
        {
            case "text":
                fileName = "expenses.txt";
                File.WriteAllLines(fileName, expenses.Select(e => $"Category: {e.Category}, Amount: {e.Amount:C}, Description: {e.Description}"));
                break;
            case "csv":
                fileName = "expenses.csv";
                File.WriteAllLines(fileName, new List<string> { "Category,Amount,Description" }
                    .Concat(expenses.Select(e => $"{e.Category},{e.Amount},{e.Description}")));
                break;
            default:
                Console.WriteLine("Invalid format.");
                return;
        }
        Console.WriteLine($"\nExpenses exported successfully to {fileName}\n");
    }

    public void ShowTotalSpent()
    {
        double total = expenses.Sum(e => e.Amount);
        Console.WriteLine($"\nTotal Amount Spent: {total:C}\n");
    }

    public void FilterExpensesByCategory()
    {
        var distinctCategories = expenses.Select(e => e.Category).Distinct().ToList();

        if (distinctCategories.Count == 0)
        {
            Console.WriteLine("No expenses found.");
            return;
        }

        Console.WriteLine("Available Categories:");
        for (int i = 0; i < distinctCategories.Count; i++)
        {
            Console.WriteLine($"{i + 1}. {distinctCategories[i]}");
        }

        Console.Write("Select a category (enter number): ");
        if (int.TryParse(Console.ReadLine(), out int choice) && choice >= 1 && choice <= distinctCategories.Count)
        {
            string selectedCategory = distinctCategories[choice - 1];
            var filteredExpenses = expenses.Where(e => e.Category == selectedCategory).ToList();

            Console.WriteLine($"\nExpenses in category: {selectedCategory}");
            foreach (var exp in filteredExpenses)
            {
                Console.WriteLine($"Amount: {exp.Amount:C} | Description: {exp.Description}");
            }

            double categoryTotal = filteredExpenses.Sum(e => e.Amount);
            Console.WriteLine($"\nTotal Spent in {selectedCategory}: {categoryTotal:C}\n");
        }
        else
        {
            Console.WriteLine("Invalid selection.");
        }
    }
}

class Program
{
    static void Main()
    {
        Expense expenseManager = new Expense();
        while (true)
        {
            Console.WriteLine("\nExpense Tracker Menu:");
            Console.WriteLine("1. Add Expense");
            Console.WriteLine("2. View All Expenses");
            Console.WriteLine("3. Export Expenses");
            Console.WriteLine("4. Show Total Spent");
            Console.WriteLine("5. View Expenses by Category");
            Console.WriteLine("6. Exit");
            Console.Write("Choose an option: ");

            switch (Console.ReadLine())
            {
                case "1":
                    expenseManager.AddExpense();
                    break;
                case "2":
                    expenseManager.ViewExpenses();
                    break;
                case "3":
                    Console.Write("Enter export format (text/csv): ");
                    string format = Console.ReadLine();
                    expenseManager.ExportExpenses(format);
                    break;
                case "4":
                    expenseManager.ShowTotalSpent();
                    break;
                case "5":
                    expenseManager.FilterExpensesByCategory();
                    break;
                case "6":
                    Console.WriteLine("Exiting the application.");
                    return;
                default:
                    Console.WriteLine("Invalid choice, try again.");
                    break;
            }
        }
    }
}