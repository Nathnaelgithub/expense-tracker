import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;

  const ExpenseEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  @override
  List<Object?> get props => [id, title, amount, category, date];
}
