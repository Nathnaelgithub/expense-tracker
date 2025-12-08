import '../../domain/entities/summary_result.dart';

class SummaryModel extends SummaryResult {
  const SummaryModel({
    required super.totalToday,
    required super.totalThisWeek,
    required super.totalThisMonth,
    required super.totalAllTime,
  });

  Map<String, dynamic> toMap() => {
    'totalToday': totalToday,
    'totalThisWeek': totalThisWeek,
    'totalThisMonth': totalThisMonth,
    'totalAllTime': totalAllTime,
  };

  factory SummaryModel.fromMap(Map<String, dynamic> map) {
    return SummaryModel(
      totalToday: (map['totalToday'] ?? 0).toDouble(),
      totalThisWeek: (map['totalThisWeek'] ?? 0).toDouble(),
      totalThisMonth: (map['totalThisMonth'] ?? 0).toDouble(),
      totalAllTime: (map['totalAllTime'] ?? 0).toDouble(),
    );
  }
}
