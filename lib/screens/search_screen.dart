import 'package:flutter/material.dart';
import 'package:mycomplex_ui/screens/daily_help/daily_help_screen.dart';
import 'dart:convert';
import '../colors.dart';

class SearchScreen extends StatefulWidget {

  final String selectedApartmentID;
  final String userID;
  final List<Map<String, String>> apartments;
  final ValueChanged<String?> onApartmentChanged;

  const SearchScreen({super.key, required this.selectedApartmentID, required this.userID,required this.apartments,required this.onApartmentChanged,});
  
  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
  
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> searchOptions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSearchOptions();
  }

  Future<void> fetchSearchOptions() async {
    // Mock API response
    const mockApiResponse = '''
    [
      {
        "category": "Daily help",
        "icon": "cleaning_services"
      },
      {
        "category": "Visitor Preapprove",
        "icon": "person_add"
      },
      {
        "category": "Society Dues",
        "icon": "account_balance_wallet"
      },
      {
        "category": "Message Guard",
        "icon": "message"
      },
      {
        "category": "Amenities",
        "icon": "pool"
      },
      {
        "category": "Guest Preapproval",
        "icon": "person_add"
      },
      {
        "category": "Cab booking",
        "icon": "local_taxi"
      },
      {
        "category": "Airport cabs---(Lower fares)",
        "icon": "airport_shuttle"
      }
    ]
    ''';

    // Simulating network delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      searchOptions = List<Map<String, dynamic>>.from(json.decode(mockApiResponse));
      isLoading = false;
    });
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'cleaning_services':
        return Icons.cleaning_services;
      case 'person_add':
        return Icons.person_add;
      case 'account_balance_wallet':
        return Icons.account_balance_wallet;
      case 'message':
        return Icons.message;
      case 'pool':
        return Icons.pool;
      case 'local_taxi':
        return Icons.local_taxi;
      case 'airport_shuttle':
        return Icons.airport_shuttle;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.background),
        title: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'What are you looking for?',
              hintStyle: TextStyle(color: AppColors.background),
              border: InputBorder.none,
              fillColor: AppColors.primary,
              filled: true
            ),
            style: TextStyle(color: AppColors.background),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  const Text(
                    'Recent Searches',
                    style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    children: <Widget>[
                      Chip(
                        label: const Text('milk'),
                        backgroundColor: AppColors.primary.withOpacity(0.2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Popular Searches',
                    style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...searchOptions.map((option) {
                    return ListTile(
                      leading: Icon(_getIconData(option['icon']), color: AppColors.primary),
                      title: Text(option['category']),
                      onTap: () {
                         if (option['category'] == 'Daily help') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DailyHelpScreen(selectedApartmentID: widget.selectedApartmentID),
                            ),
                          );
                        } else {
                          // Implement navigation functionality for other options
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
    );
  }
}
