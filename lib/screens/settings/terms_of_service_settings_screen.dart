import 'package:flutter/material.dart';
import 'package:mycomplex_ui/colors.dart';
import 'package:mycomplex_ui/widgets/mobile_html_content_view.dart';
import 'package:mycomplex_ui/widgets/web_html_content_view.dart';

class TermsOfServiceSettingsScreen extends StatefulWidget {
  final String selectedApartmentID;
  final String userID;

  const TermsOfServiceSettingsScreen({
    Key? key,
    required this.userID,
    required this.selectedApartmentID,
  }) : super(key: key);

@override
  _TermsOfServiceSettingsScreenState createState() => _TermsOfServiceSettingsScreenState();
}

class _TermsOfServiceSettingsScreenState extends State<TermsOfServiceSettingsScreen> {

  String urlToDisplay = "https://www.apnacomplex.com/terms-of-service";

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
        // body: MobileHtmlContentView(urlToDisplay:urlToDisplay)
        body: WebHtmlContentView(urlToDisplay:urlToDisplay)
     );
  }
}