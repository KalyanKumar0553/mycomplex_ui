import 'package:flutter/material.dart';
import 'package:mycomplex_ui/colors.dart';

class HomeScreen extends StatelessWidget {
  final String selectedApartmentID;

  const HomeScreen({super.key, required this.selectedApartmentID});
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
