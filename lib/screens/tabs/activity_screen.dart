import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycomplex_ui/colors.dart';
import 'package:mycomplex_ui/model/unit_activity.dart';
import 'package:mycomplex_ui/screens/navigation/header.dart';
import 'package:http/http.dart' as http;
import 'package:mycomplex_ui/constants.dart';
import 'dart:convert';
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
  

class _ActivityScreenState extends State<ActivityScreen> with SingleTickerProviderStateMixin {
  

  late TabController _tabController;
  late Future<List<UnitActivity>> activityUpdates;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    activityUpdates = fetchActivityUpdates(); // Initialize with the first tab's data
  }


  // Future<List<UnitActivity>> fetchActivityUpdates() async {
  //   final response = await http.get(Uri.parse('https://yourapi.com/gateupdates'));
  //   await Future.delayed(const Duration(seconds: 1));
  //   if (response.statusCode == 200) {
  //     List<dynamic> data = json.decode(response.body);
  //     return data.map((json) => UnitActivity.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load gate updates');
  //   }
  // }


  Future<List<UnitActivity>> fetchActivityUpdates() async {
    await Future.delayed(const Duration(seconds: 3));
    String result ='''
      [
          {
            "name": "Arasappan",
            "serviceType": "Food Delivery",
            "unit": "3 - 3021",
            "approvedBy": "Kalyan Kunar",
            "dateTime": "2024-08-18T20:29:00",
            "imageUrl": "https://s.ndtvimg.com/images/entities/300/yuvraj-singh-456.png",
            "entryTime": "18 Aug, 08:29 pm",
            "exitTime": "18 Aug, 08:29 pm"
          },
          {
            "name": "Yuvaraj",
            "serviceType": "Food Delivery",
            "unit": "3 - 3021",
            "approvedBy": "Kalyan Kunar",
            "dateTime": "2024-08-18T20:21:00",
            "imageUrl": "https://s.ndtvimg.com/images/entities/300/yuvraj-singh-456.png",
            "entryTime": "18 Aug, 08:21 pm",
            "exitTime": "18 Aug, 08:21 pm"
          },
          {
            "name": "Shadowfax",
            "serviceType": "Courier Delivery",
            "unit": "3 - 3021",
            "approvedBy": "Kalyan Kunar",
            "dateTime": "2024-08-18T20:15:00",
            "imageUrl": "https://s.ndtvimg.com/images/entities/300/yuvraj-singh-456.png",
            "entryTime": "18 Aug, 08:15 pm",
            "exitTime": "18 Aug, 08:15 pm"
          }
        ]
    ''';
    List<dynamic> data = json.decode(result);
    return data.map((json) => UnitActivity.fromJson(json)).toList();
  }

  void _onTabChanged() {
    setState(() {
      activityUpdates = fetchActivityUpdates();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by name...',
                        prefixIcon: Icon(Icons.search, color: AppColors.background),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: AppColors.background),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: AppColors.background,
                    child: TabBar(
                      controller: _tabController,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.background,
                      indicatorColor: AppColors.primary,
                      tabs: [
                        Tab(text: 'Coming'),
                        Tab(text: 'Packages'),
                        Tab(text: 'Past'),
                        Tab(text: 'Exit pass'),
                      ],
                      onTap: (index) => _onTabChanged(),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildGateUpdateList(),
                        _buildGateUpdateList(),
                        _buildGateUpdateList(),
                        _buildGateUpdateList(),
                      ],
                    ),
                  ),                                                    
                ],
              )
            )
          ],
        ),
      )
    );
  }

   Widget _buildGateUpdateList() {
    return FutureBuilder<List<UnitActivity>>(
      future: activityUpdates,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final gateUpdate = snapshot.data![index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                color: AppColors.inputFillColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(gateUpdate.imageUrl),
                            radius: 30,
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                gateUpdate.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                gateUpdate.serviceType,
                                style: TextStyle(color: AppColors.background),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.call, color: AppColors.background),
                            onPressed: () {
                              // Call action here
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.block, color: AppColors.background),
                            onPressed: () {
                              // Block action here
                            },
                          ),
                        ],
                      ),
                      Divider(color: AppColors.borderColor),
                      Text('Name: ${gateUpdate.name}', style: TextStyle(color: AppColors.textColor)),
                      Text('Unit: ${gateUpdate.unit}', style: TextStyle(color: AppColors.textColor)),
                      Text('Approved by: ${gateUpdate.approvedBy}', style: TextStyle(color: AppColors.textColor)),
                      Text('Date & Time: ${DateFormat.yMMMd().add_jm().format(gateUpdate.dateTime)}', style: TextStyle(color: AppColors.textColor)),
                      Divider(color: AppColors.borderColor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Entry: ${gateUpdate.entryTime}', style: TextStyle(color: AppColors.success)),
                          Text('Exit: ${gateUpdate.exitTime}', style: TextStyle(color: AppColors.error)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}