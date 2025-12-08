import 'package:expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker/core/utils/formatter.dart';
import 'package:expense_tracker/core/utils/validators.dart';
import 'package:expense_tracker/features/expenses/application/providers/expense_providers.dart';
import 'package:expense_tracker/features/expenses/domain/usecases/add_expense_usecase.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String _category = 'Other';
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _onAddExpense() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountCtrl.text.trim()) ?? 0;

    await ref
        .read(expenseNotifierProvider.notifier)
        .addExpense(
          AddExpenseParams(
            expense: ExpenseEntity(
              id: '', // ID will be assigned in the data layer
              title: _titleCtrl.text.trim(),
              amount: amount,
              category: _category,
              date: _date,
            ),
          ),
        );

    // After adding, pop back
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(expenseNotifierProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: "Title"),
                validator: Validators.nonEmpty,
              ),
              const SizedBox(height: 12),

              // Amount
              TextFormField(
                controller: _amountCtrl,
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Amount required";
                  if (double.tryParse(val) == null) return "Invalid number";
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Category Dropdown
              DropdownButtonFormField<String>(
                initialValue: _category,
                items: ['Food', 'Transport', 'Bills', 'Other']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _category = val!),
                decoration: const InputDecoration(labelText: "Category"),
              ),
              const SizedBox(height: 12),

              // Date Picker
              Row(
                children: [
                  Text("Date: ${Formatter.date(_date)}"),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: _pickDate,
                    child: const Text("Pick Date"),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: isLoading ? null : _onAddExpense,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                      : const Text("Add Expense"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
