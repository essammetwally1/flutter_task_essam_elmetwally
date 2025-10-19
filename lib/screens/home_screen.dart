import 'package:flutter/material.dart';
import 'package:flutter_task_essam_elmetwally/components/custom_elevated_button.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomElevatedButton(
          textElevatedButton: 'شاهد 10,000+ نتائج',
          onPressed: () {},
        ),
      ),
    );
  }
}
