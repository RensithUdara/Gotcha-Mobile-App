class AppConfig {
  static const String appName = 'Gotcha Random Picker';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'A beautiful random picker app for groups';
  
  // App constraints
  static const int maxParticipants = 6;
  static const int minParticipants = 2;
  static const double minFingerDistance = 60.0;
  
  // Animation durations (milliseconds)
  static const int selectionAnimationDuration = 400;
  static const int pulseAnimationDuration = 1500;
  static const int backgroundAnimationDuration = 20000;
  static const int buttonPressAnimationDuration = 150;
  
  // Vibration settings
  static const int defaultVibrationDuration = 500;
  static const int lightVibrationDuration = 100;
  static const int mediumVibrationDuration = 200;
  
  // UI constants
  static const double fingerSize = 90.0;
  static const double winnerFingerSize = 100.0;
  static const double borderRadius = 20.0;
  static const double cardElevation = 8.0;
  
  // Colors (hex values)
  static const int primaryColor = 0xFF667eea;
  static const int secondaryColor = 0xFF764ba2;
  static const int accentColor = 0xFFf093fb;
  
  // Feature flags
  static const bool enableHapticFeedback = true;
  static const bool enableVibration = true;
  static const bool enableBackgroundAnimation = true;
  static const bool enablePulseAnimation = true;
}
