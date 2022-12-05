import 'package:flutter/material.dart';

import '../db/transaction_db/transaction_db.dart';
import '../transaction_model/transaction_model.dart';

class TransactionScreenProvider with ChangeNotifier {
  List<TransactionModel> foundTransactions =
      TransactionDB.instance.transactionListNotifier.value;

  int value4 = 1;
  int value2 = 1;

  void searchResult(List<TransactionModel> results) {
    foundTransactions = results;
    notifyListeners();
  }

  void pickDateRangeValue(context) {
    Future pickDateRange(context) async {
      DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2021),
        lastDate: DateTime(2050),
      );

      if (newDateRange == null) {
        return;
      } else {
        startDate = await newDateRange.start;
        endDate = await newDateRange.end;
      }
    }

    pickDateRange(context).whenComplete(
        () => foundTransactions = TransactionDB.instance.dateRangeList.value);
    notifyListeners();
  }

  void checkAllTransaction(int value) {
    if (value == 1) {
      foundTransactions = TransactionDB.instance.transactionListNotifier.value;
    } else if (value == 2) {
      foundTransactions = TransactionDB.instance.todayTransactionNotifier.value;
    } else if (value == 3) {
      foundTransactions =
          TransactionDB.instance.monthlyTransactionNotifier.value;
    }
    notifyListeners();
  }

  void checkAllTransaction2(int value) {
    if (value == 1) {
      foundTransactions = TransactionDB.instance.transactionListNotifier.value;
    } else if (value == 2) {
      foundTransactions =
          TransactionDB.instance.incomeTransactionNotifier.value;
    } else if (value == 3) {
      foundTransactions =
          TransactionDB.instance.expenseTransactionNotifier.value;
    }
    notifyListeners();
  }

  void checkIncomeTransaction(int value) {
    if (value == 1) {
      foundTransactions =
          TransactionDB.instance.incomeTransactionNotifier.value;
    } else if (value == 2) {
      foundTransactions = TransactionDB.instance.todayIncomeList.value;
    } else if (value == 3) {
      foundTransactions =
          TransactionDB.instance.allMonthlyincomeTransactions.value;
    }
    notifyListeners();
  }

  void checkExpenseTransaction(int value) {
    if (value == 1) {
      foundTransactions =
          TransactionDB.instance.expenseTransactionNotifier.value;
    } else if (value == 2) {
      foundTransactions = TransactionDB.instance.todayExpenseList.value;
    } else if (value == 3) {
      foundTransactions =
          TransactionDB.instance.allMonthlyExpenseTransactions.value;
    }
    notifyListeners();
  }

  void todayTransactionList(int value) {
    if (value == 1) {
      foundTransactions = TransactionDB.instance.todayTransactionNotifier.value;
    } else if (value == 2) {
      foundTransactions = TransactionDB.instance.todayIncomeList.value;
    } else if (value == 3) {
      foundTransactions = TransactionDB.instance.todayExpenseList.value;
    }
    notifyListeners();
  }

  void monthlyTransactionList(int value) {
    if (value == 1) {
      foundTransactions =
          TransactionDB.instance.monthlyTransactionNotifier.value;
    } else if (value == 2) {
      foundTransactions =
          TransactionDB.instance.allMonthlyincomeTransactions.value;
    } else if (value == 3) {
      foundTransactions =
          TransactionDB.instance.allMonthlyExpenseTransactions.value;
    }
    notifyListeners();
  }

  void deleteTransaction(String id) {
    TransactionDB.instance.deleteTransaction(id);
    notifyListeners();
  }

  void dropDownOnchange1(int gettingValue) {
    value4 = gettingValue;
    notifyListeners();
  }

  void dropDownOnchange2(int gettingValue) {
    value2 = gettingValue;
    notifyListeners();
  }
}

DateTime startDate = DateTime.now();
DateTime endDate = DateTime.now();
