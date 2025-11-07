import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/colors/darkTheme.dart';
import 'package:todo_app_provider/colors/lightTheme.dart';
import 'package:todo_app_provider/view%20model/darklight_mode_provider.dart';
import 'package:todo_app_provider/view%20model/todo_view_model.dart';
import 'package:todo_app_provider/view/home_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoViewModel()),
        ChangeNotifierProvider(create: (_) => DarklightModeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarklightModeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.currentTheme,
      theme: lightTheme,
      darkTheme: darkTheme,

      home: const HomeView(),
    );
  }
}
