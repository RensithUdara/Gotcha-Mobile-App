import 'package:flutter/material.dart';
import '../models/finger.dart';
import '../config/app_config.dart';
import '../utils/app_utils.dart';
import '../controllers/settings_controller.dart';
import 'dart:math';

class PeopleController extends ChangeNotifier {
  final SettingsController settingsController;
  final List<Finger> fingers = [];
  int? selectedIndex;
  bool picking = false;
  String instructionText = "Tap and hold with multiple fingers to add participants!";
  bool showInstructions = true;

  PeopleController({required this.settingsController});

  void addFinger(BuildContext context, DragDownDetails details) {
    if (fingers.length >= settingsController.settings.maxParticipants || picking) return;
    
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset pos = box.globalToLocal(details.globalPosition);
    
    // Check if finger is not too close to existing fingers
    bool tooClose = fingers.any((finger) => 
      AppUtils.calculateDistance(finger.position, pos) < AppConfig.minFingerDistance
    );
    
    if (!tooClose) {
      fingers.add(Finger(
        position: pos, 
        color: settingsController.fingerColors[fingers.length % settingsController.fingerColors.length],
        id: fingers.length + 1
      ));
      
      if (showInstructions && fingers.length >= 2) {
        instructionText = "Great! Now tap 'Pick Random' to select a winner!";
      } else if (showInstructions && fingers.length == 1) {
        instructionText = "Add more fingers to start picking!";
      }
      
      // Haptic feedback
      settingsController.provideHapticFeedback(HapticIntensity.light);
      notifyListeners();
    }
  }

  void removeFinger() {
    if (picking) return;
    if (fingers.isNotEmpty) {
      fingers.removeLast();
      
      if (fingers.length < 2) {
        instructionText = "Add more fingers to start picking!";
      }
      
      settingsController.provideHapticFeedback(HapticIntensity.light);
      notifyListeners();
    }
  }

  void pickRandom() async {
    if (fingers.length < AppConfig.minParticipants || picking) return;
    
    picking = true;
    showInstructions = false;
    instructionText = "Picking a random winner...";
    notifyListeners();
    
    // Animation sequence
    for (int i = 0; i < 5; i++) {
      selectedIndex = Random().nextInt(fingers.length);
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 200));
    }
    
    // Final selection
    await Future.delayed(Duration(milliseconds: 500));
    selectedIndex = Random().nextInt(fingers.length);
    instructionText = "Winner selected! 🎉";
    notifyListeners();
    
    // Vibration and haptic feedback
    settingsController.provideVibration();
    settingsController.provideHapticFeedback(HapticIntensity.heavy);
    
    // Show winner for 2 seconds
    await Future.delayed(Duration(seconds: 2));
    
    // Remove non-winners
    final winnerFinger = fingers[selectedIndex!];
    fingers.clear();
    fingers.add(winnerFinger);
    selectedIndex = 0;
    
    instructionText = "🏆 Winner! Tap reset to play again.";
    notifyListeners();
    
    picking = false;
    notifyListeners();
  }

  void reset() {
    fingers.clear();
    selectedIndex = null;
    picking = false;
    showInstructions = true;
    instructionText = "Tap and hold with multiple fingers to add participants!";
    settingsController.provideHapticFeedback(HapticIntensity.medium);
    notifyListeners();
  }

  List<Widget> buildFingerWidgets() {
    return [
      for (int i = 0; i < fingers.length; i++)
        AnimatedPositioned(
          duration: Duration(milliseconds: settingsController.animationDuration),
          curve: Curves.elasticOut,
          left: fingers[i].position.dx - (settingsController.settings.fingerSize / 2),
          top: fingers[i].position.dy - (settingsController.settings.fingerSize / 2),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: selectedIndex == null || selectedIndex == i ? 1 : 0.3,
            child: AnimatedContainer(
              duration: Duration(milliseconds: settingsController.animationDuration),
              curve: Curves.elasticOut,
              width: selectedIndex == i ? settingsController.settings.fingerSize + 10 : settingsController.settings.fingerSize,
              height: selectedIndex == i ? settingsController.settings.fingerSize + 10 : settingsController.settings.fingerSize,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    fingers[i].color.withOpacity(0.8),
                    fingers[i].color,
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: fingers[i].color.withOpacity(0.4),
                    blurRadius: selectedIndex == i ? 30 : 15,
                    spreadRadius: selectedIndex == i ? 10 : 5,
                  ),
                ],
                border: selectedIndex == i 
                  ? Border.all(color: Colors.white, width: 4)
                  : null,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Participant number
                  if (settingsController.settings.showParticipantNumbers && (selectedIndex != i || !picking))
                    Text(
                      '${fingers[i].id}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  // Winner icon
                  if (selectedIndex == i && !picking)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 40,
                        ),
                        Text(
                          'WINNER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  // Pulse animation during picking
                  if (picking && selectedIndex == i)
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.7),
                          width: 3,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
    ];
  }
}
