import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_manager/screens/transaction_screen/transaction_screen.dart';
import 'package:provider/provider.dart';

import '../../application/transaction_screen_provider.dart';
import '../../catagory_model/category_model.dart';

class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionScreenProvider>(
      builder: (context, value, child) => Expanded(
        child: value.foundTransactions.isEmpty
            ? Center(
                child: Text(
                  'Transaction Not found',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            : ListView.separated(
                itemBuilder: ((context, index) {
                  final transactionList = value.foundTransactions[index];
                  return Slidable(
                    key: Key(transactionList.id!),
                    startActionPane:
                        ActionPane(motion: const StretchMotion(), children: [
                      SlidableAction(
                        onPressed: (ctx) {
                          value.deleteTransaction(transactionList.id!);
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
                              contentPadding: const EdgeInsets.all(18),
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
                      trailing: transactionList.type == CategoryType.income
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
    );
  }
}
