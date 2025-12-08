import 'package:flutter/material.dart';
import 'package:expense_tracker/core/utils/formatter.dart';
import 'package:expense_tracker/features/expenses/domain/entities/expense_entity.dart';

class ViewExpenseScreen extends StatelessWidget {
  final ExpenseEntity expense;
  const ViewExpenseScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title: ${expense.title}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "Amount: ${Formatter.currency(expense.amount)}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "Category: ${expense.category}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "Date: ${Formatter.date(expense.date)}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
