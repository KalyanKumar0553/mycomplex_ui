import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mycomplex_ui/screens/daily_help/daily_help_category_screen.dart';
import 'dart:convert';
import '../../colors.dart';

class DailyHelpScreen extends StatefulWidget {
  
  final String selectedApartmentID;
  
  const DailyHelpScreen({super.key,required this.selectedApartmentID});

  @override
  // ignore: library_private_types_in_public_api
  _DailyHelpScreenState createState() => _DailyHelpScreenState();
}

class _DailyHelpScreenState extends State<DailyHelpScreen> {
  List<Map<String, dynamic>> dailyHelpDetails = [];
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    fetchDailyHelpDetails();
  }

  Future<void> fetchDailyHelpDetails() async {

  const mockJsonResponse = '''
    [
      {"name": "Maid", "count": 119,"id":1},
      {"name": "Driver", "count": 4,"id":2},
      {"name": "Cook", "count": 37,"id":3},
      {"name": "Milkman", "count": 19,"id":4},
      {"name": "Paperboy", "count": 1,"id":5},
      {"name": "Car Cleaner", "count": 9,"id":6},
      {"name": "Nanny", "count": 2,"id":7},
      {"name": "Dance Teacher", "count": 2,"id":8},
      {"name": "Tuition Teacher", "count": 5,"id":9},
      {"name": "Gym Instructor", "count": 2,"id":10},
      {"name": "Badminton Instructor", "count": 1,"id":11},
      {"name": "Basketball Instructor", "count": 1,"id":12},
      {"name": "Plumber", "count": 2}
    ]
    ''';

    
    // final response = await http.get(Uri.parse('https://yourapi.com/api/daily-help'));

    // if (response.statusCode == 200) {
      setState(() {
        // dailyHelpDetails = List<Map<String, dynamic>>.from(json.decode(response.body));
        dailyHelpDetails = List<Map<String, dynamic>>.from(json.decode(mockJsonResponse));
        isLoading = false;
      });
    // } else {
    //   throw Exception('Failed to load daily help details');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
        title: const Text('Daily Help', style: TextStyle(color: AppColors.onPrimary)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.onPrimary),
            onPressed: () {
              // Implement search functionality if needed
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dailyHelpDetails.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dailyHelpDetails[index]['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(dailyHelpDetails[index]['count'].toString()),
                      const Icon(Icons.chevron_right,color: AppColors.primary,),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DailyHelpCategoryScreen(
                          category: dailyHelpDetails[index],
                          selectedApartmentID: widget.selectedApartmentID,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
