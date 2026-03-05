import 'package:flutter/material.dart';
import './addexpense.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String user = 'Joshua';
  final List expenseList = [];
  final double expenses = 0;
  final double budget = 0;
  final double remainingbudget = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed:  () {
        Navigator.push(context, MaterialPageRoute<void>(builder: (context) => const AddExpense()));
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
              Text('Recent Expenses',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),),
              SizedBox(height: 20,),
              Expanded(child: expenseList.isEmpty ? Center(
                child: Text('No expense added'),
              ): Container()),
              
            ],
          ),
        ),
      ),
    );
  }
}