import 'package:flutter/material.dart';
import 'package:money_manager/application/home_provider.dart';
import 'package:money_manager/db/category_db/category_db.dart';
import 'package:money_manager/db/transaction_db/transaction_db.dart';
import 'package:money_manager/screens/category_screen/category_screen.dart';
import 'package:money_manager/screens/home_screen/monthly_card_widget.dart';
import 'package:money_manager/screens/home_screen/recent_list.dart';
import 'package:money_manager/screens/settings_screen/settings_screen.dart';
import 'package:money_manager/screens/statics_screen/statics_screen.dart';
import 'package:money_manager/screens/transaction_screen/transaction_screen.dart';
import 'package:provider/provider.dart';
import '../../transaction_model/transaction_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  PageController pageController = PageController();

  List<TransactionModel> transactions =
      TransactionDB.instance.transactionListNotifier.value;

  @override
  Widget build(BuildContext context) {
    print('Hey!!!!');
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refresh();
    return WillPopScope(
      onWillPop: () => onBackButtonPressed(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Money Manager'),
          centerTitle: true,
          backgroundColor: const Color(0xFF15485D),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),

                  //Monthly Balance Card------->

                  child: Monthlycard(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 3),
                  child: ListTile(
                    title: const Text('Recent transactions'),
                    trailing: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) {
                                return const TransactionScreen();
                              }),
                            ),
                          );
                        },
                        child: const Text('View all')),
                  ),
                ),

                //Recents Transactions------->

                const Expanded(
                  child: RecentTransactions(),
                ),
              ],
            ),
            CategoryScreen(),
            const StaticsScreen(),
            const SettingsScreen()
          ],
        ),

        //Bottom Novigation Bar------>

        bottomNavigationBar: Consumer<HomeProvider>(
          builder: (context, value, child) => BottomNavigationBar(
            currentIndex: value.selectedIndex,
            unselectedItemColor: Colors.white38,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  backgroundColor: Color(0xFF15485D),
                  icon: Icon(
                    Icons.home,
                  ),
                  label: '______'),
              BottomNavigationBarItem(
                  backgroundColor: Color(0xFF15485D),
                  icon: Icon(
                    Icons.category,
                  ),
                  label: '______'),
              BottomNavigationBarItem(
                  backgroundColor: Color(0xFF15485D),
                  icon: Icon(
                    Icons.bar_chart,
                  ),
                  label: '______'),
              BottomNavigationBarItem(
                  backgroundColor: Color(0xFF15485D),
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: '______'),
            ],
            onTap: ((value) {
              Provider.of<HomeProvider>(context, listen: false)
                  .navigationChanger(value);

              pageController.animateToPage(
                value,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }),
          ),
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  //Exit Function----->
  Future<bool> onBackButtonPressed(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text('Exit'),
          content: const Text('Do you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: (() {
                Navigator.of(context).pop(true);
              }),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
          ],
        );
      }),
    );
    return exitApp;
  }
}
