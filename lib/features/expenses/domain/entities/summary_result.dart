import 'package:equatable/equatable.dart';

class SummaryResult extends Equatable {
  final double totalToday;
  final double totalThisWeek;
  final double totalThisMonth;
  final double totalAllTime;

  const SummaryResult({
    required this.totalToday,
    required this.totalThisWeek,
    required this.totalThisMonth,
    required this.totalAllTime,
  });

  @override
  List<Object?> get props => [
    totalToday,
    totalThisWeek,
    totalThisMonth,
    totalAllTime,
  ];
}
