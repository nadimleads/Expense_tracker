import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/input_expenses.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/cost.dart';
import 'package:expense_tracker/widgets/appbar/custom_appbar.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/fixed_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Cost> _registeredExpenses = [...dummyExpense];

  void _openAddExpensesOverlay() {
    showModalBottomSheet(
      context:
          context, //context Refers To The screen that launches the modal.(and with the context thing I am telling flutter where to show the 'indicated' model)
      builder: //The builder: is just a function.Its job is to build (return) a widget that should be displayed inside the modal bottom sheet.
          (ctx) => InputExpenses(
            onAddExpense: _addExpense,
          ), //This whole line is saying:“Hey Flutter, when you show the bottom sheet, this is the widget I want to show inside it.”
      isScrollControlled: true,
      useSafeArea: true,
    );
  }

  void _addExpense(Cost expenseNew) {
    setState(() {
      _registeredExpenses.add(expenseNew);
    });
  }

  void _removeExpense(Cost expenseJegulaAddKoraAse) {
    final expenseIndex = _registeredExpenses.indexOf(expenseJegulaAddKoraAse);
    setState(() {
      _registeredExpenses.remove(expenseJegulaAddKoraAse);
    });
    ScaffoldMessenger.of(
      context,
    ).clearSnackBars(); //Now you’re saying:Hey Flutter! Make sure there are no old snack bars lingering…” then “Okay, now show this new one nice and clean!”
    ScaffoldMessenger.of(context).showSnackBar(
      //'context' is a reference to where in the widget tree your widget is located.
      SnackBar(
        duration: const Duration(seconds: 10),
        content: const Text('Expense Deleted.'),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(
                expenseIndex,
                expenseJegulaAddKoraAse,
              ); //reinserting the deleted expense
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // // //now you can use `context` anywhere inside this function
    // //final width = MediaQuery.of(context).size.width;
    // //MediaQuery.of(context).size.height;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Widget mainContent = const Center(
      child: Text('Nothing Added here,\n Start adding Some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenseslist: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE6),
      body: SafeArea(
        //SafeArea is a Flutter widget that makes sure your UI doesn’t get hidden behind some stuffs..
        child: Column(
          children: [
            // Custom AppBar (not using direct AppBar Method)
            CustomAppBar(onAddButtonPressed: _openAddExpensesOverlay),

            const SizedBox(height: 12),

            isLandscape // didnt If else condition..used ternary Expression
                ? Expanded(
                  //Expanded	Gives the ListView (from mainContent->ExpensesList) the full space to grow.
                  child: Row(
                    children: [
                      Expanded(child: Chart(expenses: _registeredExpenses)),
                      Expanded(
                        child: mainContent,
                      ), //Expanded tells Flutter: “Let this child (your list) take up the remaining available vertical space.”
                    ],
                  ),
                )
                : Chart(expenses: _registeredExpenses),
            const SizedBox(height: 12),
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}
