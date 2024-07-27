import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../helper/shared_preferences_helper.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required String token});

  @override
  Widget build(BuildContext context) {
    final String token = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await SharedPreferencesHelper.removeBearerToken();
              // ignore: use_build_context_synchronously
              context.go('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome, your token is: $token'),
      ),
    );
  }
}
