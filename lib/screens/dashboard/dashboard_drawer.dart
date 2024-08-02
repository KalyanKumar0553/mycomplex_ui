import 'package:flutter/material.dart';
import '../../colors.dart';

class DashboardDrawer extends StatefulWidget {
  final String selectedApartmentID;
  final List<Map<String, String>> apartments;
  final ValueChanged<String?> onApartmentChanged;
  final ValueChanged<int> onItemTapped;

  const DashboardDrawer({super.key, 
    required this.selectedApartmentID,
    required this.apartments,
    required this.onApartmentChanged,
    required this.onItemTapped,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DashboardDrawerState createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('Demo User'),
            accountEmail: Text('something@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.background,
              child: Text(
                "AV",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
          ),
          // ListTile(
          //   leading: const Icon(Icons.lightbulb_outline),
          //   title: const Text('Notes'),
          //   onTap: () => widget.onItemTapped(0),
          // ),
          // const Divider(),
          // ListTile(
          //   title: const Text('Expense'),
          //   leading: const Icon(Icons.label_outline),
          //   onTap: () => widget.onItemTapped(1),
          // ),
          // ListTile(
          //   title: const Text('Inspiration'),
          //   leading: const Icon(Icons.label_outline),
          //   onTap: () => widget.onItemTapped(2),
          // ),
          // ListTile(
          //   title: const Text('Personal'),
          //   leading: const Icon(Icons.label_outline),
          //   onTap: () => widget.onItemTapped(3),
          // ),
          // ListTile(
          //   title: const Text('Work'),
          //   leading: const Icon(Icons.label_outline),
          //   onTap: () => widget.onItemTapped(4),
          // ),
          // ListTile(
          //   title: const Text('Create new label'),
          //   leading: const Icon(Icons.add),
          //   onTap: () => widget.onItemTapped(5),
          // ),
          // const Divider(),
          // ListTile(
          //   title: const Text('Archive'),
          //   leading: const Icon(Icons.archive),
          //   onTap: () => widget.onItemTapped(6),
          // ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () => widget.onItemTapped(7),
          ),
        ],
      ),
    );
  }
}