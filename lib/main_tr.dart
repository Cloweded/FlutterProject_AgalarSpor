import 'package:agalarspor/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'welcome_screen.dart';



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, theme, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AGALARSTORE',
        theme: theme.theme,
        home: WelcomeScreen(),
      ),
    );
  }
}
