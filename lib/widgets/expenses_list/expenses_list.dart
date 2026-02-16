import 'package:expense_tracker/models/cost.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
//import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    required this.expenseslist,
    required this.onRemoveExpense,
    super.key,
  });

  final List<Cost> expenseslist;
  final void Function(Cost expenseAddedList) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseslist.length,
      itemBuilder:
          (ctx, index) =>
              Dismissible //ctx Refers To The context inside the modal sheet (the bottom sheet)
              (
                key: ValueKey(expenseslist[index]),
                background: Container(
                  color: const Color.fromARGB(255, 255, 84, 84),
                ),
                onDismissed: (direction) {
                  onRemoveExpense(expenseslist[index]);
                },
                child: ExpensesItem(
                  expenseslist[index], //
                ),
              ),
    ); //ctx means context
  }
}
