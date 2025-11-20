import 'package:flutter/material.dart';
import '../../core/models/draw_model.dart';

class DrawCard extends StatelessWidget {
  final Draw draw;
  final VoidCallback onTap;

  const DrawCard({super.key, required this.draw, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        title: Text(draw.name),
        subtitle: Text('Participants: ${draw.participants.length}'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
