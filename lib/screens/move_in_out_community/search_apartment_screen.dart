import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mycomplex_ui/colors.dart';
import 'package:mycomplex_ui/screens/move_in_out_community/move_in_screen.dart';
import 'package:mycomplex_ui/widgets/custom_text_field.dart';
import 'package:mycomplex_ui/widgets/custom_toast_msg.dart';

// Replace this with your actual API endpoint
const String apiUrl = "https://your-api-endpoint.com/apartments";

class SearchApartmentScreen extends StatefulWidget {

  final String selectedApartmentID;
  final String userID;

  const SearchApartmentScreen({super.key, required this.selectedApartmentID, required this.userID});

  @override
  _SearchApartmentScreenState createState() => _SearchApartmentScreenState();
}

class _SearchApartmentScreenState extends State<SearchApartmentScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _apartments = [];
  List<dynamic> _filteredApartments = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
        String searchText = _searchController.text;
        _filterApartments(searchText);
    });
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

  void _filterApartments(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredApartments = [];
      });
    } else if(query.length<3) {
      // _showCustomToast("Please enter atlease three characters to search",ToastStatus.warning);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        _apartments = [
          {
            "id": '1',
            "name": "1000 Pillars Shree Apartment",
            "address": "New Cyberabad, Hyderabad",
            "image_url": "https://example.com/images/1000_pillars_apartment.jpg"
          },
          {
              "id": '2',
              "name": "12 Square Apartment Owners Association",
              "address": "Banjara Hills, Hyderabad",
              "image_url": "https://example.com/images/12_square_apartment.jpg"
          },
          {
              "id": '3',
              "name": "7 Star Apartment",
              "address": "#33, 1st street, SM garden, Hyderabad",
              "image_url": "https://example.com/images/7_star_apartment.jpg"
          },
          {
              "id": '4',
              "name": "9th Avenue Apartment",
              "address": "Bank Avenue Colony, Hyderabad",
              "image_url": "https://example.com/images/9th_avenue_apartment.jpg"
          },
          {
              "id": '5',
              "name": "A.V. Bhat Etasha Apartment",
              "address": "Near Sanskrit College, Hyderabad",
              "image_url": "https://example.com/images/av_bhat_etasha_apartment.jpg"
          },
          {
              "id": '6',
              "name": "Aadarsh Apartments",
              "address": "Poonamallee High Road, Hyderabad",
              "image_url": "https://example.com/images/aadarsh_apartments.jpg"
          },
          {
              "id": '7',
              "name": "Aakash Apartment",
              "address": "Vakola, Santacruz East, Hyderabad",
              "image_url": "https://example.com/images/aakash_apartment.jpg"
          },
          {
              "id": '8',
              "name": "Aakruthi Serenity Apartment",
              "address": "Chettipunyam, Hyderabad",
              "image_url": "https://example.com/images/aakruthi_serenity_apartment.jpg"
          }
        ];
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
      setState(() {
        _filteredApartments = _apartments
            .where((apartment) =>
                apartment['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  String? searchKeyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length<=3) {
      return 'Please enter atlease 3 characters to search';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.background),
        title: Text('Join Another Community', style: const TextStyle(color: AppColors.background, overflow: TextOverflow.ellipsis)),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
                labelText: 'Search for Community',
                controller: _searchController,
                inputType: TextInputType.text,
                validator: searchKeyValidator,
                prefixIcon: const Icon(Icons.apartment),
            ),
            SizedBox(height: 16),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _filteredApartments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.apartment),
                          title: Text(
                            _filteredApartments[index]['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            _filteredApartments[index]['address'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MoveInScreen(
                                  userID: widget.userID,
                                  selectedMoveInApartmentID: _filteredApartments[index]['id'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
