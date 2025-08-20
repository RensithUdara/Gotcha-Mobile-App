import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/people_screen.dart';
import 'controllers/settings_controller.dart';

void main() {
  runApp(GotchaApp());
}

class GotchaApp extends StatelessWidget {
  final SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (context, child) {
        return MaterialApp(
          title: 'Gotcha Random Picker',
          theme: ThemeData(
            primaryColor: settingsController.primaryColor,
            brightness: Brightness.light,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Arial',
            appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              elevation: 8,
              backgroundColor: settingsController.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
          home: PeopleScreen(settingsController: settingsController),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
