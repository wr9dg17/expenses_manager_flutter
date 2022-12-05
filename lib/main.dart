import 'package:flutter/material.dart';

import 'package:expenses_manager_flutter/models/transaction.dart';
import 'package:expenses_manager_flutter/widgets/chart.dart';
import 'package:expenses_manager_flutter/widgets/transactions_list.dart';
import 'package:expenses_manager_flutter/widgets/add_transaction.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Manager',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20.0,
            fontFamily: 'OpenSans',
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontSize: 16.0,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
            ),
        fontFamily: 'Quicksand',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
            .copyWith(secondary: Colors.indigoAccent),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      title: 'Some transaction',
      amount: 12,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'Another transaction',
      amount: 48,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  void _triggerAddTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (modalContext) {
        return AddTransaction(onAddTransaction: _addTransaction);
      },
    );
  }

  void _addTransaction(String title, double amount, DateTime date) {
    setState(() {
      _transactions.add(
        Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: date,
        ),
      );
    });
  }

  void _deleteTransaction(int index) {
    setState(() {
      _transactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Manager'),
        actions: [
          IconButton(
            onPressed: () => _triggerAddTransaction(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Chart(transactions: _recentTransactions),
            TransactionsList(
              transactions: _transactions,
              onDeleteTransaction: _deleteTransaction,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _triggerAddTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
