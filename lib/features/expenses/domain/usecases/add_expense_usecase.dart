import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:expense_tracker/features/expenses/domain/repositories/expense_repository.dart';

class AddExpenseParams {
  final ExpenseEntity expense;

  AddExpenseParams({required this.expense});
}

class AddExpenseUseCase implements UseCase<void, AddExpenseParams> {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AddExpenseParams params) {
    return repository.addExpense(params.expense);
  }
}
