# gotcha_mobile_app

# Gotcha Random Picker 🎲

A beautiful and intuitive random picker app for groups, built with Flutter. Perfect for making decisions, choosing winners, or picking who goes first!

## ✨ Features

### 🎨 Beautiful UI Design
- **Multiple Color Themes**: Choose from 7 stunning gradient themes (Purple Dream, Ocean Blue, Nature Green, Sunset Orange, Pink Paradise, Teal Waves, Fire Red)
- **Dynamic Theme System**: Instantly switch themes with live preview
- **Modern Design**: Clean, professional interface with smooth animations
- **Responsive Layout**: Works perfectly on different screen sizes
- **Customizable Background**: Toggle animated geometric patterns on/off

### 🔥 Core Functionality
- **Multi-touch Support**: Add up to 10 participants (configurable) by touching the screen with multiple fingers
- **Smart Collision Detection**: Prevents fingers from being placed too close together
- **Animated Selection**: Exciting animation sequence when picking a winner with configurable speed
- **Visual Feedback**: Clear participant numbering and winner highlighting (toggleable)
- **Customizable Finger Size**: Adjust participant circle size from 60px to 120px

### ⚙️ Comprehensive Settings
- **Appearance Settings**:
  - Color theme selection with 7 predefined themes
  - Background animation toggle
  - Dark mode support (coming soon)
  
- **Feedback Settings**:
  - Vibration control with intensity levels (Light/Medium/Strong)
  - Haptic feedback toggle
  - Sound effects (coming soon)
  
- **Game Settings**:
  - Maximum participants (2-10)
  - Finger/circle size adjustment
  - Animation speed (Slow/Normal/Fast)
  
- **Interface Settings**:
  - Show/hide participant numbers
  - Show/hide instruction text
  - Background animation control

### 📱 User Experience
- **Haptic Feedback**: Customizable vibration and tactile feedback for better interaction
- **Real-time Instructions**: Dynamic instructions that guide users through the process
- **Participant Counter**: Shows current number of participants with configurable maximum
- **Easy Reset**: One-tap reset to start over with confirmation
- **Settings Persistence**: All settings are maintained across app sessions

### 🎯 Animations & Effects
- **Configurable Speed**: Choose between slow, normal, or fast animations
- **Smooth Transitions**: Fluid animations for all interactions with customizable timing
- **Pulse Effects**: Winner selection with glowing effects
- **Elastic Animations**: Bouncy, satisfying motion curves
- **Background Patterns**: Optional animated geometric patterns

## 🚀 How to Use

### Basic Usage
1. **Add Participants**: Touch and hold the screen with multiple fingers simultaneously
2. **Verify Count**: Check the participant counter shows 2 or more participants
3. **Pick Winner**: Tap the "Pick Random Winner" button
4. **See Results**: Watch the exciting animation as a winner is selected
5. **Reset**: Tap the reset button to start over

### Settings Access
1. **Open Settings**: Tap the settings icon (⚙️) in the top-right corner
2. **Customize Experience**: Adjust colors, feedback, game rules, and interface preferences
3. **Reset to Defaults**: Use the reset button in settings to restore all defaults
4. **Real-time Updates**: Changes apply immediately without restarting the app

## 🛠️ Technical Features

### Architecture
- **MVC Pattern**: Clean separation of concerns with Model-View-Controller
- **State Management**: Efficient state management with ChangeNotifier pattern
- **Settings System**: Comprehensive settings controller with real-time updates
- **Custom Widgets**: Reusable custom widgets for consistent UI

### Performance
- **Optimized Rendering**: Efficient widget building and updates with AnimatedBuilder
- **Smooth Animations**: 60fps animations with proper animation controllers
- **Memory Efficient**: Smart widget lifecycle management and animation disposal
- **Configurable Performance**: Adjust animation speeds for different device capabilities

### Accessibility
- **Touch Friendly**: Large touch targets and intuitive gestures
- **Visual Feedback**: Clear visual indicators for all states
- **Customizable UI**: Adjustable sizes and visual elements
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

### Color Themes
The app includes 7 beautiful predefined themes:
- **Purple Dream**: Deep purples with pink accents
- **Ocean Blue**: Ocean-inspired blues and teals
- **Nature Green**: Fresh greens and earth tones
- **Sunset Orange**: Warm oranges and yellows
- **Pink Paradise**: Vibrant pinks and roses
- **Teal Waves**: Cool teals and cyans
- **Fire Red**: Bold reds and oranges

### Settings Configuration
All settings are stored in `AppSettings` model:
- Theme preferences
- Vibration settings
- Game configuration
- UI preferences

### Adding New Themes
1. Add new theme to `ColorTheme` enum
2. Define colors in `ThemeColors.themes` map
3. Theme automatically appears in settings

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (11.0+)
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🐛 Known Issues

- Sound effects feature is coming soon
- Settings persistence across app restarts (planned)
- Custom color themes (planned)

## 🔮 Future Enhancements

### Settings & Customization
- [ ] Settings persistence with SharedPreferences
- [ ] Custom color theme creator
- [ ] Import/export settings
- [ ] Multiple preset configurations
- [ ] Advanced animation customization

### Features
- [ ] Sound effects with volume control
- [ ] Custom participant names/avatars
- [ ] Different selection algorithms
- [ ] Multiple winner selection
- [ ] Participant history and statistics
- [ ] Timer-based automatic selection

### UI/UX
- [ ] Dark theme implementation
- [ ] Accessibility improvements
- [ ] Landscape mode optimization
- [ ] Tablet-specific layouts
- [ ] Advanced gesture support

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
