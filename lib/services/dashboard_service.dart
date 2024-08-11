import 'package:flutter/material.dart';
import 'package:mycomplex_ui/screens/tabs/activity_screen.dart';
import 'package:mycomplex_ui/screens/tabs/add_screen.dart';

import 'package:mycomplex_ui/screens/tabs/home_screen.dart';
import 'package:mycomplex_ui/screens/tabs/my_unit_screen.dart';
import 'package:mycomplex_ui/screens/tabs/profile_screen.dart';

class DashboardService {
  final String token;
  final String userID;

  DashboardService({required this.token, required this.userID});

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

  Widget getWidgetOption(int index,String selectedApartmentID,List<Map<String, String>> apartments,ValueChanged<String?> onApartmentChanged) {
    switch (index) {
      case 0:
        return HomeScreen(selectedApartmentID: selectedApartmentID,userID: userID,apartments:apartments,onApartmentChanged:onApartmentChanged);
      case 1:
        return MyUnitScreen(selectedApartmentID: selectedApartmentID,userID: userID,apartments:apartments,onApartmentChanged:onApartmentChanged);
      case 2:
        return ActivityScreen(selectedApartmentID: selectedApartmentID,userID: userID,apartments:apartments,onApartmentChanged:onApartmentChanged);
      case 3:
        return ProfileScreen(selectedApartmentID: selectedApartmentID,userID: userID,);
      case 4:
        return AddScreen(selectedApartmentID: selectedApartmentID,userID: userID,apartments:apartments,onApartmentChanged:onApartmentChanged);
      default:
        return HomeScreen(selectedApartmentID: selectedApartmentID,userID: userID,apartments:apartments,onApartmentChanged:onApartmentChanged);
    }
  }

}
