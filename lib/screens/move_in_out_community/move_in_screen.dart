import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mycomplex_ui/colors.dart';

// Replace with your API URL
const String apiUrl = "https://your-api-endpoint.com/submit-details";

class MoveInScreen extends StatefulWidget {
  final String selectedMoveInApartmentID;
  final String userID;

  MoveInScreen({required this.selectedMoveInApartmentID, required this.userID});

  @override
  _MoveInScreenState createState() => _MoveInScreenState();
}

class _MoveInScreenState extends State<MoveInScreen> {

  String? _selectedBlock;
  String? _selectedUnit;
  String? _selectedMemberType;
  String? _selectedResidingStatus;
  String? _imageUrl;
  Map<String,dynamic>? apartmentData;
  bool _isLoading = true;


  @override
 void initState() {
   super.initState();
   // _fetchProfileData();
   _fetchApartmentDetails();
 }

 Future<void> _fetchApartmentDetails() async {
   try {
    setState(() {
       _isLoading = true;
     });
    await Future.delayed(const Duration(seconds: 2));
    final mockJsonResponse = '''
    {
      "name": "Test User",
      "url":"https://lh3.googleusercontent.com/p/AF1QipPuwEvEX4UBWR5aluFCkfOFxk9YS6ppihIl3n3H=s1360-w1360-h1020",
      "address":"Kokapet-Sez"
    }
    ''';
    Map<String,dynamic> localApartmentData = json.decode(mockJsonResponse);
    print(localApartmentData);
    setState(() {
      apartmentData = localApartmentData;
      _imageUrl = apartmentData?['url'] ?? null;
    });
   //   final response = await http.get(Uri.parse(apiUrl));
   //   if (response.statusCode == 200) {
   //     setState(() {
   //       _apartments = json.decode(response.body);
   //       _filteredApartments = _apartments;
   //     });
   //   } else {
   //     throw Exception("Failed to load apartments");
   //   }
   } catch (e) {
     print(e);
   } finally {
     setState(() {
       _isLoading = false;
     });
   }
 }

 Future<void> _submitDetails() async {
  
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.background),
        title: Text(' Move In Request', style: const TextStyle(color: AppColors.background, overflow: TextOverflow.ellipsis)),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: AppColors.background),
            padding: EdgeInsets.only(right: 10),
            onPressed: () {
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 3);
            },
          ),
        ],
      ),
      body: _isLoading ? 
              SingleChildScrollView(
                child: Center(child: CircularProgressIndicator(color: AppColors.primary,),)) 
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        _imageUrl!=null ? Image.network(
                            _imageUrl!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                        ) : Container(
                            height: 200,
                            width: double.infinity,
                            color: AppColors.calendarBGColor,
                            child: Center(child: Text('No Image Available'))            
                        ),
                        Divider(color: AppColors.borderColor,),
                        Text(
                          apartmentData?['name'] ?? 'N/A',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                          ),
                        ),
                        Text(
                          apartmentData?['address'] ?? 'N/A',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textColor,
                          ),
                        ),
                        Divider(color: AppColors.borderColor,),
                        SizedBox(height: 16),
                        _buildDropdown(
                          label: "Block Name",
                          value: _selectedBlock,
                          items: ["Block A", "Block B", "Block C"],
                          onChanged: (value) {
                            setState(() {
                              _selectedBlock = value;
                            });
                          },
                        ),
                        _buildDropdown(
                          label: "Unit Number",
                          value: _selectedUnit,
                          items: ["Unit 101", "Unit 102", "Unit 103"],
                          onChanged: (value) {
                            setState(() {
                              _selectedUnit = value;
                            });
                          },
                        ),
                        _buildDropdown(
                          label: "Member type",
                          value: _selectedMemberType,
                          items: ["Owner", "Tenant"],
                          onChanged: (value) {
                            setState(() {
                              _selectedMemberType = value;
                            });
                          },
                        ),
                        _buildDropdown(
                          label: "Residing status",
                          value: _selectedResidingStatus,
                          items: ["Resident", "Non-Resident"],
                          onChanged: (value) {
                            setState(() {
                              _selectedResidingStatus = value;
                            });
                          },
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitDetails,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text("Next"),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
        );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
          dropdownColor: AppColors.background,
          value: value,
          decoration: InputDecoration(
              filled: true,
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
              labelText: label,
            ),
            items: items.map((String currItem) {
                        return DropdownMenuItem<String>(
                          value: currItem,
                          child: Container(
                            child: Text(
                              selectionColor: AppColors.textColor,
                              currItem,
                              style: const TextStyle(color: AppColors.textColor),
                            ),
                          ),
                        );
                    }).toList(),
                    onChanged: onChanged
        )
    );
  }
}
