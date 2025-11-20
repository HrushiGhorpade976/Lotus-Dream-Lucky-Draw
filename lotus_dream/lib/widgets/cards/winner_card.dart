import 'package:flutter/material.dart';
import '../../core/models/user_model.dart';

class WinnerCard extends StatelessWidget {
  final User winner;

  const WinnerCard({super.key, required this.winner});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: CircleAvatar(child: Text(winner.name[0])),
        title: Text(winner.name),
        subtitle: Text(winner.email),
      ),
    );
  }
}
