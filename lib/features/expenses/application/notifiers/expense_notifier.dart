import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_tracker/core/providers/providers.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expenses/application/state/expense_state.dart';

import 'package:expense_tracker/features/expenses/domain/usecases/add_expense_usecase.dart';
import 'package:expense_tracker/features/expenses/domain/usecases/get_expenses_usecase.dart';
import 'package:expense_tracker/features/expenses/domain/usecases/get_summary_usecase.dart';

class ExpenseNotifier extends Notifier<ExpenseState> {
  late final AddExpenseUseCase _addExpense;
  late final GetExpensesUseCase _getExpenses;
  late final GetSummaryUseCase _getSummary;

  @override
  ExpenseState build() {
    _addExpense = ref.read(addExpenseUseCaseProvider);
    _getExpenses = ref.read(getExpensesUseCaseProvider);
    _getSummary = ref.read(getSummaryUseCaseProvider);
    loadExpenses();
    return ExpenseState.initial();
  }

  /// Load all expenses
  Future<void> loadExpenses() async {
    state = state.copyWith(isLoading: true);

    final result = await _getExpenses(NoParams());

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (list) => state = state.copyWith(isLoading: false, expenses: list),
    );
  }

  /// Add a new expense
  Future<void> addExpense(AddExpenseParams params) async {
    state = state.copyWith(isLoading: true);

    final result = await _addExpense(AddExpenseParams(expense: params.expense));

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (_) async {
        await loadExpenses(); // refresh list
        await loadSummary();
        state = state.copyWith(isLoading: false);
      },
    );
  }

  /// Load expense summary
  Future<void> loadSummary() async {
    final result = await _getSummary(NoParams());

    result.fold(
      (failure) => state = state.copyWith(errorMessage: failure.message),
      (summary) => state = state.copyWith(summary: summary),
    );
  }
}
