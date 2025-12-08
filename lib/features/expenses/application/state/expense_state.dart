import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:expense_tracker/features/expenses/domain/entities/summary_result.dart';

class ExpenseState extends Equatable {
  final bool isLoading;
  final List<ExpenseEntity> expenses;
  final SummaryResult? summary;
  final String? errorMessage;

  const ExpenseState({
    this.isLoading = false,
    this.expenses = const [],
    this.summary,
    this.errorMessage,
  });

  factory ExpenseState.initial() => const ExpenseState();

  ExpenseState copyWith({
    bool? isLoading,
    List<ExpenseEntity>? expenses,
    SummaryResult? summary,
    String? errorMessage,
  }) {
    return ExpenseState(
      isLoading: isLoading ?? this.isLoading,
      expenses: expenses ?? this.expenses,
      summary: summary ?? this.summary,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, expenses, summary, errorMessage];
}
