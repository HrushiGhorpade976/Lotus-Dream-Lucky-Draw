import 'package:flutter/material.dart';

import '../../models/winner.dart';

class WinnerDetailScreen extends StatelessWidget {
  const WinnerDetailScreen({super.key, required this.winner});

  final Winner winner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(winner.participant.username)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              winner.prize,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text('City: ${winner.participant.city}'),
            Text('Mobile: ${winner.participant.mobileNumber}'),
            Text('Video proof URL:'),
            SelectableText(
              winner.videoUrl,
              style: const TextStyle(color: Colors.indigo),
            ),
            const SizedBox(height: 24),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepOrange],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 64,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
