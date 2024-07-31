import 'package:flutter/material.dart';
import 'package:mycomplex_ui/screens/search_screen.dart';
import '../../colors.dart';

// ignore: must_be_immutable
class DashboardHeader extends StatelessWidget {
  final String selectedApartmentID;
  List<Map<String, String>> apartments = [];
  final ValueChanged<String?> onApartmentChanged;

  DashboardHeader({super.key, 
    required this.selectedApartmentID,
    required this.apartments,
    required this.onApartmentChanged,
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
                            selectionColor: AppColors.onPrimary,
                            style: const TextStyle(color: AppColors.onPrimary, backgroundColor: AppColors.primary),
                          ),
                        ),      
                      );
                    }).toList(),
                   underline: Container(),
                icon: const Icon(Icons.arrow_drop_down, color: AppColors.onPrimary),
                dropdownColor: AppColors.primary,
                style: const TextStyle(color: AppColors.onPrimary),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                color: AppColors.onPrimary,
                onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                color: AppColors.onPrimary,
                onPressed: () {
                  // Handle notifications action
                },
              ),
              IconButton(
                icon: const Icon(Icons.message),
                color: AppColors.onPrimary,
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
