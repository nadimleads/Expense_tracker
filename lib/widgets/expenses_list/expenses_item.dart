import 'package:expense_tracker/models/cost.dart';
import 'package:flutter/material.dart';
// import 'package:expense_tracker/widgets/input_expenses.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expenseitem, {super.key});

  final Cost expenseitem;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // roundness of the card
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseitem.title,
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '${expenseitem.amount.toStringAsFixed(0)} Taka', //if it was 1 then 1.23454 => 1.2
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      categoryIcons[expenseitem.category],
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    SizedBox(width: 08),
                    Text(expenseitem.fomattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
