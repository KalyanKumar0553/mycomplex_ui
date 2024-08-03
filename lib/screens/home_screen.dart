import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String selectedApartmentID;
  final String userID;

  const HomeScreen({super.key, required this.selectedApartmentID, required this.userID});
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
