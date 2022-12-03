// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:money_manager/application/category_screen_provider.dart';
import 'package:money_manager/db/category_db/category_db.dart';
import 'package:provider/provider.dart';
import '../../catagory_model/category_model.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  List<String> items = [
    'Income',
    'Expense',
  ];

  @override
  Widget build(BuildContext context) {
    CategoryDB().refreshUI();
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<CategoryScreenProvider>(
                builder: (context, value, child) => DropdownButton(
                  borderRadius: BorderRadius.circular(18),
                  hint: const Text(
                    'Income',
                    style: TextStyle(color: Colors.black),
                  ),
                  value: value.selectedItem,
                  items: items.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (item) {
                    Provider.of<CategoryScreenProvider>(context, listen: false)
                        .categoryChanger(item!);
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: CategoryDB
                    .instance.allIncomeAndExpenseCategoryList.value.isEmpty
                ? const Center(
                    child: Text(
                      'No categories added',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  )
                : Consumer<CategoryScreenProvider>(
                    builder: (context, value, child) => ValueListenableBuilder(
                      valueListenable: (value.selectedItem == items[1]
                          ? CategoryDB().expenseCategoryListNotifier
                          : CategoryDB().incomeCategoryListNotifier),
                      builder: (BuildContext ctx, List<CategoryModel> newList,
                          Widget? _) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: newList.length,
                          itemBuilder: (ctx, index) {
                            final category = newList[index];
                            return Card(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(category.name),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        CategoryDB.instance
                                            .deleteCategory(category.id);
                                      },
                                      icon: const Icon(Icons.delete))
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
