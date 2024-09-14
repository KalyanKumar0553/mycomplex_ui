import 'package:flutter/material.dart';
import 'package:mycomplex_ui/colors.dart';
import 'package:mycomplex_ui/widgets/mobile_html_content_view.dart';

class HelpAndSupportSettingsScreen extends StatefulWidget {
  final String selectedApartmentID;
  final String userID;

  const HelpAndSupportSettingsScreen({
    Key? key,
    required this.userID,
    required this.selectedApartmentID,
  }) : super(key: key);

@override
  _HelpAndSupportSettingsScreenState createState() => _HelpAndSupportSettingsScreenState();
}

class _HelpAndSupportSettingsScreenState extends State<HelpAndSupportSettingsScreen> {

  String urlToDisplay = "https://help.apnacomplex.com/";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: AppColors.background),
          title: const Text('Terms of Service', style: TextStyle(color: AppColors.background)),
          actions: [
            IconButton(
              icon: const Icon(Icons.home, color: AppColors.background),
              padding: EdgeInsets.only(right: 10),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: MobileHtmlContentView(urlToDisplay:urlToDisplay)
        // body: WebHtmlContentView(urlToDisplay:urlToDisplay)
     );
  }
}