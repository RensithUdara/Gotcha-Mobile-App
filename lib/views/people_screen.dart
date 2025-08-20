import 'package:flutter/material.dart';
import '../controllers/people_controller.dart';
import '../controllers/settings_controller.dart';
import '../config/app_config.dart';
import '../views/settings_screen.dart';

class PeopleScreen extends StatefulWidget {
  final SettingsController settingsController;
  
  const PeopleScreen({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen>
    with TickerProviderStateMixin {
  late PeopleController _controller;
  late AnimationController _backgroundController;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _controller = PeopleController(settingsController: widget.settingsController);
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
              Color(0xFFf093fb),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated background pattern
            AnimatedBuilder(
              animation: _backgroundAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: BackgroundPatternPainter(_backgroundAnimation.value),
                  size: Size.infinite,
                );
              },
            ),
            
            // Main content
            SafeArea(
              child: Column(
                children: [
                  // Custom App Bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gotcha',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Random Picker',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.refresh, color: Colors.white, size: 28),
                            onPressed: _controller.reset,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Instructions card
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                _getInstructionIcon(),
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Instructions',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    _controller.instructionText,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  
                  // Participants counter
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Participants',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${_controller.fingers.length}/${AppConfig.maxParticipants}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  
                  // Touch area
                  Expanded(
                    child: GestureDetector(
                      onPanDown: (details) => _controller.addFinger(context, details),
                      onPanEnd: (details) => _controller.removeFinger(),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) {
                            return Stack(
                              children: [
                                // Empty state illustration
                                if (_controller.fingers.isEmpty)
                                  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.touch_app,
                                          size: 80,
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Touch and hold here\nwith multiple fingers',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.7),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                
                                // Finger widgets
                                ..._controller.buildFingerWidgets(),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  
                  // Bottom action area
                  Container(
                    padding: EdgeInsets.all(20),
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) {
                        bool canPick = _controller.fingers.length >= AppConfig.minParticipants && !_controller.picking;
                        
                        return Column(
                          children: [
                            // Pick button
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: canPick ? _controller.pickRandom : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: canPick 
                                    ? Colors.white 
                                    : Colors.white.withOpacity(0.3),
                                  foregroundColor: canPick 
                                    ? Color(0xFF667eea) 
                                    : Colors.white.withOpacity(0.5),
                                  elevation: canPick ? 8 : 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (_controller.picking)
                                      Container(
                                        width: 20,
                                        height: 20,
                                        margin: EdgeInsets.only(right: 10),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Color(0xFF667eea),
                                          ),
                                        ),
                                      )
                                    else
                                      Icon(Icons.casino, size: 24),
                                    SizedBox(width: 10),
                                    Text(
                                      _controller.picking ? 'Picking...' : 'Pick Random Winner',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            SizedBox(height: 10),
                            
                            // Status text
                            Text(
                              _getStatusText(),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getInstructionIcon() {
    if (_controller.fingers.length == 0) return Icons.touch_app;
    if (_controller.fingers.length == 1) return Icons.add;
    if (_controller.picking) return Icons.casino;
    if (_controller.selectedIndex != null && !_controller.picking) return Icons.emoji_events;
    return Icons.play_arrow;
  }

  String _getStatusText() {
    if (_controller.fingers.length == 0) {
      return "No participants yet";
    } else if (_controller.fingers.length == 1) {
      return "Need at least ${AppConfig.minParticipants} participants to pick";
    } else if (_controller.picking) {
      return "Selecting winner...";
    } else if (_controller.selectedIndex != null && !_controller.picking) {
      return "Winner selected! 🎉";
    } else {
      return "${_controller.fingers.length} participants ready";
    }
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
