import 'package:flutter/material.dart';

class AppSettings {
  // Theme settings
  ColorTheme selectedTheme;
  bool isDarkMode;
  
  // Vibration and feedback settings
  bool enableVibration;
  bool enableHapticFeedback;
  VibrationIntensity vibrationIntensity;
  
  // Game settings
  int maxParticipants;
  double fingerSize;
  bool enableSoundEffects;
  AnimationSpeed animationSpeed;
  
  // UI settings
  bool showParticipantNumbers;
  bool showInstructions;
  bool enableBackgroundAnimation;
  
  AppSettings({
    this.selectedTheme = ColorTheme.purple,
    this.isDarkMode = false,
    this.enableVibration = true,
    this.enableHapticFeedback = true,
    this.vibrationIntensity = VibrationIntensity.medium,
    this.maxParticipants = 6,
    this.fingerSize = 90.0,
    this.enableSoundEffects = false,
    this.animationSpeed = AnimationSpeed.normal,
    this.showParticipantNumbers = true,
    this.showInstructions = true,
    this.enableBackgroundAnimation = true,
  });

  // Copy with method for immutable updates
  AppSettings copyWith({
    ColorTheme? selectedTheme,
    bool? isDarkMode,
    bool? enableVibration,
    bool? enableHapticFeedback,
    VibrationIntensity? vibrationIntensity,
    int? maxParticipants,
    double? fingerSize,
    bool? enableSoundEffects,
    AnimationSpeed? animationSpeed,
    bool? showParticipantNumbers,
    bool? showInstructions,
    bool? enableBackgroundAnimation,
  }) {
    return AppSettings(
      selectedTheme: selectedTheme ?? this.selectedTheme,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      enableVibration: enableVibration ?? this.enableVibration,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
      vibrationIntensity: vibrationIntensity ?? this.vibrationIntensity,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      fingerSize: fingerSize ?? this.fingerSize,
      enableSoundEffects: enableSoundEffects ?? this.enableSoundEffects,
      animationSpeed: animationSpeed ?? this.animationSpeed,
      showParticipantNumbers: showParticipantNumbers ?? this.showParticipantNumbers,
      showInstructions: showInstructions ?? this.showInstructions,
      enableBackgroundAnimation: enableBackgroundAnimation ?? this.enableBackgroundAnimation,
    );
  }
}

enum ColorTheme {
  purple,
  blue,
  green,
  orange,
  pink,
  teal,
  red,
  custom,
}

enum VibrationIntensity {
  light,
  medium,
  strong,
}

enum AnimationSpeed {
  slow,
  normal,
  fast,
}

class ThemeColors {
  final List<Color> gradientColors;
  final List<Color> fingerColors;
  final Color primaryColor;
  final Color accentColor;
  final String name;

  const ThemeColors({
    required this.gradientColors,
    required this.fingerColors,
    required this.primaryColor,
    required this.accentColor,
    required this.name,
  });

  static const Map<ColorTheme, ThemeColors> themes = {
    ColorTheme.purple: ThemeColors(
      name: 'Purple Dream',
      gradientColors: [Color(0xFF667eea), Color(0xFF764ba2), Color(0xFFf093fb)],
      fingerColors: [
        Color(0xFF6366F1), Color(0xFFEC4899), Color(0xFF10B981),
        Color(0xFFF59E0B), Color(0xFF8B5CF6), Color(0xFF06B6D4),
      ],
      primaryColor: Color(0xFF667eea),
      accentColor: Color(0xFFf093fb),
    ),
    ColorTheme.blue: ThemeColors(
      name: 'Ocean Blue',
      gradientColors: [Color(0xFF1e3c72), Color(0xFF2a5298), Color(0xFF74b9ff)],
      fingerColors: [
        Color(0xFF0984e3), Color(0xFF6c5ce7), Color(0xFF00b894),
        Color(0xFFfdcb6e), Color(0xFFe17055), Color(0xFFfd79a8),
      ],
      primaryColor: Color(0xFF1e3c72),
      accentColor: Color(0xFF74b9ff),
    ),
    ColorTheme.green: ThemeColors(
      name: 'Nature Green',
      gradientColors: [Color(0xFF11998e), Color(0xFF38ef7d), Color(0xFF56ab2f)],
      fingerColors: [
        Color(0xFF00b894), Color(0xFF00cec9), Color(0xFF55a3ff),
        Color(0xFFffeaa7), Color(0xFFfd79a8), Color(0xFFe17055),
      ],
      primaryColor: Color(0xFF11998e),
      accentColor: Color(0xFF56ab2f),
    ),
    ColorTheme.orange: ThemeColors(
      name: 'Sunset Orange',
      gradientColors: [Color(0xFFf7971e), Color(0xFFffd200), Color(0xFFff6b6b)],
      fingerColors: [
        Color(0xFFe17055), Color(0xFFfdcb6e), Color(0xFFfd79a8),
        Color(0xFF6c5ce7), Color(0xFF0984e3), Color(0xFF00b894),
      ],
      primaryColor: Color(0xFFf7971e),
      accentColor: Color(0xFFff6b6b),
    ),
    ColorTheme.pink: ThemeColors(
      name: 'Pink Paradise',
      gradientColors: [Color(0xFFf093fb), Color(0xFFf5576c), Color(0xFFffecd2)],
      fingerColors: [
        Color(0xFFfd79a8), Color(0xFFe84393), Color(0xFF6c5ce7),
        Color(0xFF74b9ff), Color(0xFF0984e3), Color(0xFF00cec9),
      ],
      primaryColor: Color(0xFFf093fb),
      accentColor: Color(0xFFf5576c),
    ),
    ColorTheme.teal: ThemeColors(
      name: 'Teal Waves',
      gradientColors: [Color(0xFF00cec9), Color(0xFF55efc4), Color(0xFF81ecec)],
      fingerColors: [
        Color(0xFF00b894), Color(0xFF00cec9), Color(0xFF74b9ff),
        Color(0xFF0984e3), Color(0xFF6c5ce7), Color(0xFFfd79a8),
      ],
      primaryColor: Color(0xFF00cec9),
      accentColor: Color(0xFF55efc4),
    ),
    ColorTheme.red: ThemeColors(
      name: 'Fire Red',
      gradientColors: [Color(0xFFeb3349), Color(0xFFf45c43), Color(0xFFff8a80)],
      fingerColors: [
        Color(0xFFe17055), Color(0xFFd63031), Color(0xFFfd79a8),
        Color(0xFFfdcb6e), Color(0xFF74b9ff), Color(0xFF00b894),
      ],
      primaryColor: Color(0xFFeb3349),
      accentColor: Color(0xFFf45c43),
    ),
  };
}
