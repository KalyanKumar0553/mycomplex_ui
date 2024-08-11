import 'package:flutter/material.dart';
import 'package:mycomplex_ui/screens/navigation/header.dart';

import '../../colors.dart';

class HomeScreen extends StatefulWidget {

  final String selectedApartmentID;
  final String userID;
  final List<Map<String, String>> apartments;
  final ValueChanged<String?> onApartmentChanged;

  const HomeScreen({super.key, required this.selectedApartmentID, required this.userID,required this.apartments,required this.onApartmentChanged,});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}
  

class _HomeScreenState extends State<HomeScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
             DashboardHeader(
                selectedApartmentID: widget.selectedApartmentID,
                apartments: widget.apartments,
                onApartmentChanged: widget.onApartmentChanged,
                userID: widget.userID,
            ),
            Expanded(
              child: Center(
                child: Text('Home Screen'),
              ),
            )
          ],
        ),
      )
    );
  }
}