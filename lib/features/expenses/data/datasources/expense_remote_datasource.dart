import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/expenses/data/models/expense_model.dart';
import 'package:expense_tracker/features/expenses/data/models/summary_model.dart';

abstract class ExpenseRemoteDataSource {
  Future<List<ExpenseModel>> getExpenses();
  Future<void> addExpense(ExpenseModel model);
  Future<SummaryModel> getSummary();
}

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final FirebaseFirestore firestore;

  ExpenseRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    final snapshot = await firestore.collection('expenses').get();

    return snapshot.docs.map((doc) {
      final data = Map<String, dynamic>.from(doc.data());
      return ExpenseModel.fromMap(doc.id, data);
    }).toList();
  }

  @override
  Future<void> addExpense(ExpenseModel model) async {
    await firestore.collection('expenses').add(model.toMap());
  }

  @override
  Future<SummaryModel> getSummary() async {
    final doc = await firestore.collection('summary').doc('main').get();
    return SummaryModel.fromMap(doc.data() ?? {});
  }
}
