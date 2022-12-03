import 'package:flutter/material.dart';

class CategoryScreenProvider with ChangeNotifier {
  String? selectedItem;

  void categoryChanger(String item) {
    selectedItem = item;
    notifyListeners();
  }
}
