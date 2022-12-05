import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/application/statics_screen_provider/all_statics_provider.dart';
import 'package:provider/provider.dart';

class PieCahrt extends StatelessWidget {
  const PieCahrt({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          //FilterDropdown-------->
          child: Consumer<AllStaticsProvider>(
            builder: (context, value, child) => DropdownButton(
              elevation: 1,
              dropdownColor: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(18),
              underline: Container(),
              value: value.value1,
              items: [
                DropdownMenuItem(
                  value: 1,
                  onTap: () {
                    value.allMonthlyAmount();
                  },
                  child: const Text(
                    'Monthly',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                DropdownMenuItem(
                  value: 2,
                  onTap: () {
                    value.allTodayAmount();
                  },
                  child: const Text(
                    'Today',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                DropdownMenuItem(
                  value: 3,
                  onTap: () {
                    value.totalAmount();
                  },
                  child: const Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ],
              onChanged: (gettingValue) {
                value.dropDownOnchange(gettingValue!);
              },
            ),
          ),
        ),

        //All income and expense pie chart-------->

        Consumer<AllStaticsProvider>(
          builder: (context, value, child) => Expanded(
              child: value.totalIncomeAmount != 0
                  ? PieChart(
                      PieChartData(
                        centerSpaceRadius: 0,
                        sectionsSpace: 2,
                        sections: [
                          PieChartSectionData(
                            title: value.totalIncomeAmount.toString(),
                            value: value.totalIncomeAmount,
                            color: Colors.greenAccent,
                            radius: 120,
                          ),
                          PieChartSectionData(
                            title: value.totalExpenseAmount.toString(),
                            value: value.totalExpenseAmount,
                            color: Colors.redAccent,
                            radius: 120,
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: Text(
                        'Not enough Data to display',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Income'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Expense'),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
