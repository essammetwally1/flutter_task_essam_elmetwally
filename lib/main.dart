// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_task_essam_elmetwally/app_theme.dart';
import 'package:flutter_task_essam_elmetwally/providers/product_provider.dart';
import 'package:flutter_task_essam_elmetwally/screens/home_screen.dart';

void main() {
  runApp(const FlutterTask());
}

class FlutterTask extends StatelessWidget {
  const FlutterTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider()
            ..clearAllProducts()
            ..loadProducts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.routeName,
        routes: {HomeScreen.routeName: (context) => HomeScreen()},
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.dartTheme,
      ),
    );
  }
}
