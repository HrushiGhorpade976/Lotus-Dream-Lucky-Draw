import 'package:flutter/material.dart';
import 'package:fortune_wheel/fortune_wheel.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';

class SpinWheelScreen extends StatelessWidget {
  const SpinWheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Lucky Draw Wheel")),
      body: Column(
        children: [
          Expanded(
            child: FortuneWheel(
              indicators: const [
                FortuneIndicator(
                  alignment: Alignment.topCenter,
                  child: Icon(Icons.arrow_drop_down, size: 50),
                )
              ],
              selected: app.spinController.stream,
              items: [
                for (final segment in app.wheelSegments)
                  FortuneItem(child: Text(segment))
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final idx = DateTime.now().millisecond %
                  app.wheelSegments.length;
              app.spin(idx);
            },
            child: const Text("SPIN"),
          )
        ],
      ),
    );
  }
}
