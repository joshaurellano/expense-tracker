import 'package:flutter/material.dart';
import './addexpense.dart';
import '../models/expense.dart';
import '../components/expenselist.dart';
import './editscreen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String user = 'Joshua';
  final List<Expense> expenseList = [];
  double expenses = 0;
  final double budget = 0;
  final double remainingbudget = 0;
  bool editMode = false;

  

  String get formattedExpenses =>
      expenses % 1 == 0
          ? '₱${expenses.toInt()}'
          : '₱${expenses.toStringAsFixed(2)}';

  String get formattedBudget =>
      expenses % 1 == 0
          ? '₱${budget.toInt()}'
          : '₱${budget.toStringAsFixed(2)}';

  String get formattedRemainingBudget =>
      expenses % 1 == 0
          ? '₱${remainingbudget.toInt()}'
          : '₱${remainingbudget.toStringAsFixed(2)}';

  Future<void> _openEditScreen(int index) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Editscreen(
      expenseDetail: expenseList[index],
      index: index,
    )),
  );

  if (result != null) {
    setState(() {
      expenses -= expenseList[index].amount;        
      expenseList[index] = result['expense'];        
      expenses += result['expense'].amount;         
    });
  }
}
          

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed:() async {
        final newExpense = await Navigator.push<Expense>(
          context, MaterialPageRoute(builder: (context) => const AddExpense())
        );
        if (newExpense != null){
          setState(() {
            expenseList.add(newExpense);
            expenses += newExpense.amount;

        

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Yay!... ${newExpense.description} added!')));
          });
        }
      },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(), 
        child: const Icon(Icons.add, color: Colors.white),),
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            mainAxisAlignment: MainAxisAlignment.start,  
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome, $user!',
                    style: TextStyle(
                      color: Color(0xFF1B1B4E),
                      fontWeight: FontWeight.w800,
                      fontSize: 26,
                    ),
                  ),
                  CircleAvatar(                         
                    radius: 22,
                    backgroundImage: AssetImage("lib/assets/images/profile.png"),
                    backgroundColor: Colors.blue.shade100,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Card(
                color: Color.fromARGB(255,137, 207, 240),
                child: Padding(padding: EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Total Expenses', style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                      SizedBox(height: 20,),
                      Text(formattedExpenses, style:TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      )),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Budget Alloted: '),
                              Text(formattedBudget,style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Remaining: '),
                              Text(formattedRemainingBudget,style: TextStyle(
                                fontWeight: FontWeight.bold
                              ))
                            ],
                          ),
                        ],)
                    ],

                  ),
                ),),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Expenses',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),),
                  expenseList.isEmpty ? const Text(""):
                  GestureDetector(
                    onTap: () => {
                      setState(() {
                        editMode = !editMode;
                      })
                    },
                    child: !editMode ? Icon(Icons.edit) : Icon(Icons.edit_off))
                ],
              ),
              SizedBox(height: 20,),
              Expanded(child: expenseList.isEmpty ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment_outlined),
                    Text('No expenses yet'),
                    Text('Tap the "+" button to add expense'),
                  ],
                ),
              ): ListView.separated(
                itemCount: expenseList.length,
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemBuilder: (context,index)
              {
                  return Expenselist(
                    expense: expenseList[index],
                    editMode: editMode,
                    index: index,
                    onEdit: () => _openEditScreen(index)
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}