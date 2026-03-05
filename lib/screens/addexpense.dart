import 'package:flutter/material.dart';
import './homescreen.dart';
class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense", style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Amount', 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),),
              TextFormField(
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), 
                prefixText: '₱ ', prefixStyle: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
                hintText: '0'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20,),
              const Text('Choose Category', 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),),
              Expanded(child: const Text("")),
              SizedBox(height: 20,),
              const Text('Description', 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),),
              TextFormField(decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),),
              SizedBox(height: 20,),
              SizedBox(width: 350, height: 50,
              child: 
                ElevatedButton(onPressed: (){
                  Navigator.pop(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const HomeScreen())
                  );
                }, style: 
                ButtonStyle(
                  elevation: WidgetStatePropertyAll(10.0),
                  shadowColor: WidgetStatePropertyAll(Color.fromARGB(255, 0, 0, 0)),
                  backgroundColor: WidgetStatePropertyAll(Colors.blue)) ,child: const 
                  Text('Save Expense', style: 
                    TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 20,
                      color: Colors.white,
                      ),
                    )
                  ),
            ),
          ],
        ),
        )
      ),
    );
  }
}