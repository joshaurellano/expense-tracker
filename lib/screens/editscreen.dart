import 'package:flutter/material.dart';

class Editscreen extends StatefulWidget {
  const Editscreen({super.key});

  @override
  State<Editscreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Text('EditScreen'),
      )),
    );
  }
}