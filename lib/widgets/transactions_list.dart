import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:expenses_manager_flutter/models/transaction.dart';
import 'package:expenses_manager_flutter/widgets/empty.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function onDeleteTransaction;

  const TransactionsList({
    Key? key,
    required this.transactions,
    required this.onDeleteTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? const Empty(title: 'No transactions added yet')
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                          '${transactions[index].amount.toStringAsFixed(1)} \$',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(transactions[index].date),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      onDeleteTransaction(index);
                    },
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
