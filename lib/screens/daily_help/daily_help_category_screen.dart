import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mycomplex_ui/screens/daily_help/maid_profile_screen.dart';
import 'dart:convert';
import '../../colors.dart';

class DailyHelpCategoryScreen extends StatefulWidget {
  final Map<String, dynamic> category;
  final String selectedApartmentID;

  const DailyHelpCategoryScreen({super.key, required this.category,required this.selectedApartmentID});

  @override
  // ignore: library_private_types_in_public_api
  _DailyHelpCategoryScreenState createState() => _DailyHelpCategoryScreenState();
}

class _DailyHelpCategoryScreenState extends State<DailyHelpCategoryScreen> {
  List<Map<String, dynamic>> workers = [];
  List<Map<String, dynamic>> filteredWorkers = [];
  bool isLoading = true;
  bool showInsideOnly = false;
  String? selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    fetchWorkers();
  }

  Future<void> fetchWorkers() async {
    // Mock JSON response
    const mockJsonResponse = '''
    [
      {
        "name": "K Saritha",
        "id":1,
        "phone":"123456789",
        "rating": 5.0,
        "houses": 1,
        "freeTimeSlots": "9-10 am, 5-6 pm",
        "inside": false,
        "imageUrl": ""
      },
      {
        "name": "T.anitha",
        "id":2,
        "phone":"123456789",
        "rating": 5.0,
        "houses": 5,
        "freeTimeSlots": "9-10 am",
        "inside": true,
        "imageUrl": ""
      },
      {
        "name": "Nisha",
        "phone":"123456789",
        "id":3,
        "rating": 5.0,
        "houses": 3,
        "freeTimeSlots": "9-10 am, 12-1 pm",
        "inside": true,
        "imageUrl": ""
      },
      {
        "name": "Vadde Meena",
        "phone":"123456789",
        "id":4,
        "rating": 5.0,
        "houses": 6,
        "freeTimeSlots": "9-10 am",
        "inside": true,
        "imageUrl": ""
      },
      {
        "name": "Madharoni Kistamma",
        "phone":"123456789",
        "id":5,
        "rating": 5.0,
        "houses": 1,
        "freeTimeSlots": "9-10 am",
        "inside": false,
        "imageUrl": ""
      }
    ]
    ''';

    // Simulating network delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      workers = List<Map<String, dynamic>>.from(json.decode(mockJsonResponse));
      filteredWorkers = workers;
      isLoading = false;
    });
  }

  void filterWorkers() {
    setState(() {
      if (showInsideOnly) {
        filteredWorkers = workers.where((worker) => worker['inside']).toList();
      } else {
        filteredWorkers = workers;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
        title: Text(widget.category['name'], style: const TextStyle(color: AppColors.onPrimary, overflow: TextOverflow.ellipsis)),
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
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: DropdownButton<String>(
                          value: selectedTimeSlot,
                          hint: const Text('Free Time Slots', style: TextStyle(color: AppColors.onPrimary, overflow: TextOverflow.ellipsis)),
                          dropdownColor: AppColors.primary,
                          icon: const Icon(Icons.arrow_drop_down, color: AppColors.onPrimary),
                          underline: Container(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTimeSlot = newValue;
                              // Implement filter logic for time slots if needed
                            });
                          },
                          items: <String>['Morning', 'Afternoon', 'Evening']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: AppColors.onPrimary)),
                            );
                          }).toList(),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: showInsideOnly,
                            onChanged: (bool? value) {
                              setState(() {
                                showInsideOnly = value ?? false;
                                filterWorkers();
                              });
                            },
                          ),
                          const Text('Inside'),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: filteredWorkers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: filteredWorkers[index]['imageUrl']!="" ? CircleAvatar(
                            backgroundImage: NetworkImage(filteredWorkers[index]['imageUrl']),
                            radius: 30,
                          ) : CircleAvatar(
                            backgroundColor: AppColors.primary,
                            radius: 30,
                            child: Text(
                              filteredWorkers[index]['name'].toString().substring(0,2),
                              style: const TextStyle(fontSize: 20.0,color: AppColors.onPrimary),
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(filteredWorkers[index]['name']),
                              const Icon(Icons.chevron_right, color: AppColors.primary),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (filteredWorkers[index]['inside'])
                                Container(
                                  margin: const EdgeInsets.only(bottom: 4.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.success,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: const Text(
                                    'INSIDE',
                                    style: TextStyle(color: AppColors.onPrimary, fontSize: 12),
                                  ),
                                ),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: AppColors.ratingColors, size: 16),
                                  const SizedBox(width: 4),
                                  Text('${filteredWorkers[index]['rating']} • ${filteredWorkers[index]['houses']} Houses'),
                                ],
                              ),
                              Text('Free on: ${filteredWorkers[index]['freeTimeSlots']}'),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MaidProfileScreen(maidDetails: filteredWorkers[index],selectedApartmentID:widget.selectedApartmentID),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}