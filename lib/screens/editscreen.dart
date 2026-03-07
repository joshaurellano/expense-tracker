import 'package:flutter/material.dart';
import '../models/expense.dart'; // Add this line


class Editscreen extends StatefulWidget {
  final Expense expenseDetail;
  const Editscreen({super.key, required this.expenseDetail});

  @override
  State<Editscreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Text(widget.expenseDetail.description),
      )),
    );
  }
}