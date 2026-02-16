//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid(); //3rd party package

enum Category { food, travel, work, shopping, bills, others }

class Cost {
  Cost({
    required this.title,
    required this.amount,
    //required this.id,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  //object creation
  final String id;
  final String title;
  final double amount;
  final Category category;
  final DateTime date;
  String get fomattedDate {
    return formatter.format(date); //intl package 3d party
  }
}

const categoryIcons = {
  Category.food: Icons.lunch_dining_outlined,
  Category.travel: Icons.airplanemode_on_sharp,
  Category.shopping: Icons.shopping_bag_outlined,
  Category.bills: Icons.wifi_rounded,
  Category.work: Icons.work,
  Category.others: Icons.draw_outlined,
};

//see Target is we need 6 buckets for 6 categories, now work on it..

class TotalCostingBucket {
  TotalCostingBucket({
    required this.categoryOfBucket, //all just food(category)
    required this.allExpensesUnderACategory, //Burger,Pizza,cake
  });

  //Fields (Variables)
  final Category categoryOfBucket; //1 bucket for 1 Category(Bucket Food tag)
  final List<Cost>
  allExpensesUnderACategory; //Burger,Pizza,cake (names of those food)

  //👉Now making a Special name constructor(forASingleCategory) that filters expenses
  //(named constructor does filtering operation)
  //keep both constructors separate because they serve different purposes.
  //The named constructor is used when you need to filter that list by category before creating the bucket.
  TotalCostingBucket.forASingleCategory(
    List<Cost>
    allExpenses, //Burger,Pizza,cake, current bill, Panjabi buy etc. all
    this.categoryOfBucket, //all just food(category)
  ) : //filtering net
      allExpensesUnderACategory =
          allExpenses
              .where(
                (oneTotalexpense) => //Burger,Pizza,cake
                    oneTotalexpense
                        .category //all just food(category)
                        ==
                    categoryOfBucket,
              )
              .toList();

  double get totalExpenses {
    double sum = 0;
    for (final oneCategoryVariable in allExpensesUnderACategory) {
      sum += oneCategoryVariable.amount; //sum = sum+ oneTotalexpense.amount;
    }
    return sum;
  }
}
