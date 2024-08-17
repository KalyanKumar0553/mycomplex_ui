import 'package:flutter/material.dart';
import 'package:mycomplex_ui/screens/search/search_header_screen.dart';
import '../../colors.dart';

// ignore: must_be_immutable
class DashboardHeader extends StatelessWidget {
  final String selectedApartmentID;
  List<Map<String, String>> apartments = [];
  final ValueChanged<String?> onApartmentChanged;
  final String userID;
  DashboardHeader({super.key, 
    required this.selectedApartmentID,
    required this.apartments,
    required this.onApartmentChanged,
    required this.userID
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: AppColors.primary, // Background color from AppColors
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(width: 12.0),
              DropdownButton<String>(
                    value: selectedApartmentID,
                    onChanged: onApartmentChanged,
                    items: apartments.map<DropdownMenuItem<String>>((Map<String,String> value) {
                      return DropdownMenuItem<String>(
                        value: value['id'] as String,
                        child: Container(
                          color: AppColors.primary,
                          child: Text(
                            value['name']!,
                            selectionColor: AppColors.background,
                            style: const TextStyle(color: AppColors.background, backgroundColor: AppColors.primary),
                          ),
                        ),      
                      );
                    }).toList(),
                   underline: Container(),
                icon: const Icon(Icons.arrow_drop_down, color: AppColors.background),
                dropdownColor: AppColors.primary,
                style: const TextStyle(color: AppColors.background),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                color: AppColors.background,
                onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchHeaderScreen(selectedApartmentID: selectedApartmentID,apartments:apartments,onApartmentChanged: onApartmentChanged,userID: "",)),
                );
              },
              ),
              IconButton(
                icon: const Icon(Icons.message),
                color: AppColors.background,
                onPressed: () {
                  // Handle message action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
