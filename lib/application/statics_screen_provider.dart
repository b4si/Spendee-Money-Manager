import 'package:flutter/material.dart';
import '../db/transaction_db/transaction_db.dart';
import '../transaction_model/transaction_model.dart';

class StaticsScreenProvider with ChangeNotifier {
  List<TransactionModel> temp =
      TransactionDB.instance.allMonthlyExpenseTransactions.value;

  int value1 = 0;

  void MonthlyTranscation() {
    temp = TransactionDB.instance.allMonthlyExpenseTransactions.value;
    notifyListeners();
  }

  void dropDownOnchange(int value) {
    value1 = value;
    notifyListeners();
  }

  void AnuallyTranscation() {
    temp = TransactionDB.instance.expenseTransactionNotifier.value;
    notifyListeners();
  }
}
