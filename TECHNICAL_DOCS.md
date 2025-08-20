# Gotcha Mobile App - Technical Documentation

## Project Structure

```
lib/
├── main.dart                    # App entry point and configuration
├── config/
│   └── app_config.dart         # App constants and configuration
├── controllers/
│   └── people_controller.dart  # Main app logic and state management
├── models/
│   └── finger.dart            # Finger model with position and color
├── utils/
│   └── app_utils.dart         # Utility functions and helpers
├── views/
│   └── people_screen.dart     # Main screen UI implementation
└── widgets/
    ├── animated_button.dart   # Custom animated button widget
    └── custom_widgets.dart    # Reusable UI widgets
```

## Architecture Overview

### MVC Pattern
- **Model**: `Finger` class represents participant data
- **View**: `PeopleScreen` handles UI rendering and user interaction
- **Controller**: `PeopleController` manages app state and business logic

### State Management
- Uses Flutter's built-in `ChangeNotifier` for reactive state management
- Controller notifies listeners when state changes occur
- UI rebuilds automatically when state updates

## Key Features Implementation

### Multi-touch Detection
- `GestureDetector` with `onPanDown` and `onPanEnd` callbacks
- Converts global touch positions to local coordinates
- Collision detection prevents overlapping participants

### Random Selection Algorithm
- Uses Dart's `Random` class for fair selection
- Animation sequence builds suspense before final selection
- Winner highlighting with visual effects

### Responsive Animations
- `AnimationController` for smooth transitions
- `AnimatedContainer`, `AnimatedPositioned`, `AnimatedOpacity`
- Custom curves and timing for natural motion

### Haptic Feedback
- Platform-specific vibration through `vibration` package
- Flutter's `HapticFeedback` for tactile responses
- Different intensities for different interactions

## Performance Optimizations

### Efficient Rendering
- `AnimatedBuilder` for selective widget rebuilds
- Minimal widget tree depth
- Efficient state change notifications

### Memory Management
- Proper disposal of animation controllers
- Lightweight model objects
- Optimized asset usage

## Platform Support

### Android
- Minimum API level 21 (Android 5.0)
- Haptic feedback and vibration support
- Material Design compliance

### iOS
- Minimum iOS 11.0
- Native haptic feedback integration
- Cupertino design elements support

### Desktop & Web
- Windows, macOS, Linux support
- Web compatibility with touch/mouse events
- Responsive layout adaptation

## Configuration Options

All app constants are centralized in `AppConfig`:
- Maximum participants limit
- Animation durations and curves
- Color schemes and themes
- Feature toggles

## Testing Strategy

### Unit Tests
- Model validation
- Controller logic testing
- Utility function verification

### Widget Tests
- UI component testing
- Interaction simulation
- State change validation

### Integration Tests
- End-to-end user flows
- Platform-specific features
- Performance benchmarking

## Build and Deployment

### Development
```bash
flutter run              # Run in debug mode
flutter run --release    # Run in release mode
flutter hot reload       # Hot reload during development
```

### Production Builds
```bash
flutter build apk --release        # Android APK
flutter build appbundle --release  # Android App Bundle
flutter build ios --release        # iOS build
flutter build web --release        # Web build
```

## Customization Guide

### Adding New Colors
Update `Finger.colors` array in `models/finger.dart`

### Modifying Animations
Adjust timing constants in `AppConfig` or animation curves in controllers

### Extending Functionality
- Add new gesture recognizers in `PeopleScreen`
- Implement additional selection algorithms in `PeopleController`
- Create custom widgets in `widgets/` directory

## Performance Monitoring

### Flutter DevTools
- Memory usage tracking
- Animation performance analysis
- Widget rebuild optimization

### Platform Tools
- Android Studio Profiler
- Xcode Instruments
- Chrome DevTools for web

## Common Issues and Solutions

### Touch Detection
- Ensure device supports multi-touch
- Check gesture detector configuration
- Verify coordinate transformations

### Animation Performance
- Monitor frame rates in DevTools
- Optimize widget tree structure
- Use RepaintBoundary for complex animations

### Platform Compatibility
- Test haptic feedback on physical devices
- Verify permission requirements
- Handle platform-specific differences

## Future Enhancements

### Technical Improvements
- State persistence across app restarts
- Custom animation curves
- Advanced gesture recognition
- Performance analytics

### Feature Additions
- Multiple selection modes
- Custom participant avatars
- Sound effect integration
- Accessibility improvements

---

This documentation provides a comprehensive overview of the app's technical implementation and can be used as a reference for future development and maintenance.
