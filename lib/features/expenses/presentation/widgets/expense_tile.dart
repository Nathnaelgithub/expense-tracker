import 'package:flutter/material.dart';
import 'package:expense_tracker/core/utils/formatter.dart';
import 'package:expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:go_router/go_router.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseEntity expense;
  const ExpenseTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(expense.title),
        subtitle: Text("${expense.category} • ${Formatter.date(expense.date)}"),
        trailing: Text(Formatter.currency(expense.amount)),
        onTap: () => context.push('/expenses/view', extra: expense),
      ),
    );
  }
}
