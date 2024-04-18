import 'package:doodleblue/utils/constants.dart';
import 'package:doodleblue/viewmodels/business_view_model.dart';
import 'package:doodleblue/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(  ChangeNotifierProvider(
    create: (context) => BusinessViewModel(),
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: AppStrings.appTitle,
      home: SplashScreen(),
    );
  }
}