import 'package:flutter/material.dart';
import 'package:mycomplex_ui/screens/daily_help/add_daily_help.dart';
import 'package:mycomplex_ui/screens/daily_help/attendance_history_screen.dart';
import 'package:mycomplex_ui/widgets/rating_bar.dart';
import '../../colors.dart';

class MaidProfileScreen extends StatelessWidget {
  final Map<String, dynamic> maidDetails;
  final String selectedApartmentID;

  void _showAddDailyHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddDailyHelpDialog();
      },
    );
  }

  const MaidProfileScreen({super.key, required this.maidDetails, required this.selectedApartmentID});

  @override
  Widget build(BuildContext context) {

    double averageRating = 3.6;
    int totalRatings = 10;
    List<int> ratingCounts = [5, 1, 1, 1, 2];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
        title: const Text('Maid Profile', style: TextStyle(color: AppColors.onPrimary)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                          maidDetails['imageUrl']!="" ? CircleAvatar(
                                      backgroundImage: NetworkImage(maidDetails['imageUrl']),
                                      radius: 30,
                                    ) : CircleAvatar(
                                      backgroundColor: AppColors.primary,
                                      radius: 30,
                                      child: Text(
                                        maidDetails['name'].toString().substring(0,2),
                                        style: const TextStyle(fontSize: 20.0,color: AppColors.onPrimary),
                                      ),
                                    ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maidDetails['name'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:AppColors.textColor),
                          ),
                          Text(
                            maidDetails['phone'],
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.phone, color: Colors.green),
                                onPressed: () {
                                  // Implement call functionality
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.share,color:AppColors.textColor),
                                onPressed: () {
                                  // Implement share functionality
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4.0,
                child: ListTile(
                  leading: const Icon(Icons.event_available, color: AppColors.textColor,),
                  title: const Row(
                    children: [
                      Text('Attendance', style: TextStyle(color:AppColors.textColor)),
                      Icon(Icons.navigate_next, color: AppColors.textColor,),
                    ],
                  ),
                  subtitle: const Text('Last checked in 1 month ago', style: TextStyle(color:AppColors.textColor)),
                  trailing: const Text('06/30', style: TextStyle(color:AppColors.textColor)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendanceHistoryScreen(
                          maidDetails: maidDetails,
                          selectedApartmentID: selectedApartmentID
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RatingBar(
                    averageRating: averageRating,
                    totalRatings: totalRatings,
                    ratingCounts: ratingCounts,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Card(
                elevation: 4.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time,color:AppColors.textColor),
                          SizedBox(width: 8),
                          Text('Free Time Slots', style: TextStyle(color:AppColors.textColor,fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text('9-10 am'),
                      Text('5-6 pm'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Card(
                elevation: 4.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.home,color:AppColors.textColor),
                          SizedBox(width: 8),
                          Text('Works in 1 House', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color:AppColors.textColor)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text('Working in your society for 1 year', style: TextStyle(color:AppColors.textColor,)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.green),
                          SizedBox(width: 8),
                          Text('Block-B 1004',style: TextStyle(color:AppColors.textColor)),
                          Spacer(),
                          Text('For 7 Months', style: TextStyle(color:AppColors.textColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _showAddDailyHelpDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('+ Add to Household'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
