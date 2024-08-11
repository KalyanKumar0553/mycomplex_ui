import 'package:flutter/material.dart';
import 'package:mycomplex_ui/constants.dart';
import 'package:mycomplex_ui/helper/shared_preferences_helper.dart';
import 'package:mycomplex_ui/screens/dashboard/dashboard_footer.dart';
import 'package:mycomplex_ui/services/dashboard_service.dart';
import '../../colors.dart';

class DashboardScreen extends StatefulWidget {
  
  final String token;
  final String userID;

  const DashboardScreen({super.key,required this.token,required this.userID});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String _selectedApartmentID = '';
  List<Map<String, String>> _apartments = [];
  late DashboardService _dashboardService;
  bool _isLoading = true;
  
  @override
  void initState() {
    _dashboardService = DashboardService(token: widget.token,userID:widget.userID);
    super.initState();
    _fetchApartments();
  }

  Future<void> _fetchApartments() async {
    try {
      List<Map<String, String>> apartments = await _dashboardService.fetchApartments();
      setState(() {
        _apartments = apartments;
        if (_apartments.isNotEmpty) {
          _selectedApartmentID = _apartments[0]['id']!;
        }
        _isLoading = false;
      });

      // Save the selected apartment to shared preferences
      await SharedPreferencesHelper.saveValue(SharedPreferencesKeys.selectedApartmentID, _selectedApartmentID);
    } catch (error) {
      // Handle the error
      print('Failed to load apartments: $error');
    }
  }
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onApartmentChanged(String? newValue) async {
    if (newValue != null) {
      setState(() {
        _selectedApartmentID = newValue;
      });
      await SharedPreferencesHelper.saveValue(SharedPreferencesKeys.selectedApartmentID, newValue);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: _dashboardService.getWidgetOption(_selectedIndex,_selectedApartmentID,_apartments,_onApartmentChanged),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () => _onItemTapped(4),
          child: const Icon(Icons.add, color:  Colors.white ,size: 30),
      ),
      bottomNavigationBar:DashboardFooter(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

