import 'package:flutter/material.dart';
import '../components/expenseform.dart';

class AddExpense extends StatelessWidget {  
  const AddExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ExpenseForm(
          onSave: (expense) => Navigator.pop(context, expense),
        ),
      ),
    );
  }
}