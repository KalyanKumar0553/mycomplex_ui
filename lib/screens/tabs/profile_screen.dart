import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mycomplex_ui/constants.dart';
import 'package:mycomplex_ui/helper/shared_preferences_helper.dart';
import 'package:mycomplex_ui/screens/move_in_out_community/search_apartment_screen.dart';
import 'package:mycomplex_ui/screens/settings/account_settings_screen.dart';
import 'package:mycomplex_ui/screens/settings/help_and_support_settings_screen.dart';
import 'package:mycomplex_ui/screens/settings/notification_settings_screen.dart';
import 'package:mycomplex_ui/screens/settings/privacy_policy_setting_screen.dart';
import 'package:mycomplex_ui/screens/settings/privacy_settings_screen.dart';
import 'package:mycomplex_ui/screens/settings/profile/profile_details_screen.dart';
import 'package:mycomplex_ui/screens/settings/setting_option.dart';
import 'package:mycomplex_ui/screens/settings/terms_of_service_settings_screen.dart';
import 'package:mycomplex_ui/services/auth_service.dart';
import 'package:mycomplex_ui/widgets/custom_toast_msg.dart';
import '../../colors.dart';
import 'dart:convert'; // For decoding JSON
import 'package:http/http.dart' as http; // For making HTTP requests

const mockJsonResponse = '''
    {
      "name": "Test User",
      "email": "test@user.com",
      "phone": "+91-1234567890",
      "imageUrl":""
    }
  ''';
class ProfileScreen extends StatefulWidget {
  
  final String selectedApartmentID;
  final String userID;

  const ProfileScreen({
    Key? key,
    required this.userID,
    required this.selectedApartmentID,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  Map<String, dynamic>? profileData;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    // _fetchProfileData();
    _fetchProfileMockData();
  }

  Future<void> _fetchProfileData() async {
    final response = await http.get(Uri.parse('https://your-api-endpoint.com/profile/${widget.userID}'));
    if (response.statusCode == 200) {
      setState(() {
        profileData = json.decode(response.body);
      });
    } else {
      print('Failed to load profile data');
    }
  }

  Future<void> _fetchProfileMockData() async {
    // Mock JSON response
    final mockJsonResponse = '''
    {
      "name": "Test User",
      "email": "test@user.co,",
      "phone": "+91-1234567890",
      "imageUrl":""
    }
    ''';

    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    setState(() {
      profileData = json.decode(mockJsonResponse);
    });
  }
  
  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _showDetailedProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return DetailedProfile(userID: widget.userID,selectedApartmentID: widget.selectedApartmentID,);
      },
    );
  }


  void _showAccountSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return AccountSettings(userID: widget.userID,selectedApartmentID: widget.selectedApartmentID,);
      },
    );
  }


  void _showCustomToast(String message, ToastStatus status, {IconData icon = Icons.info}) {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = CustomToastMsg(message: message, icon: icon, status: status);
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  void _logout(BuildContext context) async {
      String? bearer_token = await SharedPreferencesHelper.getValue(SharedPreferencesKeys.bearerTokenKey);
      String? userID = await SharedPreferencesHelper.getValue(SharedPreferencesKeys.userIDKey);
      if (!mounted) return;
      try {
        Map<String, dynamic> payload = {};
        final response = await _authService.logout(payload);
        _showCustomToast(response['message'] ?? 'Login successful', ToastStatus.success, icon: Icons.check_circle);
        if (mounted) {
          if (!mounted) return;
          context.go('/login');
        }
      } catch (e) {
        print('Error: $e');  // Print error to console
        _showCustomToast(e.toString(), ToastStatus.failure, icon: Icons.error);
      }
      
  }


  

  @override
  Widget build(BuildContext context) {
    if(profileData == null) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color:AppColors.primary),
          )
          
        );
    } else {
      return Scaffold(
        body: Column(
            children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () => _showDetailedProfile(context),
                          child: Card(
                            elevation: 4.0,
                              color: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.background,
                                    radius: 30,
                                    child: Text(
                                      (profileData!['name'] ?? 'NA').toString().substring(0, 1),
                                      style: const TextStyle(fontSize: 20.0, color: AppColors.primary),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profileData!['name'] ?? '',
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.background),
                                      ),
                                      Text(
                                        profileData!['email'] ?? '',
                                        style: const TextStyle(color: AppColors.background),
                                      ),
                                      Text(
                                        profileData!['phone'] ?? '',
                                        style: const TextStyle(color: AppColors.background),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ),
                      Divider(color: AppColors.textColor,thickness: 0.2,),
                    ]
                  )
              ),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child:  ListView(
                  children: [
                      SettingOption(
                        icon: Icons.notifications,
                        title: 'Notification settings',
                        onTap: () => _navigateToScreen(context, NotificationSettingsScreen(userID: widget.userID,selectedApartmentID: widget.selectedApartmentID,))
                      ),
                      Divider(color: AppColors.textColor,thickness: 0.2,),
                      SettingOption(
                        icon: Icons.account_circle,
                        title: 'Account settings',
                        onTap: () => _showAccountSettings(context)
                      ),
                      Divider(color: AppColors.textColor,thickness: 0.2,),
                      SettingOption(
                        icon: Icons.privacy_tip,
                        title: 'Privacy settings',
                        onTap: () => _navigateToScreen(context, PrivacySettingsScreen(userID: widget.userID,selectedApartmentID: widget.selectedApartmentID,))
                      ),
                      Divider(color: AppColors.textColor,thickness: 0.2,),
                      SettingOption(
                        icon: Icons.article,
                        title: 'Terms of service',
                        onTap: () => _navigateToScreen(context, TermsOfServiceSettingsScreen(userID: widget.userID,selectedApartmentID: widget.selectedApartmentID,))
                      ),
                      Divider(color: AppColors.textColor,thickness: 0.2,),
                      SettingOption(
                        icon: Icons.policy,
                        title: 'Privacy policy',
                        onTap: () => _navigateToScreen(context, PrivacyPolicySettingsScreen(userID: widget.userID,selectedApartmentID: widget.selectedApartmentID,))
                      ),
                      Divider(color: AppColors.textColor,thickness: 0.2,),
                      SettingOption(
                        icon: Icons.help,
                        title: 'Help and support',
                        onTap: () => _navigateToScreen(context,HelpAndSupportSettingsScreen(userID: widget.userID,selectedApartmentID: widget.selectedApartmentID,))
                      ),
                      Divider(color: AppColors.textColor,thickness: 0.2,),
                      SettingOption(
                        icon: Icons.group_add,
                        title: 'Join another community',
                        onTap: () => _navigateToScreen(context, SearchApartmentScreen(userID: widget.userID,selectedApartmentID: widget.selectedApartmentID,))
                      ),
                      // Divider(color: AppColors.textColor,thickness: 0.2,),
                      // SettingOption(
                      //   icon: Icons.star,
                      //   title: 'Rate us',
                      //   onTap: () => _navigateToScreen(context, NotificationSettingsScreen(userID: widget.userID,selectedApartmentID: widget.selectedApartmentID,))
                      // ),
                      Divider(color: AppColors.textColor,thickness: 0.2,),
                      SettingOption(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: () => _logout,
                      ),
                    ],
                  ),
                )
              ),
            ],
          )
        );
    }
  }
}