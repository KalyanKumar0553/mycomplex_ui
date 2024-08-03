import 'package:flutter/material.dart';
import '../../colors.dart';
import 'profile_bio_tab.dart';
import 'contact_details_tab.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> profileData;
  final int initialTabIndex;
  final String userID;
  final String selectedApartmentID;

  const EditProfileScreen({Key? key, required this.profileData, this.initialTabIndex = 0, required this.userID, required this.selectedApartmentID}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController anniversaryController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController govtIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTabIndex);
    nameController.text = widget.profileData['name'] ?? '';
    emailController.text = widget.profileData['email'] ?? '';
    phoneController.text = widget.profileData['phone'] ?? '';
    genderController.text = widget.profileData['gender'] ?? '';
    dobController.text = widget.profileData['dateOfBirth'] ?? 'Not Available';
    anniversaryController.text = widget.profileData['anniversaryDate'] ?? 'Not Available';
    bloodGroupController.text = widget.profileData['bloodGroup'] ?? 'Not Available';
    govtIdController.text = widget.profileData['govtId'] ?? '';
  }

  @override
  void dispose() {
    _tabController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    genderController.dispose();
    dobController.dispose();
    anniversaryController.dispose();
    bloodGroupController.dispose();
    govtIdController.dispose();
    super.dispose();
  }

  void _saveProfileBio() {
    // Save the updated profile bio details
    // Implement the save logic here
    print('Profile Bio Saved');
  }

  void _saveContactDetails() {
    // Save the updated contact details
    // Implement the save logic here
    print('Contact Details Saved');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.background),
        title: const Text('Daily Help', style: TextStyle(color: AppColors.background)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.background,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelColor: AppColors.background,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          tabs: const [
            Tab(text: 'Profile bio'),
            Tab(text: 'Contact details'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ProfileBioTab(
            nameController: nameController,
            genderController: genderController,
            dobController: dobController,
            anniversaryController: anniversaryController,
            bloodGroupController: bloodGroupController,
            govtIdController: govtIdController,
            onSave: _saveProfileBio,
          ),
          ContactDetailsTab(
            emailController: emailController,
            phoneController: phoneController,
            onSave: _saveContactDetails,
          ),
        ],
      ),
    );
  }
}