
import 'package:flutter/material.dart';
import 'package:mycomplex_ui/screens/settings/account/change_password_screen.dart';
import 'package:mycomplex_ui/screens/settings/account/delete_account.dart';
import '../../colors.dart';
import 'dart:convert'; // For decoding JSON
import 'package:http/http.dart' as http;

class AccountSettings extends StatefulWidget {
  final String userID;
  final String selectedApartmentID;

  const AccountSettings({Key? key, required this.userID,required this.selectedApartmentID}) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {

  Map<String, dynamic>? profileData;

  @override
  void initState() {
    super.initState();
  }

  void _showChangePasswordScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(userID: widget.userID,selectedApartmentID: widget.selectedApartmentID),
    ));
  }


  void _showDeleteAccountScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DeleteAccountDialog();
      },
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
            Align(
                alignment: Alignment.center,
                child: const Text('Account Settings', style: TextStyle(fontSize: 15.4, color: AppColors.primary,),textAlign:TextAlign.justify,),
            ),
            // Divider(color: AppColors.textColor,),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.inputBorderColor)
              ),
              child: GestureDetector(
                onTap: () => _showChangePasswordScreen(context),
                child: ListTile(
                  leading: Icon(Icons.lock, color: AppColors.textColor),
                  title: Text('Change password', style: TextStyle(color: AppColors.textColor)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.inputBorderColor)
              ),
              child: GestureDetector(
                onTap: () => _showDeleteAccountScreen(context),
                child: ListTile(
                  leading: Icon(Icons.delete, color: AppColors.textColor),
                  title: Text('Delete Account', style: TextStyle(color: AppColors.textColor)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
