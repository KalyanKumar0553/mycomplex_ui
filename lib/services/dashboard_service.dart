import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mycomplex_ui/screens/side_nav/activity_screen.dart';
import 'dart:convert';

import 'package:mycomplex_ui/screens/home_screen.dart';
import 'package:mycomplex_ui/screens/side_nav/my_unit_screen.dart';
import 'package:mycomplex_ui/screens/side_nav/notes_screen.dart';
import 'package:mycomplex_ui/screens/side_nav/profile_screen.dart';

class DashboardService {
  final String token;
  final String userId;

  DashboardService({required this.token, required this.userId});

  Future<List<Map<String, String>>> fetchApartments() async {
    // final response = await http.get(
    //   Uri.parse('https://yourapi.com/api/user/v1/${widget.userID}'),
    //   headers: {
    //     'Authorization': 'Bearer ${widget.token}',
    //   },
    // );
    // if (response.statusCode == 200) {
      List<dynamic> apartmentsData = [{'id':1,'name':'Aparna Sarovar'},{'id':2,'name':'Myhome Avatar'}];//json.decode(response.body)['apartments'];
      return apartmentsData.map((apartment) {
        return {
          'id': apartment['id'].toString(),
          'name': apartment['name'].toString()
        };
      }).toList();
    // } else {
    //   throw Exception('Failed to load apartments');
    // }
  }

  Widget getWidgetOption(int index,String selectedApartmentID) {
    switch (index) {
      case 0:
        return HomeScreen(selectedApartmentID: selectedApartmentID);
      case 1:
        return const MyUnitScreen();
      case 2:
        return const ActivityScreen();
      case 3:
        return const ProfileScreen();
      case 4:
        return const NotesScreen();
      default:
        return HomeScreen(selectedApartmentID: selectedApartmentID);
    }
  }

}
