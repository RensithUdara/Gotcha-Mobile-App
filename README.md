# gotcha_mobile_app

# Gotcha Random Picker 🎲

A beautiful and intuitive random picker app for groups, built with Flutter. Perfect for making decisions, choosing winners, or picking who goes first!

## ✨ Features

### 🎨 Beautiful UI Design
- **Gradient Background**: Eye-catching animated gradient background with subtle patterns
- **Modern Design**: Clean, professional interface with smooth animations
- **Responsive Layout**: Works perfectly on different screen sizes
- **Dark Theme Support**: Beautiful color scheme that's easy on the eyes

### 🔥 Core Functionality
- **Multi-touch Support**: Add up to 6 participants by touching the screen with multiple fingers
- **Smart Collision Detection**: Prevents fingers from being placed too close together
- **Animated Selection**: Exciting animation sequence when picking a winner
- **Visual Feedback**: Clear participant numbering and winner highlighting

### 📱 User Experience
- **Haptic Feedback**: Vibration and tactile feedback for better interaction
- **Real-time Instructions**: Dynamic instructions that guide users through the process
- **Participant Counter**: Shows current number of participants (max 6)
- **Easy Reset**: One-tap reset to start over

### 🎯 Animations & Effects
- **Smooth Transitions**: Fluid animations for all interactions
- **Pulse Effects**: Winner selection with glowing effects
- **Elastic Animations**: Bouncy, satisfying motion curves
- **Background Patterns**: Subtle animated geometric patterns

## 🚀 How to Use

1. **Add Participants**: Touch and hold the screen with multiple fingers simultaneously
2. **Verify Count**: Check the participant counter shows 2 or more participants
3. **Pick Winner**: Tap the "Pick Random Winner" button
4. **See Results**: Watch the exciting animation as a winner is selected
5. **Reset**: Tap the reset button to start over

## 🛠️ Technical Features

### Architecture
- **MVC Pattern**: Clean separation of concerns with Model-View-Controller
- **State Management**: Efficient state management with ChangeNotifier
- **Custom Widgets**: Reusable custom widgets for consistent UI

### Performance
- **Optimized Rendering**: Efficient widget building and updates
- **Smooth Animations**: 60fps animations with proper animation controllers
- **Memory Efficient**: Smart widget lifecycle management

### Accessibility
- **Touch Friendly**: Large touch targets and intuitive gestures
- **Visual Feedback**: Clear visual indicators for all states
- **Error Handling**: Graceful handling of edge cases

## 📋 Requirements

- Flutter SDK 3.0.0 or higher
- Dart SDK 2.17.0 or higher
- Android API level 21+ / iOS 11.0+

## 🔧 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  vibration: ^1.7.4        # For haptic feedback
  device_info_plus: ^9.1.0 # For device information

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0    # For code quality
```

## 🚀 Getting Started

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd gotcha_mobile_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

**Android APK**
```bash
flutter build apk --release
```

**iOS**
```bash
flutter build ios --release
```

**Windows**
```bash
flutter build windows --release
```

## 🎨 Customization

### Colors
The app uses a beautiful gradient color scheme that can be customized in:
- `lib/views/people_screen.dart` - Main background gradient
- `lib/models/finger.dart` - Participant finger colors
- `lib/main.dart` - App theme colors

### Animations
Animation durations and curves can be adjusted in:
- `lib/controllers/people_controller.dart` - Selection animations
- `lib/views/people_screen.dart` - UI transition animations

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (11.0+)
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🐛 Known Issues

- Maximum of 6 participants to ensure good user experience
- Requires multi-touch capable device for full functionality
- Vibration may not work on all devices/simulators

## 🔮 Future Enhancements

- [ ] Custom participant names
- [ ] Sound effects toggle
- [ ] Different selection animations
- [ ] Participant history
- [ ] Multiple winner selection
- [ ] Custom color themes
- [ ] Export results feature

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Support

If you have any questions or run into issues, please open an issue on GitHub.

---

Made with ❤️ using Flutter

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
