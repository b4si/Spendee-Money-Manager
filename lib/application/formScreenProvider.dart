import 'package:flutter/material.dart';
import 'package:money_manager/db/category_db/category_db.dart';
import 'package:money_manager/db/transaction_db/transaction_db.dart';
import '../catagory_model/category_model.dart';

class FromScreenProvider with ChangeNotifier {
  CategoryType? selectedCategorytype = CategoryType.income;
  String? categoryID;
  DateTime? selectedDate;
  CategoryModel? selectedCategoryModel;

  void incomeRadioButton() {
    selectedCategorytype = CategoryType.income;
    notifyListeners();
  }

  void expenseRadioButton() {
    selectedCategorytype = CategoryType.expense;
    notifyListeners();
  }

  void changeCategoryList(String? selectedValue) {
    categoryID = selectedValue;
    notifyListeners();
  }

  void refreshUI() {
    CategoryDB.instance.refreshUI();
    notifyListeners();
  }

  void setDate(DateTime selectedDateTemp) {
    selectedDate = selectedDateTemp;
    notifyListeners();
  }

  void refreshTransactionList() {
    TransactionDB.instance.refresh();
    notifyListeners();
  }
}
