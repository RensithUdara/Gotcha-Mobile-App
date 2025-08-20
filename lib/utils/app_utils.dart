import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter/services.dart';

class AppUtils {
  /// Provides haptic feedback based on the intensity
  static void provideHapticFeedback(HapticIntensity intensity) {
    switch (intensity) {
      case HapticIntensity.light:
        HapticFeedback.lightImpact();
        break;
      case HapticIntensity.medium:
        HapticFeedback.mediumImpact();
        break;
      case HapticIntensity.heavy:
        HapticFeedback.heavyImpact();
        break;
      case HapticIntensity.selection:
        HapticFeedback.selectionClick();
        break;
    }
  }

  /// Provides vibration feedback if available
  static Future<void> provideVibration({int duration = 500}) async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: duration);
    }
  }

  /// Calculates the distance between two points
  static double calculateDistance(Offset point1, Offset point2) {
    return (point1 - point2).distance;
  }

  /// Generates a random color from a predefined palette
  static Color getRandomColor(List<Color> colors) {
    return colors[(DateTime.now().millisecondsSinceEpoch % colors.length)];
  }

  /// Validates if a point is within bounds
  static bool isPointInBounds(Offset point, Size bounds, {double margin = 0}) {
    return point.dx >= margin &&
           point.dy >= margin &&
           point.dx <= bounds.width - margin &&
           point.dy <= bounds.height - margin;
  }

  /// Formats duration to a readable string
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  /// Creates a gradient from a list of colors
  static LinearGradient createGradient(List<Color> colors, {
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    List<double>? stops,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: colors,
      stops: stops,
    );
  }

  /// Creates a radial gradient from a list of colors
  static RadialGradient createRadialGradient(List<Color> colors, {
    AlignmentGeometry center = Alignment.center,
    double radius = 0.5,
    List<double>? stops,
  }) {
    return RadialGradient(
      center: center,
      radius: radius,
      colors: colors,
      stops: stops,
    );
  }

  /// Generates a box shadow with customizable properties
  static List<BoxShadow> createBoxShadow({
    Color color = Colors.black26,
    double blurRadius = 10.0,
    double spreadRadius = 0.0,
    Offset offset = const Offset(0, 5),
  }) {
    return [
      BoxShadow(
        color: color,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        offset: offset,
      ),
    ];
  }

  /// Shows a snackbar with custom styling
  static void showCustomSnackBar(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor),
              SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  /// Converts hex color string to Color object
  static Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF' + hex;
    }
    return Color(int.parse(hex, radix: 16));
  }

  /// Converts Color object to hex string
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  /// Determines if a color is light or dark
  static bool isLightColor(Color color) {
    final double luminance = color.computeLuminance();
    return luminance > 0.5;
  }

  /// Gets contrasting text color for a background color
  static Color getContrastingTextColor(Color backgroundColor) {
    return isLightColor(backgroundColor) ? Colors.black : Colors.white;
  }
}

enum HapticIntensity {
  light,
  medium,
  heavy,
  selection,
}
