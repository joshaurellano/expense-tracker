import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../components/expenseform.dart';

class Editscreen extends StatelessWidget { 
  final Expense expenseDetail;
  final int index;

  const Editscreen({
    super.key,
    required this.expenseDetail,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Expenses', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ExpenseForm(
          existingExpense: expenseDetail,  
          onSave: (expense) => Navigator.pop(context, {'expense': expense, 'index': index}),
        ),
      ),
    );
  }
}