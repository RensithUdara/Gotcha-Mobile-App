import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import '../utils/app_utils.dart';

class SettingsController extends ChangeNotifier {
  AppSettings _settings = AppSettings();
  
  AppSettings get settings => _settings;
  
  // Theme getters
  ThemeColors get currentTheme => ThemeColors.themes[_settings.selectedTheme]!;
  List<Color> get gradientColors => currentTheme.gradientColors;
  List<Color> get fingerColors => currentTheme.fingerColors;
  Color get primaryColor => currentTheme.primaryColor;
  Color get accentColor => currentTheme.accentColor;
  
  // Animation duration getters based on speed
  int get animationDuration {
    switch (_settings.animationSpeed) {
      case AnimationSpeed.slow:
        return 600;
      case AnimationSpeed.normal:
        return 400;
      case AnimationSpeed.fast:
        return 200;
    }
  }
  
  int get backgroundAnimationDuration {
    switch (_settings.animationSpeed) {
      case AnimationSpeed.slow:
        return 30000;
      case AnimationSpeed.normal:
        return 20000;
      case AnimationSpeed.fast:
        return 10000;
    }
  }
  
  // Vibration duration based on intensity
  int get vibrationDuration {
    switch (_settings.vibrationIntensity) {
      case VibrationIntensity.light:
        return 100;
      case VibrationIntensity.medium:
        return 300;
      case VibrationIntensity.strong:
        return 500;
    }
  }
  
  // Update methods
  void updateTheme(ColorTheme theme) {
    _settings = _settings.copyWith(selectedTheme: theme);
    notifyListeners();
  }
  
  void toggleDarkMode() {
    _settings = _settings.copyWith(isDarkMode: !_settings.isDarkMode);
    notifyListeners();
  }
  
  void toggleVibration() {
    _settings = _settings.copyWith(enableVibration: !_settings.enableVibration);
    if (_settings.enableVibration) {
      AppUtils.provideVibration(duration: vibrationDuration);
    }
    notifyListeners();
  }
  
  void toggleHapticFeedback() {
    _settings = _settings.copyWith(enableHapticFeedback: !_settings.enableHapticFeedback);
    if (_settings.enableHapticFeedback) {
      AppUtils.provideHapticFeedback(HapticIntensity.medium);
    }
    notifyListeners();
  }
  
  void updateVibrationIntensity(VibrationIntensity intensity) {
    _settings = _settings.copyWith(vibrationIntensity: intensity);
    if (_settings.enableVibration) {
      AppUtils.provideVibration(duration: vibrationDuration);
    }
    notifyListeners();
  }
  
  void updateMaxParticipants(int max) {
    _settings = _settings.copyWith(maxParticipants: max);
    notifyListeners();
  }
  
  void updateFingerSize(double size) {
    _settings = _settings.copyWith(fingerSize: size);
    notifyListeners();
  }
  
  void toggleSoundEffects() {
    _settings = _settings.copyWith(enableSoundEffects: !_settings.enableSoundEffects);
    notifyListeners();
  }
  
  void updateAnimationSpeed(AnimationSpeed speed) {
    _settings = _settings.copyWith(animationSpeed: speed);
    notifyListeners();
  }
  
  void toggleParticipantNumbers() {
    _settings = _settings.copyWith(showParticipantNumbers: !_settings.showParticipantNumbers);
    notifyListeners();
  }
  
  void toggleInstructions() {
    _settings = _settings.copyWith(showInstructions: !_settings.showInstructions);
    notifyListeners();
  }
  
  void toggleBackgroundAnimation() {
    _settings = _settings.copyWith(enableBackgroundAnimation: !_settings.enableBackgroundAnimation);
    notifyListeners();
  }
  
  // Reset to defaults
  void resetToDefaults() {
    _settings = AppSettings();
    AppUtils.provideHapticFeedback(HapticIntensity.medium);
    notifyListeners();
  }
  
  // Provide feedback based on settings
  void provideHapticFeedback(HapticIntensity intensity) {
    if (_settings.enableHapticFeedback) {
      AppUtils.provideHapticFeedback(intensity);
    }
  }
  
  void provideVibration({int? duration}) {
    if (_settings.enableVibration) {
      AppUtils.provideVibration(duration: duration ?? vibrationDuration);
    }
  }
}
