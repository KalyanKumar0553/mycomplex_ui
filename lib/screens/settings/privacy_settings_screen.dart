import 'package:flutter/material.dart';
import 'package:mycomplex_ui/colors.dart';

class PrivacySettingsScreen extends StatefulWidget {
  final String selectedApartmentID;
  final String userID;

  const PrivacySettingsScreen({
    Key? key,
    required this.userID,
    required this.selectedApartmentID,
  }) : super(key: key);

@override
  _PrivacySettingsScreenState createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {

  bool _phoneNumberPrivate = true;
  bool _emailIDPrivate = true;
  bool _allowInAppCalling = true;

  String? _selectedDOBVisibility = 'Me';
  String? _selectedAniversaryVisibility = 'Me';
  String? _selectedBloodGroupVisibility = 'Me';
  String? _selectedGenderVisibility = 'Me';
  

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
          title: const Text('Privacy Settings', style: TextStyle(color: AppColors.background)),
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
        body: SingleChildScrollView(
          child: Container(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 24, bottom: 12),
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: AppColors.primary))
                  ),
                  child: Column(
                    children: [
                       Container(
                          padding: EdgeInsets.only(left: 14, right:14),
                          child: DropdownButtonFormField<String>(
                            icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                            dropdownColor: AppColors.background,
                            value: _selectedGenderVisibility,
                            decoration: InputDecoration(
                              // labelStyle: const TextStyle(color: AppColors.inputLabelColor),
                              filled: true,
                              // fillColor: AppColors.inputFillColor,
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Gender visible to',
                            ),
                            items: ['Me','Everyone'].map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Container(
                                  child: Text(
                                    selectionColor: AppColors.textColor,
                                    option,
                                    style: const TextStyle(color: AppColors.textColor),
                                  ),
                                ),
                                // child: Text(duration,style: TextStyle(color:AppColors.textColor),)
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedGenderVisibility = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16,),
                        Container(
                          padding: EdgeInsets.only(left: 14, right:14),
                          child: DropdownButtonFormField<String>(
                            icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                            dropdownColor: AppColors.background,
                            value: _selectedDOBVisibility,
                            decoration: InputDecoration(
                              // labelStyle: const TextStyle(color: AppColors.inputLabelColor),
                              filled: true,
                              // fillColor: AppColors.inputFillColor,
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Date of birth visible to',
                            ),
                            items: ['Me','Everyone'].map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Container(
                                  child: Text(
                                    selectionColor: AppColors.textColor,
                                    option,
                                    style: const TextStyle(color: AppColors.textColor),
                                  ),
                                ),
                                // child: Text(duration,style: TextStyle(color:AppColors.textColor),)
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDOBVisibility = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16,),
                        Container(
                          padding: EdgeInsets.only(left: 14, right:14),
                          child: DropdownButtonFormField<String>(
                            icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                            dropdownColor: AppColors.background,
                            value: _selectedAniversaryVisibility,
                            decoration: InputDecoration(
                              // labelStyle: const TextStyle(color: AppColors.inputLabelColor),
                              filled: true,
                              // fillColor: AppColors.inputFillColor,
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Anniversary visible to',
                            ),
                            items: ['Me','Everyone'].map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Container(
                                  child: Text(
                                    selectionColor: AppColors.textColor,
                                    option,
                                    style: const TextStyle(color: AppColors.textColor),
                                  ),
                                ),
                                // child: Text(duration,style: TextStyle(color:AppColors.textColor),)
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedAniversaryVisibility = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16,),
                        Container(
                          padding: EdgeInsets.only(left: 14, right:14),
                          child: DropdownButtonFormField<String>(
                            icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                            dropdownColor: AppColors.background,
                            value: _selectedBloodGroupVisibility,
                            decoration: InputDecoration(
                              // labelStyle: const TextStyle(color: AppColors.inputLabelColor),
                              filled: true,
                              // fillColor: AppColors.inputFillColor,
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Blood group visible to',
                            ),
                            items: ['Me','Everyone'].map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Container(
                                  child: Text(
                                    selectionColor: AppColors.textColor,
                                    option,
                                    style: const TextStyle(color: AppColors.textColor),
                                  ),
                                ),
                                // child: Text(duration,style: TextStyle(color:AppColors.textColor),)
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedBloodGroupVisibility = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16,),
                        _buildSwitchTile(
                          title: 'Keep phone number private ?',
                          value: _phoneNumberPrivate,
                          onChanged: (bool value) {
                            setState(() {
                              _phoneNumberPrivate = value;
                            });
                          },
                        ),
                        _buildSwitchTile(
                          title: 'Keep email ID private ?',
                          value: _emailIDPrivate,
                          onChanged: (bool value) {
                            setState(() {
                              _emailIDPrivate = value;
                            });
                          },
                        ),
                        _buildSwitchTile(
                          title: 'Allow in-app calling ?',
                          value: _allowInAppCalling,
                          onChanged: (bool value) {
                            setState(() {
                              _allowInAppCalling = value;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                              
                          },
                          style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Done', style: TextStyle(color: AppColors.background)),
                        ),
                        SizedBox(height: 16),
                    ]
                  )
                ),
          )
      );
  }

    Widget _buildSwitchTile({required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return Transform.scale(
          scale: 1,
          child: SwitchListTile(
            title: Text(title, style: TextStyle(color: AppColors.textColor)),
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          )
      );
  }
}