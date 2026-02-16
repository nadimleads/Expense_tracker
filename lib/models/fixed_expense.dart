// import 'package:flutter/material.dart';
import 'package:expense_tracker/models/cost.dart';

final List<Cost> dummyExpense = [
  Cost(
    title: 'Flutter Course',
    amount: 17000,
    date: DateTime.now(),
    category: Category.work,
  ),
  Cost(
    title: 'Tour',
    amount: 60000,
    date: DateTime.now(),
    category: Category.travel,
  ),
  Cost(
    title: 'Shopping',
    amount: 26000,
    date: DateTime.now(),
    category: Category.shopping,
  ),
  Cost(
    title: 'Restaurant',
    amount: 10000,
    date: DateTime.now(),
    category: Category.food,
  ),
  Cost(
    title: 'Wifi Bill',
    amount: 12000,
    date: DateTime.now(),
    category: Category.bills,
  ),
];
