import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:expense_tracker/features/expenses/data/models/summary_model.dart';
import 'package:expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:expense_tracker/features/expenses/domain/repositories/expense_repository.dart';
import 'package:expense_tracker/features/expenses/data/datasources/expense_remote_datasource.dart';
import 'package:expense_tracker/features/expenses/data/models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource remote;

  ExpenseRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<ExpenseEntity>>> getExpenses() async {
    try {
      final result = await remote.getExpenses();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addExpense(ExpenseEntity expense) async {
    try {
      final model = ExpenseModel(
        id: expense.id,
        title: expense.title,
        amount: expense.amount,
        date: expense.date,
        category: expense.category,
      );

      await remote.addExpense(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SummaryModel>> getSummary() async {
    try {
      final result = await remote.getSummary();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
