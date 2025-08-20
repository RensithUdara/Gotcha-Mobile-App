import 'package:flutter/material.dart';
import 'views/people_screen.dart';

void main() {
  runApp(GotchaApp());
}

class GotchaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gotcha Random Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: PeopleScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
