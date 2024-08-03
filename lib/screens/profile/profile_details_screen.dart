
import 'package:flutter/material.dart';
import 'package:mycomplex_ui/screens/profile/edit_profile_screen.dart';
import '../../colors.dart';
import 'dart:convert'; // For decoding JSON
import 'package:http/http.dart' as http;

class DetailedProfile extends StatefulWidget {
  final String userID;
  final String selectedApartmentID;

  const DetailedProfile({Key? key, required this.userID,required this.selectedApartmentID}) : super(key: key);

  @override
  _DetailedProfileState createState() => _DetailedProfileState();
}

class _DetailedProfileState extends State<DetailedProfile> {

  Map<String, dynamic>? profileData;

  @override
  void initState() {
    super.initState();
    // _fetchProfileData();
    _fetchProfileMockData();
  }

  Future<void> _fetchProfileMockData() async {
    // Mock JSON response
    final mockJsonResponse = '''
    {
      "name": "Test User",
      "email": "test@user.com",
      "phone": "+91 - 1234567890",
      "dateOfBirth": "Not Available",
      "bloodGroup": "Not Available",
      "unitNumber": "3 - 3021",
      "unitStatus": "Resident",
      "pin": "500984",
      "userType": "Tenant"
    }
    ''';

    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Decode the JSON response
    setState(() {
      profileData = json.decode(mockJsonResponse);
    });
  }

  Future<void> _fetchProfileData() async {
    // Mock API call with userID
    final response = await http.get(Uri.parse('https://your-api-endpoint.com/profile/${widget.userID}'));

    if (response.statusCode == 200) {
      setState(() {
        profileData = json.decode(response.body);
      });
    } else {
      // Handle error
      print('Failed to load profile data');
    }
  }

  void _editProfile(int tabIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          profileData: profileData ?? {},
          initialTabIndex: tabIndex,
          userID: widget.userID,
          selectedApartmentID: widget.selectedApartmentID,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 30,
              child: Text(
                (profileData?['name'] ?? 'N/A').toString().substring(0, 1),
                style: const TextStyle(fontSize: 20.0, color: AppColors.background),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              profileData?['name'] ?? 'N/A',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textColor),
            ),
            Text(
              'PIN : '+ (profileData?['pin'] ?? 'N/A'),
              style: TextStyle(color: AppColors.primary),
            ),
            Text(
              (profileData?['userType']??'') + ' ' + (profileData?['unitStatus']??'')  + ' ' + (profileData?['unitNumber']??''),
              style: TextStyle(color: AppColors.textColor),
            ),
            const SizedBox(height: 8),
            Divider(color: AppColors.textColor,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Profile Bio',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor),),
                const SizedBox(width: 8),
                IconButton(
                      icon: const Icon(Icons.edit, color: AppColors.primary),
                      onPressed: () {
                        _editProfile(0);
                      },
                ),   
              ]
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Date of Birth:'),
                Row(
                  children: [
                    Text(
                      profileData?['dateOfBirth'] ?? 'N/A',
                      style: const TextStyle(color: AppColors.textColor)
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Blood Group:'),
                Text(
                  profileData?['bloodGroup'] ?? 'N/A',
                  style: const TextStyle(color: AppColors.textColor
                )),
              ],
            ),
            const SizedBox(height: 8),
            Divider(color: AppColors.textColor,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Contact Details',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor),),
                const SizedBox(width: 8),
                IconButton(
                      icon: const Icon(Icons.edit, color: AppColors.primary),
                      onPressed: () {
                        _editProfile(1);
                      },
                ),   
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Phone Number:'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.phone, color: AppColors.success,),
                      onPressed: () {
                        // Implement call functionality
                      },
                    ),
                    Text(
                      profileData?['phone'] ?? 'N/A', 
                      style: const TextStyle(color: AppColors.textColor)
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Email ID:'),
                Text(
                  profileData?['email'] ?? 'N/A',
                  style: const TextStyle(color: AppColors.textColor)
                ),
              ],
            ),
            const SizedBox(height: 8),
            Divider(color: AppColors.textColor,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Unit Number',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor),),
                const SizedBox(width: 8),
                TextButton(
                      child: const Text('Update status', style: TextStyle(color: AppColors.primary)),
                      onPressed: () {
                        // Implement call functionality
                      },
                ),   
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  profileData?['unitNumber'] ?? 'N/A',
                  style: TextStyle(color: AppColors.textColor)
                ),
                const SizedBox(width: 8),
                Text(
                  profileData?['unitStatus'] ?? 'N/A',
                  style: TextStyle(color: AppColors.textColor)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
