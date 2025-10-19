import 'package:flutter/material.dart';
import 'package:flutter_task_essam_elmetwally/screens/home_screen.dart';

void main() {
  runApp(FlutterTask());
}

class FlutterTask extends StatelessWidget {
  const FlutterTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {HomeScreen.routeName: (context) => HomeScreen()},
    );
  }
}
