import 'package:flutter/material.dart';
import '../core/models/draw_model.dart';
import '../core/utils/random_utils.dart';
import '../widgets/custom_button.dart';
import 'winner_screen.dart';

class DrawScreen extends StatefulWidget {
  final Draw draw;
  const DrawScreen({super.key, required this.draw});

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  bool _winnersSelected = false;

  void _pickWinners() {
    setState(() {
      widget.draw.winners.addAll(RandomUtils.pickWinners(widget.draw.participants));
      _winnersSelected = true;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => WinnerScreen(winners: widget.draw.winners)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.draw.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Participants: ${widget.draw.participants.length}'),
            const SizedBox(height: 20),
            CustomButton(
              text: _winnersSelected ? 'Winners Selected' : 'Pick Winners',
              onPressed: _winnersSelected ? () {} : _pickWinners,
            ),
          ],
        ),
      ),
    );
  }
}
