import 'package:flutter/material.dart';
import '../models/expense.dart';
class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final expenseNameController = TextEditingController();
  final expenseAmountcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List categories = [{
    "name":'Food', "icon": Image(image: AssetImage("lib/assets/images/food.png"))
  },
  {
    "name":'Transport', "icon": Image(image: AssetImage("lib/assets/images/transportation.png"))
  },
  {
    "name":'Shopping',"icon": Image(image: AssetImage("lib/assets/images/shopping.png"))
  },
  {
    "name": 'Home',"icon": Image(image: AssetImage("lib/assets/images/home.png"))
  },
  {
    "name":'Entertainment',"icon": Image(image: AssetImage("lib/assets/images/entertainment.png"))
  },
  {
    "name": 'Health',"icon": Image(image: AssetImage("lib/assets/images/health.png"))
  },
  {
    "name": 'Bills',"icon": Image(image: AssetImage("lib/assets/images/bills.png"))
  },
  {
    "name":'Education',"icon": Image(image: AssetImage("lib/assets/images/education.png"))
  }
    ];
    String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense", style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Form(
            key: _formKey,
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
                    controller: expenseAmountcontroller,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Amount cannot be empty';
                      }
                      return null;
                    },
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
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 220,
                    child: GridView.count(
                    crossAxisCount: 4,        
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: categories.map((category) {
                      final isSelected = selectedCategory == category['name'];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category['name'];
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue : Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: category['icon'] as Widget,   // ✅ renders your Asset Image
                            ),
                          ),
                            const SizedBox(height: 4),
                            Text(
                              category['name'] as String,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Description', 
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),),
                      TextFormField(
                        controller: expenseNameController,
                        validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Description cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Name of expense',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                      ),),
                      SizedBox(height: 20,),
                      SizedBox(width: 350, height: 50,
                      child: 
                        ElevatedButton(onPressed: (){

                          final isValid = _formKey.currentState!.validate();  
                          if (!isValid || selectedCategory == null) {
                            if (selectedCategory == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please select a category')),  // ✅ category error
                              );
                            }
                            return;
                          }
                    
                          final newExpense = Expense(
                          amount: double.parse(expenseAmountcontroller.text),
                          category: selectedCategory!,
                          description: expenseNameController.text,
                          icon: categories.firstWhere(
                          (c) => c['name'] == selectedCategory
                          )['icon'] as Widget,
                        );
                    
                          Navigator.pop(
                            context, newExpense);
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
                  
                  
              ],
            ),
          ),
          )
        ),
      ),
    );
  }
}