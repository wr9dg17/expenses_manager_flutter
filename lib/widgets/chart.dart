import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:expenses_manager_flutter/models/transaction.dart';
import 'package:expenses_manager_flutter/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  const Chart({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var total = 0.0;

      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          total += transactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': total};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tx['day'] as String,
                amount: tx['amount'] as double,
                amountPercentOfTotal: totalSpending == 0
                    ? 0
                    : (tx['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
