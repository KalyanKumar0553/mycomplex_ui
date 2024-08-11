import 'package:flutter/material.dart';
import 'package:mycomplex_ui/colors.dart';
import 'package:mycomplex_ui/screens/navigation/header.dart';

class ActivityScreen extends StatefulWidget {

  final String selectedApartmentID;
  final String userID;
  final List<Map<String, String>> apartments;
  final ValueChanged<String?> onApartmentChanged;

  const ActivityScreen({super.key, required this.selectedApartmentID, required this.userID,required this.apartments,required this.onApartmentChanged,});

  @override
  // ignore: library_private_types_in_public_api
  _ActivityScreenState createState() => _ActivityScreenState();
}
  

class _ActivityScreenState extends State<ActivityScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: DashboardHeader(
      //           selectedApartmentID: widget.selectedApartmentID,
      //           apartments: widget.apartments,
      //           onApartmentChanged: widget.onApartmentChanged,
      //   ),
      //   backgroundColor: AppColors.primary,
      //   iconTheme: const IconThemeData(color: AppColors.background)
      // ),
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
                child: Text('Activity Screen'),
              ),
            )
          ],
        ),
      )
      
      
    );
  }
}