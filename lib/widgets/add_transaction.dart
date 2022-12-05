import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function onAddTransaction;

  const AddTransaction({
    Key? key,
    required this.onAddTransaction,
  }) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) return;
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate != null
                          ? DateFormat.yMMMMd().format(_selectedDate!)
                          : 'No date choosen',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _showDatePicker();
                    },
                    child: const Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final enteredTitle = _titleController.text;
                final enteredAmount = double.parse(_amountController.text);

                if (enteredTitle.isEmpty || enteredAmount <= 0) {
                  return;
                }

                Navigator.pop(context);
                widget.onAddTransaction(
                    enteredTitle, enteredAmount, _selectedDate);
              },
              child: const Text('Add transaction'),
            )
          ],
        ),
      ),
    );
  }
}
