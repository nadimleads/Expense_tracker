//import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/cost.dart';
//import 'package:flutter/services.dart' show FilteringTextInputFormatter;

final formatter = DateFormat.yMd();

class InputExpenses extends StatefulWidget {
  const InputExpenses({super.key, required this.onAddExpense});

  final Function(Cost expense) onAddExpense;

  @override
  State<InputExpenses> createState() => _InputExpenses();
}

class _InputExpenses extends State<InputExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  //Category? _selectedCategory;
  Category _selectedCategory = Category.bills;

  void _presentDayPicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate, //
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialague() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        //for IOS Look
        context: context,
        builder:
            (ctx) => CupertinoAlertDialog(
              title: Text("Invalid Input"),
              content: Text(
                "You may have entered any Invalid Title Amount, Date and Category..",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text("Close"),
                ),
              ],
            ),
      );
    } else {
      showDialog(
        //for Android Look
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text("Invalid Input"),
              content: Text(
                "You may have entered any Invalid Title Amount, Date and Category..",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text("Close"),
                ),
              ],
            ),
      );
    }
  }

  void _submitExpenseData() {
    final eneterdAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = eneterdAmount == null || eneterdAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      _showDialague(); //mathod calling
      return;
    }
    widget.onAddExpense(
      Cost(
        title: _titleController.text,
        amount: eneterdAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        //ct xas annonemous function

        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            keyboardType: TextInputType.text, //already default
                            decoration: InputDecoration(
                              label: Text('Title'), //label wants a widget
                            ),
                          ),
                        ),

                        const SizedBox(width: 24),

                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: 'Tk ',
                              label: Text('Amount'), //label wants a widget
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      keyboardType: TextInputType.text, //already default
                      decoration: InputDecoration(
                        label: Text('Title'), //label wants a widget
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          hint: Text(
                            'Select Category',
                            style: TextStyle(fontSize: 13),
                          ), // This will show initially
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          items:
                              Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(
                                        category.name.toUpperCase(), //
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        SizedBox(width: 12),

                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No Date Selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDayPicker,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: 'Tk ',
                              label: Text('Amount'), //label wants a widget
                            ),
                          ),
                        ),
                        //SizedBox(width: 5),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No Date Selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDayPicker,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 19),

                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancle'),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text('Save Expense'),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          hint: Text(
                            'Select Category',
                            style: TextStyle(fontSize: 13),
                          ), // This will show initially
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          items:
                              Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(
                                        category.name.toUpperCase(), //
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancle'),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text('Save Expense'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
