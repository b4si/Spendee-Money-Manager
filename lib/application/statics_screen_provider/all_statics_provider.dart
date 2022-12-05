import 'package:flutter/material.dart';

import '../../db/transaction_db/transaction_db.dart';

class AllStaticsProvider with ChangeNotifier {
  double? totalIncomeAmount = TransactionDB.instance.allMonthlyIncomeAmount();
  double? totalExpenseAmount = TransactionDB.instance.allMonthlyExpenseAmount();

  int value1 = 1;

  void allMonthlyAmount() {
    totalIncomeAmount = TransactionDB.instance.allMonthlyIncomeAmount();
    totalExpenseAmount = TransactionDB.instance.allMonthlyExpenseAmount();
    notifyListeners();
  }

  void allTodayAmount() {
    totalIncomeAmount = TransactionDB.instance.alltodayIncomeAmount();
    totalExpenseAmount = TransactionDB.instance.alltodayExpenseAmount();
    notifyListeners();
  }

  void totalAmount() {
    totalIncomeAmount = TransactionDB.instance.allIncomeAmount();
    totalExpenseAmount = TransactionDB.instance.allExpenseAmount();
    notifyListeners();
  }

  void dropDownOnchange(int value) {
    value1 = value;
    notifyListeners();
  }
}
