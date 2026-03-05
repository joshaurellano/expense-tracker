import 'package:flutter/material.dart';
import './homescreen.dart';

class Landingscreen extends StatelessWidget {
  const Landingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Expense Tracker", style: TextStyle(
              color: Color(0xFF1B1B4E),
              fontWeight: FontWeight.w700,
              fontSize: 40,
              shadows: [
              Shadow(
                  blurRadius:3.0,  
                  // color: Color(0xFF1B1B4E), 
                  color: Colors.black,
                  offset: Offset(0.0,0.0), 
                  ),
              ],
              ),),
            Image(image:AssetImage("lib/assets/images/wallet-money-cartoon_138676-2086-removebg-preview.png"),width: 150,height: 150, ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text('Track your spendings, set budget', 
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18
              ),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text('and achieve financial clarity', 
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18
              ),),
            ),
            Image(image:AssetImage("lib/assets/images/financial_literacy-removebg-preview.png"), width: 300,height: 300,),
            SizedBox(width: 250, height: 50,
              child: 
                ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const HomeScreen())
                  );
                }, style: 
                ButtonStyle(
                  elevation: WidgetStatePropertyAll(10.0),
                  shadowColor: WidgetStatePropertyAll(Color.fromARGB(255, 0, 0, 0)),
                  backgroundColor: WidgetStatePropertyAll(Colors.blue)) ,child: const 
                  Text('START', style: 
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
       ),
      );
  }
}