import 'package:flutter/material.dart';
import '../models/finger.dart';
import 'dart:math';
import 'package:vibration/vibration.dart';

class PeopleController extends ChangeNotifier {
  final List<Finger> fingers = [];
  int? selectedIndex;
  bool picking = false;

  void addFinger(BuildContext context, DragDownDetails details) {
    if (fingers.length >= 6 || picking) return;
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset pos = box.globalToLocal(details.globalPosition);
    fingers.add(Finger(position: pos, color: Finger.colors[fingers.length]));
    notifyListeners();
  }

  void removeFinger() {
    if (picking) return;
    if (fingers.isNotEmpty) {
      fingers.removeLast();
      notifyListeners();
    }
  }

  void pickRandom() async {
    if (fingers.length < 2 || picking) return;
    picking = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 700));
    selectedIndex = Random().nextInt(fingers.length);
    notifyListeners();
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 400);
    }
    await Future.delayed(Duration(seconds: 1));
    fingers.removeWhere((f) => fingers.indexOf(f) != selectedIndex);
    notifyListeners();
    picking = false;
  }

  void reset() {
    fingers.clear();
    selectedIndex = null;
    picking = false;
    notifyListeners();
  }

  List<Widget> buildFingerWidgets() {
    return [
      for (int i = 0; i < fingers.length; i++)
        AnimatedPositioned(
          duration: Duration(milliseconds: 400),
          left: fingers[i].position.dx - 40,
          top: fingers[i].position.dy - 40,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: selectedIndex == null || selectedIndex == i ? 1 : 0.2,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              width: selectedIndex == i ? 90 : 80,
              height: selectedIndex == i ? 90 : 80,
              decoration: BoxDecoration(
                color: fingers[i].color,
                shape: BoxShape.circle,
                boxShadow: [
                  if (selectedIndex == i)
                    BoxShadow(
                      color: fingers[i].color.withOpacity(0.6),
                      blurRadius: 24,
                      spreadRadius: 8,
                    ),
                ],
              ),
              child: Center(
                child: selectedIndex == i
                    ? Icon(Icons.star, color: Colors.white, size: 40)
                    : null,
              ),
            ),
          ),
        ),
    ];
  }
}
