import 'package:flutter/material.dart';
import '../../colors.dart';

class DashboardFooter extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const DashboardFooter({super.key, 
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DashboardFooterState createState() => _DashboardFooterState();
}

class _DashboardFooterState extends State<DashboardFooter> {
  @override
  Widget build(BuildContext context) {
    return  BottomAppBar(
        color: AppColors.primary,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: widget.selectedIndex == 0 ? AppColors.bottomNavigationButton : Colors.white ,size: widget.selectedIndex == 0 ? 35 : 30,),
              onPressed: () => widget.onItemTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.apartment, color: widget.selectedIndex == 1 ? AppColors.bottomNavigationButton : Colors.white ,size: widget.selectedIndex == 1 ? 35 : 30,),
              onPressed: () => widget.onItemTapped(1),
            ),
            const SizedBox(width: 40), // The gap for the floating action button
            IconButton(
              icon: Icon(Icons.notifications, color: widget.selectedIndex == 2 ? AppColors.bottomNavigationButton : Colors.white ,size: widget.selectedIndex == 2 ? 35 : 30,),
              onPressed: () => widget.onItemTapped(2),
            ),
            IconButton(
              icon: Icon(Icons.person, color: widget.selectedIndex == 3 ? AppColors.bottomNavigationButton : Colors.white ,size: widget.selectedIndex == 3 ? 35 : 35,),
              onPressed: () => widget.onItemTapped(3),
            ),
          ],
        ),
      );
  }
}
