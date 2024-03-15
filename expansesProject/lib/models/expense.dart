import "package:uuid/uuid.dart";
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

var uuid = Uuid();

final formatter = DateFormat.yMd();

enum Categories { food, travel, leisure, work }

const CategoryIcons = {
  Categories.food: Icons.lunch_dining,
  Categories.leisure: Icons.movie,
  Categories.travel: Icons.flight_takeoff,
  Categories.work: Icons.work
};

class Expense {
  Expense(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  String get formattedDate {
    return formatter.format(date);
  }
}
