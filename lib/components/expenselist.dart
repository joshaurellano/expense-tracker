import 'package:expense_tracker/screens/editscreen.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class Expenselist extends StatelessWidget {

  final bool editMode;
  final Expense expense;

  const Expenselist({
      super.key, 
      required this.expense,
      this.editMode = false,
    });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
        leading: Container(                          
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: 32,
            height: 32,
            child: expense.icon,
          ),
        ),
        title: Text(expense.description,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500
          ),),
        subtitle: editMode ? Text('- ₱ ${expense.amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16
          )) : Row(
            children: [
              Text('${expense.selectDate.month}/${expense.selectDate.day}/${expense.selectDate.year} '),
              Icon(Icons.circle, size: 5,),
              Text(' ${expense.category}')
            ]),
        trailing: editMode ? GestureDetector(
          onTap: () => {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (context) => Editscreen(expenseDetail: expense)) )
          },
          child: Text("Edit", style: TextStyle(
            fontSize: 18,
            decoration: TextDecoration.underline
          ),),
        )
        : Text('- ₱ ${expense.amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18
          )),
      );
  }
}