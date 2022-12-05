// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_manager/application/transaction_screen_provider.dart';
import 'package:provider/provider.dart';
import '../../catagory_model/category_model.dart';
import '../../db/transaction_db/transaction_db.dart';
import '../../transaction_model/transaction_model.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});

  List<TransactionModel> transactions =
      TransactionDB.instance.transactionListNotifier.value;

  //Search Function------->

  void runFilter(String enteredKeyword, context) {
    List<TransactionModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = transactions;
    } else {
      results = transactions
          .where(
            (user) => user.category.name.trim().toLowerCase().contains(
                  enteredKeyword.trim().toLowerCase(),
                ),
          )
          .toList();
    }
    Provider.of<TransactionScreenProvider>(context, listen: false)
        .searchResult(results);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<TransactionScreenProvider>(context, listen: false)
                  .pickDateRangeValue(context);
            },
            icon: const Icon(
              Icons.calendar_month,
            ),
          ),
        ],
        centerTitle: true,
        title: const Text('Transactions'),
        backgroundColor: const Color(0xFF15485D),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),

              //Dropdown button for all,income,expense------->

              child: Consumer<TransactionScreenProvider>(
                builder: (context, value, child) => DropdownButton(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(18),
                  dropdownColor: Colors.blueGrey[100],
                  underline: Container(),
                  value: value.value4,
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: const Text('All'),
                      onTap: () {
                        Provider.of<TransactionScreenProvider>(context,
                                listen: false)
                            .checkAllTransaction(value.value2);
                      },
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: const Text('Income'),
                      onTap: () {
                        Provider.of<TransactionScreenProvider>(context,
                                listen: false)
                            .checkIncomeTransaction(value.value2);
                      },
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: const Text('Expense'),
                      onTap: () {
                        Provider.of<TransactionScreenProvider>(context,
                                listen: false)
                            .checkExpenseTransaction(value.value2);
                      },
                    ),
                  ],
                  onChanged: ((gettingValue) {
                    value.dropDownOnchange1(gettingValue!);
                  }),
                ),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 8),

              //Dropdown Button for all,today,monthly----->

              child: Consumer<TransactionScreenProvider>(
                builder: (context, value, child) => DropdownButton(
                  elevation: 1,
                  dropdownColor: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(18),
                  underline: Container(),
                  value: value.value2,
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: const Text('All'),
                      onTap: () {
                        Provider.of<TransactionScreenProvider>(context,
                                listen: false)
                            .checkAllTransaction2(value.value4);
                      },
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: const Text('Today'),
                      onTap: () {
                        Provider.of<TransactionScreenProvider>(context,
                                listen: false)
                            .todayTransactionList(value.value4);
                      },
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: const Text(
                        'Monthly',
                      ),
                      onTap: () {
                        Provider.of<TransactionScreenProvider>(context,
                                listen: false)
                            .monthlyTransactionList(value.value4);
                      },
                    ),
                  ],
                  onChanged: ((gettingValue) {
                    value.dropDownOnchange2(gettingValue!);
                  }),
                ),
              ),
            ),
          ),

          //Search field------->

          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      onChanged: ((value) => runFilter(value, context)),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        suffixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                Consumer<TransactionScreenProvider>(
                  builder: (context, value, child) => Expanded(
                    child: transactions.isEmpty
                        ? Center(
                            child: Text(
                              'Transaction Not found',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: ((context, index) {
                              final transactionList =
                                  value.foundTransactions[index];
                              return Slidable(
                                key: Key(transactionList.id!),
                                startActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (ctx) {
                                          value.deleteTransaction(
                                              transactionList.id!);
                                        },
                                        backgroundColor: Colors.red,
                                        icon: Icons.delete,
                                        label: "Delete",
                                      ),
                                    ]),
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return SimpleDialog(
                                          contentPadding:
                                              const EdgeInsets.all(18),
                                          title: const Text('Details'),
                                          children: [
                                            Text(
                                              'Category : ${transactionList.category.name}',
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Amount   : ${transactionList.amount}',
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Date         : ${parseDate(
                                                transactionList.date,
                                              )}',
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Notes       : ${transactionList.notes}',
                                            ),
                                          ],
                                        );
                                      }),
                                    );
                                  },
                                  title: Text(transactionList.category.name),
                                  subtitle: Text(
                                    parseDate(transactionList.date),
                                  ),
                                  trailing: transactionList.type ==
                                          CategoryType.income
                                      ? Text(
                                          '₹${transactionList.amount.toString()}',
                                          style: const TextStyle(
                                            color: Colors.green,
                                          ),
                                        )
                                      : Text(
                                          '₹${transactionList.amount.toString()}',
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                ),
                              );
                            }),
                            separatorBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.only(right: 15, left: 15),
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              );
                            },
                            itemCount: value.foundTransactions.length,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String parseDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
