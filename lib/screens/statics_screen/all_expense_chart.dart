import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/application/statics_screen_provider/expense_statics_provider.dart';
import 'package:provider/provider.dart';

class AllExpenseChart extends StatelessWidget {
  const AllExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<ExpenseStaticsProvider>(
            builder: (context, value, child) => DropdownButton(
              elevation: 1,
              dropdownColor: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(18),
              underline: Container(),
              value: value.value1,
              items: [
                DropdownMenuItem(
                  value: 0,
                  onTap: () {
                    Provider.of<ExpenseStaticsProvider>(context, listen: false)
                        .MonthlyTranscation();
                  },
                  child: const Text(
                    'Monthly Expense',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                DropdownMenuItem(
                  value: 1,
                  onTap: () {
                    Provider.of<ExpenseStaticsProvider>(context, listen: false)
                        .AnuallyTranscation();
                  },
                  child: const Text(
                    'Annual Expense',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ],
              onChanged: (gettingValue) {
                value.dropDownOnchange(gettingValue!);
              },
            ),
          ),
          Consumer<ExpenseStaticsProvider>(
            builder: (context, value, child) => Container(
              height: 420,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 6,
                      offset: const Offset(0, 4)),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 40.0,
              ),
              margin: const EdgeInsets.all(12.0),
              child: value.temp.length < 2
                  ? const Center(
                      child: Text(
                        'No data to render the chart',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )
                  : LineChart(
                      LineChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              for (int i = 0; i < value.temp.length; i++)
                                FlSpot(
                                  Provider.of<ExpenseStaticsProvider>(context)
                                              .value1 ==
                                          0
                                      ? value.temp[i].date.day.toDouble()
                                      : value.temp[i].date.month.toDouble(),
                                  value.temp[i].amount,
                                ),
                            ],
                            isCurved: false,
                            barWidth: 2.5,
                            color: const Color(0xFF15485D),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
