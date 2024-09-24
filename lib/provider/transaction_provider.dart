import 'package:account/databases/transection_db.dart';
import 'package:account/models/transaction.dart';
import 'package:flutter/foundation.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [
    Transactions(title: 'หนังสือ', amount: 300, date: DateTime.now()),
    Transactions(title: 'เสื้อ', amount: 500, date: DateTime.now()),
    Transactions(title: 'รองเท้า', amount: 1000, date: DateTime.now()),
  ];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void addTransaction(Transactions transaction) async {
    var db = TransactionDB(dbName: 'transections.db').openDatabase();
    print(db);
    transactions.insert(0,transaction);
    notifyListeners();
  }

  void deleteTransaction(int index) {
    transactions.removeAt(index);
    notifyListeners(); 
  }
}