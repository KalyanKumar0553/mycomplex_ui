import 'package:flutter/material.dart';
import '../colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
        title: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'What are you looking for?',
              hintStyle: TextStyle(color: AppColors.onPrimary),
              border: InputBorder.none,
              fillColor: AppColors.primary,
              filled: true
            ),
            style: TextStyle(color: AppColors.onPrimary),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const Text(
              'Recent Searches',
              style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: <Widget>[
                ActionChip(
                  label: const Text('milk'),
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Popular Searches',
              style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.cleaning_services, color: AppColors.primary),
              title: const Text('Daily help'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person_add, color: AppColors.primary),
              title: const Text('Visitor Preapprove'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet, color: AppColors.primary),
              title: const Text('Society Dues'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.message, color: AppColors.primary),
              title: const Text('Message Guard'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.pool, color: AppColors.primary),
              title: const Text('Amenities'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person_add, color: AppColors.primary),
              title: const Text('Guest Preapproval'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.local_taxi, color: AppColors.primary),
              title: const Text('Cab booking'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.airport_shuttle, color: AppColors.primary),
              title: const Text('Airport cabs---(Lower fares)'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
