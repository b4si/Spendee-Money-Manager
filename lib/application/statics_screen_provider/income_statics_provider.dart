import 'package:flutter/material.dart';
import '../../db/transaction_db/transaction_db.dart';
import '../../transaction_model/transaction_model.dart';

class IncomeStaticsProvider with ChangeNotifier {
  List<TransactionModel> temp =
      TransactionDB.instance.allMonthlyincomeTransactions.value;

  int value1 = 0;

  void MonthlyTranscation() {
    temp = TransactionDB.instance.allMonthlyincomeTransactions.value;
    notifyListeners();
  }

  void annuallyTranscation() {
    temp = TransactionDB.instance.incomeTransactionNotifier.value;
    notifyListeners();
  }

  void dropDownOnchange(int value) {
    value1 = value;
    notifyListeners();
  }
}
