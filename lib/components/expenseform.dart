import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  final Expense? existingExpense;   
  final Function(Expense) onSave;   

  const ExpenseForm({
    super.key,
    this.existingExpense,    
    required this.onSave,
  });

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  late TextEditingController expenseNameController;
  late TextEditingController expenseAmountController;
  final _formKey = GlobalKey<FormState>();
  String? selectedCategory;
  late DateTime selectedDate;

  final List categories = [
    {"name": 'Food',
    "icon": Image(image: AssetImage("lib/assets/images/food.png"))
    },
    {"name": 'Transport',
    "icon": Image(image: AssetImage("lib/assets/images/transportation.png"))},
    {"name": 'Shopping',      
    "icon": Image(image: AssetImage("lib/assets/images/shopping.png"))
    },
    {"name": 'Home',          
    "icon": Image(image: AssetImage("lib/assets/images/home.png"))
    },
    {"name": 'Entertainment', 
    "icon": Image(image: AssetImage("lib/assets/images/entertainment.png"))
    },
    {"name": 'Health',        
    "icon": Image(image: AssetImage("lib/assets/images/health.png"))
    },
    {"name": 'Bills',         
    "icon": Image(image: AssetImage("lib/assets/images/bills.png"))
    },
    {"name": 'Education',     
    "icon": Image(image: AssetImage("lib/assets/images/education.png"))
    },
  ];

  bool get isEditMode => widget.existingExpense != null;  

  @override
  void initState() {
    super.initState();
    expenseNameController = TextEditingController(
      text: widget.existingExpense?.description ?? '',
    );
    expenseAmountController = TextEditingController(
      text: widget.existingExpense?.amount.toStringAsFixed(0) ?? '',
    );
    selectedCategory = widget.existingExpense?.category;
    selectedDate = widget.existingExpense?.selectDate ?? DateTime.now();
  }

  @override
  void dispose() {
    expenseNameController.dispose();
    expenseAmountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() => selectedDate = pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(isEditMode ? 'Edit Amount' : 'Amount',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              TextFormField(
                controller: expenseAmountController,
                validator: (value) {
                  try {
                    if (value == null || value.isEmpty){
                      return 'Amount cannot be empty';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Amount must be greater than 0';
                      }
                  } catch (e) {
                    return 'Enter valid number';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixText: '₱ ',
                  prefixStyle: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  hintText: '0',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              const Text('Choose Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              SizedBox(
                height: 180,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: categories.map((category) {
                    final isSelected = selectedCategory == category['name'];
                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = category['name']),
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
                              width: 28, height: 28,
                              child: category['icon'] as Widget,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(category['name'] as String,
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
              const Text('Select Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              GestureDetector(
                onTap: () => _selectDate(),
                child: Text(
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              TextFormField(
                controller: expenseNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Description cannot be empty';
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Name of expense',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState!.validate();
                    if (!isValid || selectedCategory == null) {
                      if (selectedCategory == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select a category')),
                        );
                      }
                      return;
                    }
                    final expense = Expense(
                      amount: double.parse(expenseAmountController.text),
                      category: selectedCategory!,
                      description: expenseNameController.text,
                      selectDate: selectedDate,
                      icon: categories.firstWhere(
                        (c) => c['name'] == selectedCategory)['icon'] as Widget,
                    );
                    widget.onSave(expense);   // ✅ pass back to parent
                  },
                  style: ButtonStyle(
                    elevation: const WidgetStatePropertyAll(10.0),
                    shadowColor: const WidgetStatePropertyAll(Colors.black),
                    backgroundColor: const WidgetStatePropertyAll(Colors.blue),
                  ),
                  child: Text(isEditMode ? 'Update Expense' : 'Save Expense',  // ✅ dynamic label
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}