import 'package:flutter/material.dart';
import '../controllers/people_controller.dart';

class PeopleScreen extends StatefulWidget {
  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  final PeopleController _controller = PeopleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gotcha Random Picker'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _controller.reset,
          ),
        ],
      ),
      body: GestureDetector(
        onPanDown: (details) => _controller.addFinger(context, details),
        onPanEnd: (details) => _controller.removeFinger(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Stack(
              children: _controller.buildFingerWidgets(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _controller.fingers.length > 1 ? _controller.pickRandom : null,
        label: Text('Pick!'),
        icon: Icon(Icons.casino),
      ),
    );
  }
}
