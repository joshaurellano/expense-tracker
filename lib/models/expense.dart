import 'package:flutter/material.dart';
class Expense {
  final double amount;
  final String category;
  final String description;
  final Widget icon; 

  Expense({
    required this.amount,
    required this.category,
    required this.description,
    required this.icon
  });
}