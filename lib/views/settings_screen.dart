import 'package:flutter/material.dart';
import '../controllers/settings_controller.dart';
import '../models/app_settings.dart';
import '../utils/app_utils.dart';

class SettingsScreen extends StatefulWidget {
  final SettingsController settingsController;
  
  const SettingsScreen({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: Duration(milliseconds: widget.settingsController.backgroundAnimationDuration),
      vsync: this,
    )..repeat();
    
    _backgroundAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.settingsController,
      builder: (context, _) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.settingsController.gradientColors,
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Animated background pattern
                if (widget.settingsController.settings.enableBackgroundAnimation)
                  AnimatedBuilder(
                    animation: _backgroundAnimation,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: BackgroundPatternPainter(_backgroundAnimation.value),
                        size: Size.infinite,
                      );
                    },
                  ),
                
                SafeArea(
                  child: Column(
                    children: [
                      // Custom App Bar
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back, color: Colors.white, size: 24),
                                onPressed: () {
                                  widget.settingsController.provideHapticFeedback(HapticIntensity.light);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Settings',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Customize your experience',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.refresh, color: Colors.white, size: 24),
                                onPressed: () {
                                  _showResetDialog(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Settings content
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            _buildSection(
                              title: 'Appearance',
                              icon: Icons.palette,
                              children: [
                                _buildColorThemeSelector(),
                                _buildSwitchTile(
                                  title: 'Background Animation',
                                  subtitle: 'Enable animated background patterns',
                                  icon: Icons.animation,
                                  value: widget.settingsController.settings.enableBackgroundAnimation,
                                  onChanged: (_) => widget.settingsController.toggleBackgroundAnimation(),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 20),
                            
                            _buildSection(
                              title: 'Feedback',
                              icon: Icons.vibration,
                              children: [
                                _buildSwitchTile(
                                  title: 'Vibration',
                                  subtitle: 'Enable vibration feedback',
                                  icon: Icons.vibration,
                                  value: widget.settingsController.settings.enableVibration,
                                  onChanged: (_) => widget.settingsController.toggleVibration(),
                                ),
                                _buildSwitchTile(
                                  title: 'Haptic Feedback',
                                  subtitle: 'Enable tactile responses',
                                  icon: Icons.touch_app,
                                  value: widget.settingsController.settings.enableHapticFeedback,
                                  onChanged: (_) => widget.settingsController.toggleHapticFeedback(),
                                ),
                                _buildVibrationIntensitySelector(),
                              ],
                            ),
                            
                            SizedBox(height: 20),
                            
                            _buildSection(
                              title: 'Game Settings',
                              icon: Icons.games,
                              children: [
                                _buildSliderTile(
                                  title: 'Max Participants',
                                  subtitle: '${widget.settingsController.settings.maxParticipants} participants',
                                  icon: Icons.group,
                                  value: widget.settingsController.settings.maxParticipants.toDouble(),
                                  min: 2,
                                  max: 10,
                                  divisions: 8,
                                  onChanged: (value) => widget.settingsController.updateMaxParticipants(value.round()),
                                ),
                                _buildSliderTile(
                                  title: 'Finger Size',
                                  subtitle: '${widget.settingsController.settings.fingerSize.round()}px',
                                  icon: Icons.adjust,
                                  value: widget.settingsController.settings.fingerSize,
                                  min: 60,
                                  max: 120,
                                  divisions: 12,
                                  onChanged: (value) => widget.settingsController.updateFingerSize(value),
                                ),
                                _buildAnimationSpeedSelector(),
                              ],
                            ),
                            
                            SizedBox(height: 20),
                            
                            _buildSection(
                              title: 'Interface',
                              icon: Icons.dashboard,
                              children: [
                                _buildSwitchTile(
                                  title: 'Show Participant Numbers',
                                  subtitle: 'Display numbers on finger circles',
                                  icon: Icons.format_list_numbered,
                                  value: widget.settingsController.settings.showParticipantNumbers,
                                  onChanged: (_) => widget.settingsController.toggleParticipantNumbers(),
                                ),
                                _buildSwitchTile(
                                  title: 'Show Instructions',
                                  subtitle: 'Display helpful instructions',
                                  icon: Icons.help_outline,
                                  value: widget.settingsController.settings.showInstructions,
                                  onChanged: (_) => widget.settingsController.toggleInstructions(),
                                ),
                                _buildSwitchTile(
                                  title: 'Sound Effects',
                                  subtitle: 'Play sound during selection (Coming Soon)',
                                  icon: Icons.volume_up,
                                  value: widget.settingsController.settings.enableSoundEffects,
                                  onChanged: null, // Disabled for now
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              SizedBox(width: 15),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required void Function(bool)? onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: Colors.white.withOpacity(0.3),
            inactiveThumbColor: Colors.white.withOpacity(0.5),
            inactiveTrackColor: Colors.white.withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required void Function(double) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white.withOpacity(0.3),
              thumbColor: Colors.white,
              overlayColor: Colors.white.withOpacity(0.2),
              valueIndicatorColor: Colors.white,
              valueIndicatorTextStyle: TextStyle(
                color: widget.settingsController.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorThemeSelector() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.color_lens, color: Colors.white, size: 24),
              SizedBox(width: 15),
              Text(
                'Color Theme',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ColorTheme.values.where((theme) => theme != ColorTheme.custom).map((theme) {
              final themeColors = ThemeColors.themes[theme]!;
              final isSelected = widget.settingsController.settings.selectedTheme == theme;
              
              return GestureDetector(
                onTap: () {
                  widget.settingsController.updateTheme(theme);
                  widget.settingsController.provideHapticFeedback(HapticIntensity.light);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: themeColors.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: isSelected 
                      ? Border.all(color: Colors.white, width: 3)
                      : Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                    boxShadow: isSelected 
                      ? [BoxShadow(color: Colors.white.withOpacity(0.3), blurRadius: 8, spreadRadius: 2)]
                      : null,
                  ),
                  child: isSelected 
                    ? Icon(Icons.check, color: Colors.white, size: 24)
                    : null,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Text(
            widget.settingsController.currentTheme.name,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVibrationIntensitySelector() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.settings_input_component, color: Colors.white, size: 24),
              SizedBox(width: 15),
              Text(
                'Vibration Intensity',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: VibrationIntensity.values.map((intensity) {
              final isSelected = widget.settingsController.settings.vibrationIntensity == intensity;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.settingsController.updateVibrationIntensity(intensity);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected 
                        ? Colors.white.withOpacity(0.3)
                        : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: isSelected 
                        ? Border.all(color: Colors.white, width: 2)
                        : Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                    ),
                    child: Text(
                      intensity.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationSpeedSelector() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.speed, color: Colors.white, size: 24),
              SizedBox(width: 15),
              Text(
                'Animation Speed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: AnimationSpeed.values.map((speed) {
              final isSelected = widget.settingsController.settings.animationSpeed == speed;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.settingsController.updateAnimationSpeed(speed);
                    widget.settingsController.provideHapticFeedback(HapticIntensity.light);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected 
                        ? Colors.white.withOpacity(0.3)
                        : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: isSelected 
                        ? Border.all(color: Colors.white, width: 2)
                        : Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                    ),
                    child: Text(
                      speed.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Reset Settings',
          style: TextStyle(
            color: widget.settingsController.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to reset all settings to their default values?',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.settingsController.resetToDefaults();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.settingsController.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class BackgroundPatternPainter extends CustomPainter {
  final double progress;
  
  BackgroundPatternPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final spacing = 40.0;
    final offset = progress * spacing;

    // Draw diagonal grid
    for (double i = -spacing; i < size.width + spacing; i += spacing) {
      canvas.drawLine(
        Offset(i - offset, 0),
        Offset(i - offset + size.height, size.height),
        paint,
      );
    }

    for (double i = -spacing; i < size.width + spacing; i += spacing) {
      canvas.drawLine(
        Offset(i + offset, 0),
        Offset(i + offset - size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
